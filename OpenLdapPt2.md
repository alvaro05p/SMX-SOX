######

# Como configurar servidor OpenLdap Pt 2



### En la maquina cliente instalaremos los siguientes paquetes:


``` {.example}
sudo apt install libnss-ldap
```

### Una vez hecho esto nos saldrá un menú en la terminal que nos preguntará varias cosas a las quales debermos responder de la siguriente manera:

# 

ldapi                 ldapi:\\ubuntusrv.smx2023.net

distinguished-name    dc=ubuntusrv,dc=smx2023,dc=net

ldap-version          3

Root Database Admin   Yes

LDAP Database Login   No

LDAP Account Root     cn=admin,dc=ubuntusrv,dc=smx2023,dc=net

LDAP Pass             Lin4dm1n

## Una vez hechos esto sencillos pasos pararemos a trabajar a nuestro server

Lo primero es instalarle los siguientes paquetes:

``` {.example}
sudo apt install gnutls-bin ssl-cert
```
Si nos funciona sin problemas usaremos este comando para generar una clave privada para el certificado:

``` {.example}
sudo certtool --generate-privkey --bits 4096 --outfile /etc/ssl/private/mycakey.pem
```

Despues de esto crearemos el siguinete fichero con este contenido:

``` {.example}
/etc/ssl/ca.info
```

cn = smx2023

ca

cert_signing_key

expiration_days = 3650

### Una vez guardemos ese fichero lo que haremos será crear el certificado CA autofirmado: 
(Al poner la contrabarra, la terminal nos permitirá poner varios comando seguidos)

``` {.example}
sudo certtool --generate-self-signed \

>--load-privkey /etc/ssl/private/mycakey.pem \

>--template /etc/ssl/ca.info \

>--outfile /usr/local/share/ca-certificates/mycacert.crt
```

### Para añadirlo usaremos el siguiente comando:

``` {.example}
sudo update-ca-certificates
```
### Ahora creamos el siguiente fichero

``` {.example}
sudo nano /etc/ssl/certs/mycacert.pem
```

### Para despues crear un enlace simbolico con la siguiente ruta:

``` {.example}
sudo certtool --generate-privkey \

--bits 2048 \

--outfile /etc/ldap/ldap01_slapd_key.pem
```

### Si esto funciona correctamente lo que haremos seria crear:

``` {.example}
mkdir /etc/ssl/ldap01.info
```

### Y dentro meteremos el siguiente contenido:
``` {.example}
organization = smx2023
cn = ldap01.example.com
tls_www_server
encryption_key
signing_key
expiration_days = 365
```
### Lo siguiente sera generar el certificado del servidor:

sudo certtool --generate-certificate \
>--load-privkey /etc/ldap/ldap01_slapd_key.pem \
>--load-ca-certificate /etc/ssl/certs/mycacert.pem \
>--load-ca-privkey /etc/ssl/private/mycakey.pem \
>--template /etc/ssl/ldap01.info \
>--outfile /etc/ldap/ldap01_slapd_cert.pem

### Con estos comandos ajustaremos los permisos necesarios.

``` {.example}
sudo chgrp openldap /etc/ldap/ldap01_slapd_key.pem
sudo chmod 0640 /etc/ldap/ldap01_slapd_key.pem
```

### En el fichero   escribiremos este contenido:

dn: cn=config
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/ssl/certs/mycacert.pem
-
add: olcTLSCertificateFile
olcTLSCertificateFile: /etc/ldap/ldap01_slapd_cert.pem
-
add: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/ldap/ldap01_slapd_key.pem

### Ejecutaremos estos comandos que reiniciarian los servicios para que se apliquen los cambios

``` {.example}
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif
```
``` {example}
dapwhoami -x -H ldaps://ldap01.example.com
```
(despues de ejecutar este conmando nos deberia responder con "Anonymous")

# Certificado para una réplica de OpenLDAP

### Meteremos los certificados en un directorio que llamaremos "slap02-ssl"

``` {.example}
mkdir ldap02-ssl
cd ldap02-ssl
certtool --generate-privkey \
--bits 2048 \
--outfile ldap02_slapd_key.pem
```
Despues de esto creamos el archivo de configuración ldap02.info y escribimos esto en el:

``` {.example}
organization = Example Company
cn = ldap02.example.com
tls_www_server
encryption_key
signing_key
expiration_days = 365
```

Creamos el certificado del cliente:


``` {.example}
sudo certtool --generate-certificate \
--load-privkey ldap02_slapd_key.pem \
--load-ca-certificate /etc/ssl/certs/mycacert.pem \
--load-ca-privkey /etc/ssl/private/mycakey.pem \
--template ldap02.info \
--outfile ldap02_slapd_cert.pem
```

Copiamos el certificado CA

``` {.example}
cp /etc/ssl/certs/mycacert.pem .
```

Y ahora volvemos a reiniciar el servicio:

``` {.example}
ldapwhoami -x -H ldaps://ldap02.example.com
```
``` {.example}
```
# Para instalar SSSD deberemos instalar los siguientes paquetes:

``` {.example}
sssd libpam-sss libnss-sss
```
Le creamos un archivo de configuración:
``` {.example}
/etc/sssd/sssd.conf
```

Esta sera la configuracion que tendremos que pegar:

``` {.example}
sssd libpam-sss libnss-sss
[sssd]

services = nss, pam, ifp

config_file_version = 2

domains = smx2023.net

[nss]

filter_groups = root

filter_users = root

reconnection_retries = 3

[domain/smx2023.net]

ldap_id_use_start_tls = True

cache_credentials = True

ldap_search_base = dc=ubuntusrv, dc=smx2023,dc=net

id_provider = ldap

debug_level = 3

auth_provider = ldap

chpass_provider = ldap

access_provider = ldap

ldap_schema = rfc2307

ldap_uri = ldap://ubuntusrv.smx2023.net

ldap_default_bind_dn = cn=admin,dc=ubuntusrv,dc=smx2023,dc=net

ldap_id_use_start_tls = true

ldap_default_authtok = Lin4dm1n

ldap_tls_reqcert = demand

ldap_tls_cacert = /etc/ssl/certs/ldapcacert.crt

ldap_tls_cacertdir = /etc/ssl/certs

ldap_search_timeout = 50

ldap_network_timeout = 60

ldap_access_order = filter

ldap_access_filter = (objectClass=posixAccount)

ldap_user_search_base = cn=goblins,dc=ubuntusrv,dc=smx2023,dc=net

ldap_user_object_class = inetOrgPerson

ldap_user_gecos = cn

enumerate = True

debug_level = 0x3ff0

```

Le haremos un Chown y le daremos los permisos 0600


Y reiniciaremos el servicio con 


``` {.example}
systemctl restart sssd
```

``` {.example}
systemctl status sssd
systemctl enable sssd
```

Comprobaremos si funciona y habilitaremos el servicio

``` {.example}
systemctl status sssd
systemctl enable sssd
```

Editamos el siguiente archivo:
``` {.example}
/etc/pam.d/common-session
```

Y la configuración sera asi:

``` {.example}
session required        pam_mkhomedir.so skel=/etc/skel/ umask=0022
```

#Para comprobar si funciona:

``` {.example}
getent passwd goblin01
```

Gracias por leer mi tuto.
