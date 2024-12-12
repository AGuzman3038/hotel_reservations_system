--PRIMER PASO
--Comenzamos actualizando los paquetes e instalando MariaDB
sudo apt update
--Instalas MariaDB 
sudo apt install mariadb-server
--Se asegura la isntalación
sudo mysql_secure_isntallation

--Ya dentro de MariaDB
--Se inicia sección
sudo mariadb -u root -p

--Se crea una Base de Datos
CREATE DATABASE hotel_reservations;

--Se crea el usuario para acceder a la Base de Datos
CREATE USER 'hotel_user'@'%' IDENTIFIED BY 'ProyectoFinal'; -- password
GRANT ALL PRIVILEGES ON hotel_reservations.* TO 'hotel_user'@'%';
FLUSH PRIVILEGES;

--Luego editarias la configuración del archivo
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf

-- ya dentro del archivo se edita bind-address = 127.0.0.1 y le añades # al inicio
#bind-address = 127.0.0.1

--Luego del cambio reiniciariamos MariaDB
sudo systemctl restart mariadb

--SEGUNDO PASO
--Accederiamos a MariaDB
mysql -u hotel-user -p

--Ingresa la contraseña
--Al estar dentro de MariaDB accederias a la base de datos creada anteriormente
USE hotel_reservations;

--Se procede a crear las tablas
--Tabla de Clientes 
CREATE TABLE clientes (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
direccion VARCHAR(255),
telefono VARCHAR(20),
email VARCHAR(100) NOT NULL UNIQUE,
fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

--Tabla Habitaciones
CREATE TABLE habitaciones (
id INT AUTO_INCREMENT PRIMARY KEY,
numero_habitacion VARCHAR(10) NOT NULL UNIQUE,
tipo VARCHAR(50),
descripcion TEXT,
precio DECIMAL(10,2) NOT NULL,
estado VARCHAR(20) DEFAULT 'Disponible',
imagen VARCHAR(255) -- Ruta a la imagen en el sistema de archivos
);

--Tabla Reservas
CREATE TABLE reservas (
id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT NOT NULL,
habitacion_id INT NOT NULL,
fecha_inicio DATE NOT NULL,
fecha_fin DATE NOT NULL,
estado VARCHAR(20) DEFAULT 'Activa',
fecha_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (cliente_id) REFERENCES clientes(id),
FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id)
);

--Con el siguiente comando te muestra las tablas creadas
SHOW TABLES;

--Describe cada table con el la instrucción
DESCRIBE clientes;
DESCRIBE habitaciones;
DESCRIBE reservas;

--Luego ingresas datos en cada tabla ya creada

--Ingresa los clientes
INSERT INTO clientes (nombre, direccion, telefono, email)
VALUES
('Juan Pérez', 'Calle Falsa 123', '555-1234',
'juan.perez@example.com'),
('María García', 'Avenida Siempre Viva 456', '555-5678',
'maria.garcia@example.com'),
('Carlos López', 'Boulevard de los Sueños 789', '555-9012',
'carlos.lopez@example.com');

--Ingresa las habitaciones 
--En la sección de imagen la sustituí por NULL ya que las imagenes estaran designadas por la página web que creara mi compañero
INSERT INTO habitaciones (numero_habitacion, tipo, descripcion,
precio, estado, imagen)
VALUES
('101', 'Sencilla', 'Habitación sencilla con cama individual',
50.00, 'Disponible', NULL ),
('102', 'Doble', 'Habitación doble con dos camas individuales',
75.00, 'Disponible', NULL ),
('201', 'Matrimonial', 'Habitación matrimonial con cama king
size', 100.00, 'Disponible', NULL ),
('202', 'Suite', 'Suite de lujo con vista al mar', 150.00,
'Disponible', NULL ),
('301', 'Presidencial', 'Habitación presidencial con todas las comodidades',
 250.00, 'Disponible', NULL );
--En esta sección tuve problemas debido a que ingrese la data con la información de las imagenes sin modificarlo, tuve que implementar un comando para actualizar la data ingresada y modificarlo a NULL
UPDATE habitaciones
SET imagen = NULL
WHERE numero_habitacion = 101, 102, 201, 202, 301;

--Ingresa las reservas
INSERT INTO reservas (cliente_id, habitacion_id, fecha_inicio, fecha_fin, estado)
VALUES
(1, 101, '2023-01-15', '2023-01-20', 'Activa'),
(2, 201, '2023-02-01', '2023-02-05', 'Activa'),
(3, 202, '2023-03-10', '2023-03-15', 'Activa');

--En esta sección tuve un inconveniente con el número de las habitaciones ya que estas no estan como se ingresaron en la data anterior, ya que estas llevabas '' en los números ingresados

--En el siguiente paso se crearía el usuario de no estar creado anteriormente, en mi caso ya estaba creado
--Al ya estar creado el siguiente paso sería verificar los privilegios del usuario ya creado
SHOW GRANTS FOR 'hotel_user'@'%'

--Luego de comprobar el usuario en MariaDB, sales con el comando EXIT, al realizar este comprobarias la conexion de este usuario dentro del servidor, pero fuera del MariaDB
mysql -u hotel_user -p hotel_reservations

--En la lección hay instrucciones de como ingresar imagenes de dos maneras la Primera que sería creando un directorio e ingresando las imagenes en este archivo y la segunda opción NO RECOMENDADA que sería ingresando las imágenes a la base de datos.
--OPCIóN 1 creas el directorio
sudo mkdir -p /var/www/html/imagenes_habitaciones

--copiarias las imagenes al directorio
sudo cp /ruta/de/imagenes/*.jpg
/var/www/html/imagenes_habitaciones/

--Estableces permisos
sudo chow -R www-data:www-data
/var/www/html/imagenes_habitaciones

sudo chmod -R 755 /var/www/html/imagenes_habitaciones

--OPCIóN 2 NO RECOMENDADO 
ALTER TABLE habitaciones DROP COLUMN imagen;
ALTER TABLE habitaciones ADD COLUMN imagen LONGBLOB;

--Durante el proceso tuve problemas con sintaxis de código, pero que resolví consultando las lecciones y con ChatGPT










