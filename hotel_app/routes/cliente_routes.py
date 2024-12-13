# Paso 1: Conectar a la Base de Datos
# Utilizamos db.connection para acceder a la base de datos.

from flask import Blueprint, jsonify, request
from models import db
from pymysql.err import IntegirtyError
# Crear el blueprint para las rutas relacionadas con "clientes"
cliente_bp = Blueprint('clientes', __name__)



@cliente_bp.route('/', methods=['POST'])
def create_cliente():
    try:
        # Obtener datos del cliente del request
        data = request.get_json()

        # Validaciones de datos faltantes
        if not data.get('nombre'):
            return jsonify({'message': 'El campo "nombre" es obligatorio'}), 400
        if not data.get('email'):
            return jsonify({'message': 'El campo "email" es obligatorio'}), 400

        # Asignar valores (con valores por defecto si no se incluyen opcionales)
        nombre = data['nombre']
        direccion = data.get('direccion', '')  # Campo opcional
        telefono = data.get('telefono', '')    # Campo opcional
        email = data['email']

        # Insertar datos en la base de datos
        cursor = db.connection.cursor()
        cursor.execute("""
            INSERT INTO clientes (nombre, direccion, telefono, email)
            VALUES (%s, %s, %s, %s)
        """, (nombre, direccion, telefono, email))
        db.connection.commit()

        return jsonify({'message': 'Cliente creado exitosamente'}), 201

    except IntegrityError:
        # Manejo de duplicados (clave única)
        return jsonify({'message': 'El email ya está registrado'}), 400

    except Exception as e:
        # Manejo general de errores
        return jsonify({'error': str(e)}), 500

    finally:
        # Asegurarse de cerrar el cursor
        if 'cursor' in locals():
            cursor.close()

@cliente_bp.route('/', methods=['GET'])
def get_clientes():
    try:
        # Crear un cursor para interactuar con la base de datos
        cursor = db.connection.cursor()
        cursor.execute("SELECT * FROM clientes")
        rows = cursor.fetchall()
        
        # Construir la lista de clientes
        clientes = []
        for row in rows:
            cliente = {
                'id': row[0],
                'nombre': row[1],
                'direccion': row[2],
                'telefono': row[3],
                'email': row[4],
                'fecha_registro': row[5].strftime('%Y-%m-%d %H:%M:%S') if row[5] else None
            }
            clientes.append(cliente)
        
        # Retornar los datos en formato JSON
        return jsonify(clientes), 200

    except Exception as e:
        # Manejo de errores
        return jsonify({'error': str(e)}), 500

    finally:
        # Cerrar el cursor si existe
        if cursor:
            cursor.close()

# Actualizar un cliente
@cliente_bp.route('/<int:id>', methods=['PUT'])
def update_cliente(id):
    try:
        data = request.get_json()
        nombre = data.get('nombre')
        direccion = data.get('direccion')
        telefono = data.get('telefono')
        email = data.get('email')
        
        cursor = db.connection.cursor()
        cursor.execute("""
            UPDATE clientes
            SET nombre = %s, direccion = %s, telefono = %s, email = %s
            WHERE id = %s
        """, (nombre, direccion, telefono, email, id))
        db.connection.commit()
        
        return jsonify({'message': 'Cliente actualizado exitosamente'}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

    finally:
        if cursor:
            cursor.close()

# Eliminar un cliente
@cliente_bp.route('/<int:id>', methods=['DELETE'])
def delete_cliente(id):
    try:
        cursor = db.connection.cursor()
        cursor.execute("DELETE FROM clientes WHERE id = %s", (id,))
        db.connection.commit()
        
        return jsonify({'message': 'Cliente eliminado exitosamente'}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

    finally:
        if cursor:
            cursor.close()