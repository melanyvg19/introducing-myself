document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('login-button').addEventListener('click', () => {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

    
        fetch('http://localhost:5500/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ username, password }),
        })
        .then(response => response.json())
        .then(data => {
            const messageDiv = document.getElementById('message');
    
            if (data.message === 'Autenticación exitosa') {
                window.location.href = "principal.html";
            } else {
                messageDiv.textContent = 'Nombre de usuario o contraseña incorrectos';
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });
});

function goBack() {
    window.history.back();
}
  
  