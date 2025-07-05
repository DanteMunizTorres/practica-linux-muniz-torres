# Práctica de Sistemas Operativos - Dante Muniz Torres

## 📝 Descripción del Proyecto

Este repositorio contiene el desarrollo de la práctica de Sistemas Operativos, cuyo objetivo fue aplicar conceptos fundamentales de administración de sistemas Linux en un entorno virtualizado.

Las tecnologías clave utilizadas en este proyecto son:
* **Virtualización:** Vagrant y VirtualBox
* **Control de Versiones:** Git y GitHub
* **Contenerización:** Docker y Docker Compose
* **Sistema Operativo:** Ubuntu 22.04 LTS

---

## 📂 Estructura del Repositorio

El proyecto se organiza de la siguiente manera, con cada carpeta conteniendo los entregables de los ejercicios correspondientes:

practica-linux-muniz-torres/
├── README.md
├── crear_reporte_docker.sh
├── git_prueba
├── permisos/
│   ├── usuarios_muniz.txt
│   └── verificacion_permisos.txt
├── neofetch/
│   └── system_info.txt
├── discos/
│   └── verificacion_discos.txt
├── archivos/
│   └── verificacion_archivos.txt
└── contenedores/
    ├── docker-compose.yml
    └── verificacion_contenedores.txt


---

## 🛠️ Configuración del Entorno de Laboratorio

El entorno de trabajo consiste en una máquina virtual Ubuntu 22.04 gestionada por Vagrant.

1.  **Prerrequisitos:** Tener instalado [VirtualBox](https://www.virtualbox.org/) y [Vagrant](https://www.vagrantup.com/).
2.  **Levantar la VM:** Ubicado en la raíz del proyecto, ejecutar el comando `vagrant up`. Esto leerá el `Vagrantfile`, descargará la imagen de Ubuntu y provisionará la máquina virtual con todo el software necesario (Git, Neofetch, Docker).
3.  **Acceso a la VM:** Para conectarse a la máquina, se utiliza el comando `vagrant ssh`.

---

## 🚀 Resumen de Ejercicios Realizados

### Ejercicio 1 y 2: Configuración Inicial y Neofetch
Se inicializó el repositorio en GitHub y se clonó en la máquina virtual. Se configuró la identidad de Git y se creó la estructura de directorios base del proyecto. Posteriormente, se utilizó la herramienta `neofetch` para capturar y guardar la información del sistema en un archivo compartido, simulando un flujo de trabajo colaborativo con `git push` y `git pull`.

### Ejercicio 3: Gestión de Permisos
Se aplicaron conceptos de permisos de Linux. Se crearon usuarios de prueba (`estudiante1`, `estudiante2`, `estudiante3`), un grupo de trabajo (`equipotrabajo`) y se asignaron los usuarios a dicho grupo. Finalmente, se creó un directorio colaborativo (`/tmp/colaborativo`) con permisos `770` para permitir el acceso solo a los miembros del equipo.

### Ejercicio 4: Administración de Discos
Se trabajó con el disco adicional de 1GB añadido a través de Vagrant. El proceso incluyó:
1.  Identificar el disco con `lsblk` (ej. `/dev/sdc`).
2.  Crear una nueva partición primaria con `fdisk`.
3.  Formatear la partición con el sistema de archivos `ext4` usando `mkfs.ext4`.
4.  Crear un punto de montaje (ej. `/mnt/almacenamiento_muniz`).
5.  Montar la partición y asegurar el montaje permanente agregando la configuración al archivo `/etc/fstab`.

### Ejercicio 5: Gestión de Archivos y Directorios
Sobre el nuevo disco ya montado, se crearon y organizaron archivos y directorios utilizando comandos como `mkdir`, `cp`, `mv` y `rm` para simular un flujo de trabajo de gestión de proyectos.

### Ejercicio 6: Contenedores con Docker
Se desplegó un servicio de **Pi-hole** (bloqueador de anuncios a nivel de red) utilizando Docker y Docker Compose. Se creó un archivo `docker-compose.yml` para definir el contenedor, sus puertos, variables de entorno (como la contraseña del panel web) y volúmenes para la persistencia de datos.

---

## 🐛 Desafíos y Soluciones Durante la Práctica

Durante el desarrollo de la práctica surgieron varios desafíos técnicos que requirieron diagnóstico y solución.

### 1. Configuración Inicial del `Vagrantfile`
* **Problema:** Los primeros intentos de levantar la máquina virtual fallaron con errores como `No bootable medium found`.
* **Causa:** La configuración manual del disco adicional a través de comandos `vb.customize` de bajo nivel interfería con el proceso automático de Vagrant para adjuntar el disco principal del sistema operativo.
* **Solución:** Se adoptó el método de alto nivel de Vagrant, utilizando la directiva `config.vm.disk`, la cual gestionó la creación y el adjunto del disco de forma segura y sin conflictos. Se utilizó como base un Vagrant file del equipo_1 aportado por la cátedra de la materia en 2024, también se utilizó IA.

### 2. Problemas de Conexión a Internet (DNS) en la VM
* **Problema:** Comandos como `git clone` y `docker-compose up` fallaban con el error `Could not resolve host`.
* **Causa:** La máquina virtual no podía resolver nombres de dominio.
* **Solución:** Se modificó el archivo /etc/systemd/resolved.conf -> DNS=8.8.8.8 1.1.1.1 y DNSStubListener=no.

### 3. Problemas de Renderizado en la Terminal (Nano)
* **Problema:** Al pegar bloques de texto de múltiples líneas en el editor `nano` a través de SSH, la visualización en la terminal se corrompía, mezclando líneas y agregando espacios.
* **Causa:** Un conflicto visual común entre el emulador de terminal del anfitrión (Windows) y la aplicación `nano` en el invitado (Linux) al procesar un flujo rápido de caracteres.
* **Solución:** Se verificó que el problema era solo visual y que los archivos se guardaban correctamente, confiando en el comando `cat` para ver el contenido real. Como método de trabajo más robusto, se adoptó la creación de **scripts de shell** (ej. `crear_reporte_docker.sh`) para ejecutar secuencias de comandos complejas, evitando los problemas de copiar y pegar en el editor. Casi me mato, porque no podía guardar el resultado del punto 6 (docker)

---

## 🎓 Conclusión

Esta práctica fue un ejercicio integral que cubrió desde la automatización de la infraestructura con Vagrant hasta el despliegue de servicios con Docker. Los desafíos encontrados, especialmente en la configuración de red y la resolución de errores, fueron cruciales para obtener un acercamiento a la práctica de la administración de sistemas Linux en un entorno real.
