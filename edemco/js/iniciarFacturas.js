document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('btn-iniciar').addEventListener('click', function() {
        fetch('http://127.0.0.1:5000/iniciar_facturacion', { method: 'POST' })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error(`Error ${response.status}: ${response.statusText}`);
                }
            })
            .then(message => alert(message))
            .catch(error => alert(error.message));
    });
});

function goBack() {
    window.history.back();
}