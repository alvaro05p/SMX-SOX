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
