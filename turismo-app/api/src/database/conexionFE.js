const mysql = require('mysql');
const fs = require('fs'); // Añadimos la importación de 'fs'

const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'qwerty.12',
  database: 'edemcoprueba',
});

connection.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
    return;
  }

  console.log('Conexión exitosa a la base de datos.');

  const query = 'SELECT * FROM facturacion_especial';

  connection.query(query, (err, results) => {
    if (err) {
      console.error('Error al ejecutar la consulta:', err);
      connection.end();
      return;
    }

    console.log('Consulta exitosa.');

    const dataToSend = {
      workouts: results,
    };

    const filePath = "C:\\Users\\Temp Tech\\OneDrive - Caja de Compensacion Familiar de Antioquia COMFAMA\\Escritorio\\Edemco\\api\\src\\database\\bdFE.json";

    fs.writeFile(filePath, JSON.stringify(dataToSend), (err) => {
      if (err) {
        console.error('Error al escribir datos en el archivo:', err);
      } else {
        console.log('Datos escritos en el archivo exitosamente.');
      }

      connection.end();
    });
  });
});