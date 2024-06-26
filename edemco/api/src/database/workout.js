const fs = require('fs');
const DB = require('./bd.json');

const getAllWorkouts = () => {
    return DB.workouts;
};

const getWorkoutById = (id) => {
    return DB.workouts.find((workout) => workout.id === id);
};

const createWorkout = (newWorkoutData) => {
    const newId = DB.workouts.length + 1;
    const newWorkout = { id: newId, ...newWorkoutData };
    DB.workouts.push(newWorkout);
    saveDB(); // Guarda los cambios en el archivo JSON
    return newWorkout;
};

const updateWorkout = (id, updatedWorkoutData) => {
    const workoutIndex = DB.workouts.findIndex((workout) => workout.id === id);
    if (workoutIndex !== -1) {
        DB.workouts[workoutIndex] = { ...DB.workouts[workoutIndex], ...updatedWorkoutData };
        saveDB(); // Guarda los cambios en el archivo JSON
        return DB.workouts[workoutIndex];
    }
    return null; // Si no se encuentra el entrenamiento.
};

const deleteWorkout = (id) => {
    const workoutIndex = DB.workouts.findIndex((workout) => workout.id === id);
    if (workoutIndex !== -1) {
        const deletedWorkout = DB.workouts.splice(workoutIndex, 1);
        saveDB(); // Guarda los cambios en el archivo JSON
        return deletedWorkout[0];
    }
    return null; // Si no se encuentra el entrenamiento.
};

// Función para guardar los cambios en el archivo JSON
const saveDB = () => {
    fs.writeFileSync('./bd.json', JSON.stringify(DB, null, 2));
};

module.exports = {
    getAllWorkouts,
    getWorkoutById,
    createWorkout,
    updateWorkout,
    deleteWorkout,
};