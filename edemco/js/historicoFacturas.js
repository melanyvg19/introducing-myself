$(document).ready(function () {
    $('#fecha').datepicker({
        format: "mm/yyyy",
        viewMode: "months",
        minViewMode: "months"
    });

    cargarClientes();

    $('#buscar-button').click(function () {
        var clienteSeleccionado = $('#seleccionar-cliente option:selected').val();
        var fechaSeleccionada = $('#fecha').val();
    
        if (clienteSeleccionado !== '' && fechaSeleccionada !== '') {
            cargarFacturas(clienteSeleccionado, fechaSeleccionada);
        }
    });
    

    $('#tablaCliente').on('click', '.descargaPDF', function () {
        var pdfFileName = $(this).data('pdf');
        descargarPDF(pdfFileName);
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
            },
            error: function (error) {
                console.log("Error al cargar los datos de la API: " + error);
            }
        });
    }    

    function cargarFacturas(clienteId, fecha) {
        console.log('Función cargarFacturas se llamó.');
        var fechaSeleccionada = fecha.split('/');
        var mesSeleccionado = fechaSeleccionada[0];
        var anioSeleccionado = fechaSeleccionada[1];
    
        $.ajax({
            url: "../api/src/database/bd.json",
            dataType: "json",
            success: function (data) {
                var tablaCliente = $('#tablaCliente tbody');
                tablaCliente.empty();
    
                var facturasFiltradas = data.workouts.filter(function (factura) {
                    var fechaFactura = new Date(factura.fecha);
                    return (
                        fechaFactura.getMonth() + 1 == mesSeleccionado &&
                        fechaFactura.getFullYear() == anioSeleccionado &&
                        factura.id == clienteId
                    );
                });
    
                if (facturasFiltradas.length > 0) {
                    // Si hay facturas, muestra la tabla
                    $('#tablaCliente').show();
                } else {
                    // Si no hay facturas, oculta la tabla
                    $('#tablaCliente').hide();
                }
    
                facturasFiltradas.forEach(function (factura) {
                    var row = $("<tr>");
                    row.append($("<td>").text(factura.nombre));
                    row.append($("<td>").text(factura.fecha));
                    var btnPDF = $("<button>").addClass("descargaPDF");
                    btnPDF.data('pdf', factura.pdfFileName);
                    btnPDF.append($("<img>").attr("src", "assets/file-earmark-pdf-fill.svg").attr("alt", "pdf").css("height", "2rem"));
                    row.append($("<td>").append(btnPDF));
                    tablaCliente.append(row);
                });
            },
            error: function (error) {
                console.log("Error al cargar los datos de la API: " + error);
            }
        });
    }
    

    function descargarPDF(pdfFileName) {
        var pdfFilePath = "../assets/facturaMdifi.pdf" + pdfFileName;
    
        var downloadLink = document.createElement("a");
        downloadLink.href = pdfFilePath;
        downloadLink.target = "_blank"; // Abre el enlace en una nueva ventana
        downloadLink.download = pdfFileName; // Establece el atributo "download" para el nombre de archivo
    
        downloadLink.click();
    }
});

function goBack() {
    window.history.back();
}

