let routines = JSON.parse(localStorage.getItem("routines")) || [];
let completedWorkouts = JSON.parse(localStorage.getItem("completedWorkouts")) || [];
let editingIndex = -1;

function addOrUpdateExercise() {
    let routineName = document.getElementById("routineName").value;
    let exercise = document.getElementById("exercise").value;
    let durationMinutes = document.getElementById("durationMinutes").value || 0;
    let durationSeconds = document.getElementById("durationSeconds").value || 0;

    if (!routineName || !exercise || (!durationMinutes && !durationSeconds)) {
        alert("Please enter duration in minutes or seconds.");
        return;
    }

    let totalDuration = parseInt(durationMinutes) * 60 + parseInt(durationSeconds);
    let newRoutine = { routineName, exercise, duration: totalDuration };

    if (editingIndex === -1) {
        routines.push(newRoutine);
    } else {
        routines[editingIndex] = newRoutine;
        editingIndex = -1;
    }

    saveAndDisplay();
    clearInputs();
}

function displayRoutine() {
    let list = document.getElementById("routineList");
    list.innerHTML = "";

    routines.forEach((item, index) => {
        let minutes = Math.floor(item.duration / 60);
        let seconds = item.duration % 60;
        let timeText = minutes > 0 ? `${minutes}m ${seconds}s` : `${seconds}s`; // Display seconds properly

        let li = document.createElement("li");
        li.innerHTML = `
            <span><strong>${item.routineName}</strong>: ${item.exercise} - ${timeText}</span>
            <input type="checkbox" class="complete-checkbox" onchange="markCompleted(${index})">
            <button class="edit-btn small-btn" onclick="editRoutine(${index})">✏ Edit</button>
            <button class="delete-btn small-btn" onclick="deleteRoutine(${index})">🗑 Delete</button>
        `;
        list.appendChild(li);
    });
}

function markCompleted(index) {
    let completedRoutine = routines[index];
    let date = new Date().toISOString().split("T")[0];

    let log = { date, exercise: completedRoutine.exercise, duration: completedRoutine.duration };
    completedWorkouts.push(log);
    localStorage.setItem("completedWorkouts", JSON.stringify(completedWorkouts));
}

function deleteRoutine(index) {
    if (confirm("Are you sure you want to delete this routine?")) {
        routines.splice(index, 1);  // Now correctly removes the routine
        saveAndDisplay();
    }
}

function saveAndDisplay() {
    localStorage.setItem("routines", JSON.stringify(routines));
    displayRoutine();
}

window.onload = displayRoutine;
