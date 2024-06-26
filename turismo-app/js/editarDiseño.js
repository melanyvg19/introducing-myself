$(document).ready(function () {
    
    cargarClientes(); // Llama a la función para cargar los clientes al iniciar la página

    $('#buscar-button').click(function () {
        console.log("Botón de búsqueda clickeado.");
        var clienteSeleccionado = $('#seleccionar-cliente').val();

        if (clienteSeleccionado !== '') {
            console.log("Cliente seleccionado:", clienteSeleccionado);
            cargarDatosCliente(clienteSeleccionado);
        }
    });

    function cargarClientes() {
        $.ajax({
            url: "../api/src/database/bd.json",
            dataType: "json",
            success: function (data) {
                var selectCliente = $('#seleccionar-cliente');
    
                var clienteIds = [];
    
                $.each(data.workouts, function (index, cliente) {
                    if (clienteIds.indexOf(cliente.id) === -1) {
                        clienteIds.push(cliente.id);
                        selectCliente.append($("<option>").val(cliente.id).text(cliente.nombre));
                    }
                });
                console.log("Clientes cargados con éxito.");
            },
            error: function (error) {
                console.log("Error al cargar los datos de la API: " + error);
            }
        });
    }

    function cargarDatosCliente(clienteId) {
        $.ajax({
            url: "../api/src/database/bd.json",
            dataType: "json",
            success: function (data) {
                // Filtra los datos para obtener solo los registros del cliente específico
                var clienteRegistros = data.workouts.filter(cliente => cliente.id === parseInt(clienteId));
    
                // Ordena los registros por fecha en orden descendente (del más reciente al más antiguo)
                clienteRegistros.sort(function(a, b) {
                    return new Date(b.fecha) - new Date(a.fecha);
                });
    
                // Toma el primer registro (el más reciente)
                var clienteData = clienteRegistros[0];
    
                if (clienteData) {
                    llenarCard('generacion-card', clienteData.monthly_energy + " kWh");
                    llenarCard('generacionAcum-card', clienteData.acumulado_monthly_energy + " kWh");
                    llenarCard('valor-card', clienteData.valor_kwh);
                    llenarCard('valorTotal-card', clienteData.valor_total);
                    llenarCard('ahorro-card', clienteData.ahorro_actual);
                    llenarCard('ahorroAcum-card', clienteData.ahorro_acumulado);
                    llenarCard('ahorroCO2-card', clienteData.ahorro_c02);
                    llenarCard('acumuladoCO2-card', clienteData.acumulado_c02);
                    llenarCard('codigoCufe-card', clienteData.codigo_cufe);
                    llenarCard('fechaVen-card', clienteData.fecha_vencimiento);
                    llenarCard('fechaDIAN-card', clienteData.fecha_aceptacion_dian);
                    llenarCard('Nfactura-card', clienteData.factura_numero);
                } else {
                    console.log("No se encontraron datos para el cliente seleccionado.");
                }
            },
            error: function (error) {
                console.log("Error al cargar los datos de la API: " + error);
            }
        });
    }
    
    
    function llenarCard(cardId, valor) {
        console.log("Llenando card:", cardId, "con valor:", valor);
        
        // Utiliza el selector actualizado para modificar el texto
        $("#" + cardId + " .card-body .card-title").text(valor);
    }              
});

function goBack() {
    window.history.back();
}
