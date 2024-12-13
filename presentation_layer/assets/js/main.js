$(document).ready(function() {
    // Verificar si el usuario está autenticado
    var token = localStorage.getItem('token');
    
    if (token) {
        // Cambiar el menú para mostrar opciones de usuario
        $('.navbar-nav').html(`
            <li class="nav-item">
                <a class="nav-link" href="cliente/perfil.html">Mi Perfil</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" id="logout">Cerrar Sesión</a>
            </li>
        `);
        
        // Manejar el cierre de sesión
        $('#logout').click(function() {
            localStorage.removeItem('token');
            window.location.href = 'index.html';
        });
    }
});

// main.js
function includeHTML(file, targetId) {
    fetch(file)
        .then(response => {
            if (!response.ok) throw new Error(`Error al cargar el archivo: ${file}`);
            return response.text();
        })
        .then(data => {
            document.getElementById(targetId).innerHTML = data;
        })
        .catch(error => console.error(error));
}

// Llama a la función cuando el DOM esté listo
document.addEventListener("DOMContentLoaded", () => {
    includeHTML("../presentation_layer/header.html", "header");
});
