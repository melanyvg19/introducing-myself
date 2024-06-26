$(document).ready(function () {
    $('#fecha').datepicker({
        format: "yyyy",
        viewMode: "years",
        minViewMode: "years"
    });

    cargarClientes();

    $('#buscar-button').click(function () {
        var clienteSeleccionado = $('#seleccionar-cliente option:selected').val();
        var yearSeleccionado = $('#fecha').val();

        if (clienteSeleccionado !== '' && yearSeleccionado !== '') {
            cargarDatosCliente(clienteSeleccionado, yearSeleccionado); // Llama a la función para cargar los datos del cliente en la tabla

        }
    });

    function cargarClientes() {
        $.ajax({
            url: "../api/src/database/bdFE.json",
            dataType: "json",
            success: function (data) {
                var selectCliente = $('#seleccionar-cliente');

                var clienteIds = []; // Mantén un registro de los IDs de clientes

                // Recorre los datos de clientes y agrega opciones al select si no se han agregado previamente
                $.each(data.workouts, function (index, cliente) {
                    if (clienteIds.indexOf(cliente.id) === -1) {
                        clienteIds.push(cliente.id); // Agrega el ID al registro
                        selectCliente.append($("<option>").val(cliente.id).text(cliente.nombre));
                    }
                });
            },
            error: function (error) {
                console.log("Error al cargar los datos de la API: " + error);
            }
        });
    }

    function cargarDatosCliente(clienteId, selectedYear) {
    // Realiza la solicitud AJAX para cargar los datos del cliente seleccionado
        $.ajax({
            url: "../api/src/database/bdFE.json",
            dataType: "json",
            success: function (data) {
                var tablaCliente = $('#tablaCliente tbody');
                tablaCliente.empty(); // Limpia la tabla antes de agregar nuevos datos

                $.each(data.workouts, function (index, cliente) {
                // Verifica si la fecha contiene el año seleccionado
                    if (cliente.id === parseInt(clienteId) && cliente.fecha.startsWith(selectedYear)) {
                        var row = $("<tr>");
                        row.append($("<td>").text(cliente.fecha));
                        row.append($("<td>").text(cliente.monthly_energy));
                        row.append($("<td>").text(cliente.Exportacion));
                        row.append($("<td>").text(cliente.consumo));
                        row.append($("<td>").text(cliente.consumo_acumulado));
                        row.append($("<td>").text(cliente.valor_kwh));
                        row.append($("<td>").text(cliente.valor_total_sinexc));
                        row.append($("<td>").text(cliente.tarifa_or));
                        row.append($("<td>").text(cliente.valor_total_conexc));
                        row.append($("<td>").text(cliente.tarifa_edemco));
                        row.append($("<td>").text(cliente.diferencia_tarifa));
                        row.append($("<td>").text(cliente.ahorro_actual));
                        row.append($("<td>").text(cliente.ahorro_acumulado));
                        row.append($("<td>").text(cliente.ahorro_c02));
                        row.append($("<td>").text(cliente.acumulado_co2));
                        tablaCliente.append(row);
                    }
                });

                $('#tablaCliente').show();
            },
            error: function (error) {
                console.log("Error al cargar los datos de la API: " + error);
            }
        });
    }

});

function goBack() {
    window.history.back();
}