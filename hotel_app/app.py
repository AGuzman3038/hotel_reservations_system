from flask import Flask 

app = Flask (__name__)

@app.route('/')
def hello():
	return 'Capa de Logica de Negocio - Flask funcionando'

if __name__ == '__main__':
	app.run(host='0.0.0.0', port=5000)



import pymysql

def get_conncetion():
	connection = pymysql.connect(
		host='172.16.5.255',
		user='hotel_user',
		password='ProyectoFinal',
		db:'hotel_reservations',
		cursorclass= pymysql.cursors.DictCursor
	)
	return connection 
