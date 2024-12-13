# Ejemplo en cliente_routes.py
from flask import Blueprint, jsonify, request
from models import db
cliente_bp = Blueprint('clientes', __name__)
@cliente_bp.route('/', methods=['GET'])
def get_clientes():
cursor = db.connection.cursor()
cursor.execute("SELECT * FROM clientes")
rows = cursor.fetchall()
clientes = []
for row in rows:
cliente = {
'id': row[0],
'nombre': row[1],
'direccion': row[2],
'telefono': row[3],

'email': row[4],
'fecha_registro': row[5].strftime('%Y-%m-%d
%H:%M:%S')
}
clientes.append(cliente)
return jsonify(clientes)
