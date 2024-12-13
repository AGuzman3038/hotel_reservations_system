# routes/auth_routes.py
from flask import Blueprint, render_template, redirect, url_for,
request, flash
from flask_login import login_user, logout_user, login_required
from models import db
from models.cliente import Cliente

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/login', methods=['GET', 'POST'])
def login():

# Manejar el formulario de login
    pass

@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('auth.login'))