Hotel App 

Este proyecto se basa en un sistema que permite hacer reservaciones de hotel.  La aplicación le da la oportunidad al cliente en registrarse, iniciar sesión y reservar habitaciones.  También le da la habilidad a los administradores de poder ofrecer y ver las reservaciones. 

Arquitectura del Proyecto 
La estructura del sistema se organiza en tres capas, cada una desplegada en una máquina virtual (VM) independiente:

1. Capa de Presentación (VM1)
Tecnologías empleadas: HTML, CSS, Boostrap, JQuery.
Servidor Web: NGINX
Propósito: Proveer una interfaz de usuario accesible de fomra externa a través de SERVEO.

2. Capa de Lógica de Negocio (VM2)
Tecnología Utilizada: Python Flask.
Función: Servir como una API RESTFUL que gestiona la lógica de la aplicación y facilita la comunicación con la base de datos.

3. Capa de Datos (VM3)
Tecnología Utilizada: MariaDB.
Rol: Almacenar y gestionar la información relacionada con los clientes, las habitaciones y las reservas.

Requisitos Previos: 
Git: Herramienta para el control de versiones.
Python3: Versión requerida del lenguaje de programación.
Pip: Administrador de paquetes de Python 
NGINX: Servidor web necesario para la capa de Presentación.
MariaDB: Sistema de gestión de bases de datos utilizado.
Acceso a SERVEO: Necesario para hacer la aplicación accesible desde el exterior.

Instalación y Configuración:

Capa de Presentación (VM1)
1. Clonar al repositorio:
   '''bash
   git clone
https://github.com/tu_usuario/hotel_reservations_system.git

Nevegar al directorio de la capa de presentación:
cd Hotel_reservations_system/presentation_layer
configurar NGINX según las instrucciones en presentation_layer/README.md.
ejecutar SERVEO para exponer la aplicación.

Capa de Lógica de Negocio (VM2)
Clonar el repositorio y navegar al directorio correspondiente 
crear un entorno virtual y activar:

python3 -m venv venv
source venv/bin/activate

instalar las dependencias:

pip install -r requirements.txt

configurar las variables de entorno y la conexión a la base de datos.

Ejecutar la aplicación Flask:
python app.py

Capa de Datos (VM3)
1. Clonar el repositorio y navegar a data_layer/.
importar los scripts SQL para crear la base de datos:

mysql -u usuario -p < sql_scripts/create_database.sql

2. Asegurar que la base de datos está configurada y accesible desde VM2.

Autores 
Angeline Guzman - Capa de Datos 
Wesley Rivera - Lógica de Negocio 
Yael Maldonado - Capa de Presentación 

Licencia 
Este proyecto es de uso académico y no cuenta con una licencia especifica.

