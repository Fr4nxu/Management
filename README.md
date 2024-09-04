# Administracion de Sistemas - Scripts Bash

Este repositorio contiene una colección de scripts en Bash para diversas tareas de administración de sistemas en un entorno Linux. Cada script está diseñado para automatizar y facilitar diferentes aspectos del manejo de usuarios, grupos, archivos y sistemas.

## Contenidos

A continuación se presenta una descripción de los scripts del repositorio:

### Gestión de Usuarios y Grupos

- **addusuarios.sh** / **addusuarios2.sh**: Scripts para agregar múltiples usuarios al sistema de manera automatizada.
- **delusuarios.sh**: Elimina usuarios específicos del sistema.
- **addgrupos.sh** / **addgrupos2.sh**: Scripts para crear y gestionar grupos de usuarios.
- **delgrupos.sh**: Elimina grupos de usuarios del sistema.
- **crearusuarios.sh**: Automatiza la creación de usuarios con configuraciones predeterminadas.

### Seguridad y Registro

- **borrar_syslog.sh** / **borrar_syslog2.sh** / **borrar_syslog5.sh**: Scripts para limpiar y gestionar los registros del sistema (`/var/log/syslog`).
- **registro3.sh** / **registro_avanzado.sh** / **registros.sh** / **registros2.sh**: Scripts para la captura y análisis de registros del sistema.
- **vaciar_all_logs.sh**: Vacía todos los archivos de log del sistema.

### Administración de Archivos y Directorios

- **archivosmodificados_dir.sh**: Lista archivos modificados en un directorio específico.
- **comprimirdir.sh**: Comprime un directorio en un archivo `.tar.gz`.
- **contararchivos_dir_actual.sh**: Cuenta el número de archivos en el directorio actual.
- **copiaseguridad_dir.sh** / **copiaseguridad_dir2.sh** / **copiaseguridad_dir_programada.sh**: Scripts para realizar copias de seguridad de directorios, incluyendo opciones programadas.
- **busqueda_extension.sh**: Busca archivos por extensión en un directorio especificado.
- **dir_respaldo.sh**: Realiza un respaldo de un directorio específico.

### Rendimiento y Monitoreo

- **informe_rendimiento.sh**: Genera un informe detallado sobre el rendimiento del sistema.
- **rendimiento.sh** / **rendimiento2.sh**: Scripts para monitorizar y analizar el rendimiento del sistema en tiempo real.
- **deteccionusuario.sh**: Detecta usuarios activos en el sistema.

### Gestión de Paquetes y Red

- **pckinstalado.sh** / **pckinstalado2.sh**: Verifica y muestra los paquetes instalados en el sistema.
- **red_ok.sh**: Verifica el estado de la red y su conectividad.
- **sistema.sh**: Script general para realizar varias tareas de mantenimiento del sistema.

### Otros Scripts

- **menu.sh**: Proporciona una interfaz de menú para ejecutar otros scripts de forma interactiva.

## Uso
### 1. Clonar el repositorio
```bash
git clone https://github.com/Fr4nxu/Management.git
### 2. Acceder al repositorio
```bash
cd Management
### 3. Permisos necesarios
```bash
chmod +x *.sh
### 4. Ejecutar script
```bash
./nombre_del_script.sh

