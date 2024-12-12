// cliente/reservas.html
$(document).ready(function() {
    var token = localStorage.getItem('token');
    
    // Redirigir a la página de inicio de sesión si no hay token
    if (!token) {
        window.location.href = '../login.html';
    }

    // Solicitar las reservas del cliente
    $.ajax({
        url: '/api/reservas/cliente',
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + token
        },
        success: function(data) {
            // Renderizar las reservas en la tabla
            $.each(data, function(index, reserva) {
                var row = `
                    <tr>
                        <td>${reserva.id}</td>
                        <td>${reserva.habitacion_numero}</td>
                        <td>${reserva.fecha_inicio}</td>
                        <td>${reserva.fecha_fin}</td>
                        <td>${reserva.estado}</td>
                    </tr>
                `;
                $('#tabla-reservas tbody').append(row);
            });
            
            // Inicializar DataTable en la tabla
            $('#tabla-reservas').DataTable();
        },
        error: function(error) {
            alert('Error al cargar las reservas');
        }
    });
});