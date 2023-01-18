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

### Una vez hechos esto sencillos pasos pararemos a trabajar a nuestro server

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

Para añadirlo usaremos el siguiente comando:

``` {.example}
sudo update-ca-certificates
```
### Ahora creamos el siguiente fichero

``` {.example}
sudo nano /etc/ssl/certs/mycacert.pem
```

Para despues crear un enlace simbolico con la siguiente ruta:

``` {.example}
sudo certtool --generate-privkey \

--bits 2048 \

--outfile /etc/ldap/ldap01_slapd_key.pem
```

