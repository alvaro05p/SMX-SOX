######

# Como configurar servidor OpenLdap


## Ejecutar los comandos siguientes:


### Instalar el servicio:


``` {.example}
sudo apt install slapd
```

### Buscamos herramienta para administrar slapd

``` {.example}
sudo apt search ldapadmin
```

### Aquí hay que instalar el servicio de Mysql.

``` {.example}
sudo apt install mysql-server
```
### Entre los resultados seleccionaremos el paquete

``` {.example}
sudo apt isntall phpldapadmin
```

### Una vez lo tengamos instalado, abriremos el navegador e introduciremos:

``` {.example}
http://(IP)/phpldapadmin/
```

### En este punto ya podriamos ver la interfaz grafica y ahora tendriamos que arreglar la causa de estos avisos que vemos en pantalla mediante un parche.

![Paso 1](https://github.com/alvaro05p/SMX-SOX/blob/master/caps/markdown1.png)


## Parchear los errores/avisos deprecated

### Descargaremos este archivo que es el parche con wget:

![img2](https://github.com/alvaro05p/SMX-SOX/blob/master/caps/cap2markdown.png)

### Una vez hecho esto descomprimimos el archivo

![img2](https://github.com/alvaro05p/SMX-SOX/blob/master/caps/cap3markdown.png)

### Lo siguiente seria copiar todo lo descompimido a la ruta de la imagen

![img2](https://github.com/alvaro05p/SMX-SOX/blob/master/caps/cap4markdown.png)
##### ¡¡¡ : Añadir /config al final de la ruta

### Por ultimo en este paso debemos cabiarle el nombre a un archivo de la siguiente manera:

![img2](https://github.com/alvaro05p/SMX-SOX/blob/master/caps/cap5markdown.png)

Una vez hecho esto ya no tendriamos errores en la página

Ahora debemos reconfigurar el slapd

``` {.example}
sudo dpkg-reconfigure slapd
```
En el menu que nos sale configuraremos las opciones como dice la tarea.

Y ahora entraremos en este fichero de configuración:

``` {.example}
/etc/phpldapadmin/config.php
```

En este pondremos las ordenes de la linea de DNS segun la configuración del paso anterior.

![Paso 1](https://gitlab.com/aberlanas/SMX-SOX/-/raw/master/Unit04-DomainAdministration/imgs/slapd-10.png)

Y por ultimo debemos crear la estructura de grupos y usuarios con la intefaz grafica ya que nos dejará registrarnos.

Con este comando podremos ver el server sin interfaz gráfica:


``` {.example}
ldapsearch -x -b dc=ubuntusrvXX,dc=smx2023,dc=net -H ldap://192.168.5.140
```
