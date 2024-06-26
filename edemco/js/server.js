const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const app = express();
const port = 5500;

app.use(cors());

const db = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: 'qwerty.12',
    database: 'edemcoprueba'
});

db.connect((err) => {
    if (err) {
        console.error('Error de conexión a la base de datos:', err);
        return;
    }
    console.log('Conexión a la base de datos establecida');
});

app.use(express.json());

app.post('/login', (req, res) => {
    const { username, password } = req.body;

    const sql = "SELECT * FROM usuarios WHERE usuario = ? AND contrasena = ?";
    db.query(sql, [username, password], (err, results) => {
        if (err) {
            console.error('Error al consultar la base de datos:', err);
            res.status(500).json({ message: 'Error en la base de datos' });
            return;
        }

        if (results.length > 0) {
            res.status(200).json({ message: 'Autenticación exitosa' });
        } else {
            res.status(401).json({ message: 'Nombre de usuario o contraseña incorrectos' });
        }
    });
});

app.listen(port, () => {
    console.log(`Servidor en ejecución en el puerto ${port}`);
});








