const express = require('express');
const v1WorkoutRouter = require("./v1/routes/workoutroutes");

const app = express();
const PORT = process.env.PORT || 8080;

app.use("/api/v1/workouts", v1WorkoutRouter);

app.listen(PORT, () => {
    console.log(` 🚀 Servidor escuchando en el puerto ${PORT}`);
});