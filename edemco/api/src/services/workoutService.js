const database = require('../database/bd.json');

const getAllWorkouts = () => {
  // Devuelve directamente los datos del archivo JSON
  return database.workouts; // Asumiendo que los datos están almacenados en una propiedad llamada 'workouts'
};

const getOneWorkout = (workoutId) => {
  // Encuentra el entrenamiento por su ID
  return database.workouts.find(workout => workout.id === workoutId);
};

const createNewWorkout = (newWorkoutData) => {
  // Agrega el nuevo entrenamiento a la lista
  database.workouts.push(newWorkoutData);
  // Guarda los cambios en el archivo JSON (si es necesario)
  // fs.writeFileSync('../database/bd.json', JSON.stringify(database));
  return newWorkoutData; // Devuelve el nuevo entrenamiento creado
};

const updateOneWorkout = (workoutId, updatedWorkoutData) => {
  // Encuentra el entrenamiento por su ID
  const workoutToUpdate = database.workouts.find(workout => workout.id === workoutId);
  if (workoutToUpdate) {
    // Actualiza las propiedades del entrenamiento
    Object.assign(workoutToUpdate, updatedWorkoutData);
    // Guarda los cambios en el archivo JSON (si es necesario)
    // fs.writeFileSync('../database/bd.json', JSON.stringify(database));
    return workoutToUpdate; // Devuelve el entrenamiento actualizado
  } else {
    return null; // Devuelve null si no se encontró el entrenamiento
  }
};

const deleteOneWorkout = (workoutId) => {
  // Encuentra el índice del entrenamiento por su ID
  const index = database.workouts.findIndex(workout => workout.id === workoutId);
  if (index !== -1) {
    // Elimina el entrenamiento del array
    const deletedWorkout = database.workouts.splice(index, 1)[0];
    // Guarda los cambios en el archivo JSON (si es necesario)
    // fs.writeFileSync('../database/bd.json', JSON.stringify(database));
    return deletedWorkout; // Devuelve el entrenamiento eliminado
  } else {
    return null; // Devuelve null si no se encontró el entrenamiento
  }
};

module.exports = {
  getAllWorkouts,
  getOneWorkout,
  createNewWorkout,
  updateOneWorkout,
  deleteOneWorkout,
};