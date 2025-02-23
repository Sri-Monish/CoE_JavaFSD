let completedWorkouts = JSON.parse(localStorage.getItem("completedWorkouts")) || [];
let chartInstance = null;

function updateChart() {
    let selectedDate = document.getElementById("dateFilter").value;
    if (!selectedDate) return;

    let filteredLogs = completedWorkouts.filter(log => log.date === selectedDate);
    let labels = filteredLogs.map(log => log.exercise);
    
    let data = filteredLogs.map(log => {
        let minutes = Math.floor(log.duration / 60);
        let seconds = log.duration % 60;
        return minutes + seconds / 60;  // Display both minutes & seconds
    });

    let ctx = document.getElementById("progressChart").getContext("2d");
    if (chartInstance) chartInstance.destroy();

    chartInstance = new Chart(ctx, {
        type: "bar",
        data: {
            labels: labels,
            datasets: [{
                label: "Duration (min)",
                data: data,
                backgroundColor: labels.map(() => getRandomColor()),
                borderColor: "#333",
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 60, // Limits the height of bars
                    ticks: {
                        stepSize: 5, // Makes it easier to read
                        callback: function(value) {
                            let min = Math.floor(value);
                            let sec = Math.round((value - min) * 60);
                            return sec > 0 ? `${min}m ${sec}s` : `${min}m`;
                        },
                        color: "#333",
                        font: { size: 12 }
                    }
                },
                x: {
                    ticks: { color: "#333", font: { size: 12 } }
                }
            }
        }
    });
}

function getRandomColor() {
    return `rgba(${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, 0.8)`;
}

function resetProgress() {
    if (confirm("Are you sure you want to reset all progress?")) {
        localStorage.removeItem("completedWorkouts");
        completedWorkouts = [];
        updateChart();
    }
}

window.onload = () => {
    document.getElementById("dateFilter").value = new Date().toISOString().split("T")[0];
    updateChart();
};
