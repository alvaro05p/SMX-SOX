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
``` {.example}
### Ejecutaremos este comando y despues reiniciaremos los servicios para que se apliquen los cambios

sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif
```
