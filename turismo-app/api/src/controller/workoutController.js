const workoutService = require("../services/workoutService");


const getAllWorkouts = (req, res) => {
    const allWorkouts = workoutService.getAllWorkouts();
    res.json({ status: "OK", data: allWorkouts });
};

const getOneWorkout = (req, res) => {
    const workoutId = req.params.workoutId;
    const oneWorkout = workoutService.getOneWorkout(workoutId);

    if (oneWorkout) {
        res.json({ status: "OK", data: oneWorkout });
    } else {
        res.status(404).json({ status: "Not Found", message: "Workout not found" });
    }
};

const createNewWorkout = (req, res) => {
    const newWorkoutData = req.body;
    const createdWorkout = workoutService.createNewWorkout(newWorkoutData);
    res.status(201).json({ status: "Created", data: createdWorkout });
};

const updateOneWorkout = (req, res) => {
    const workoutId = req.params.workoutId;
    const updatedWorkoutData = req.body;
    const updatedWorkout = workoutService.updateOneWorkout(workoutId, updatedWorkoutData);

    if (updatedWorkout) {
        res.json({ status: "OK", data: updatedWorkout });
    } else {
        res.status(404).json({ status: "Not Found", message: "Workout not found" });
    }
};

const deleteOneWorkout = (req, res) => {
    const workoutId = req.params.workoutId;
    const deletedWorkout = workoutService.deleteOneWorkout(workoutId);

    if (deletedWorkout) {
        res.json({ status: "OK", message: `Workout ${workoutId} deleted` });
    } else {
        res.status(404).json({ status: "Not Found", message: "Workout not found" });
    }
};

module.exports = {
    getAllWorkouts,
    getOneWorkout,
    createNewWorkout,
    updateOneWorkout,
    deleteOneWorkout,
};