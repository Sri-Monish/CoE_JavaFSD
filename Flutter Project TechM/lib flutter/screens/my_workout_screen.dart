import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class MyWorkoutScreen extends StatefulWidget {
  @override
  _MyWorkoutScreenState createState() => _MyWorkoutScreenState();
}

class _MyWorkoutScreenState extends State<MyWorkoutScreen> {
  final TextEditingController workoutController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  List<Map<String, dynamic>> workouts = [];

  @override
  void initState() {
    super.initState();
    loadWorkouts();
  }

  // Save workouts to local storage
  void saveWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('workouts', jsonEncode(workouts));
  }

  // Load workouts from local storage
  void loadWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('workouts');
    if (data != null) {
      setState(() {
        workouts = List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    }
  }

  void addWorkout() {
    String workoutName = workoutController.text;
    int? duration = int.tryParse(durationController.text);

    if (workoutName.isNotEmpty && duration != null && duration > 0) {
      setState(() {
        workouts.add({
          "name": workoutName,
          "duration": duration,
          "timeLeft": duration
        });
      });
      saveWorkouts();
      workoutController.clear();
      durationController.clear();
    }
  }

  void deleteWorkout(int index) {
    setState(() {
      workouts.removeAt(index);
    });
    saveWorkouts();
  }

  void editWorkout(int index) {
    workoutController.text = workouts[index]['name'];
    durationController.text = workouts[index]['duration'].toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Workout"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: workoutController,
              decoration: InputDecoration(labelText: "Exercise Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Duration (seconds)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              String newName = workoutController.text;
              int? newDuration = int.tryParse(durationController.text);
              
              if (newName.isNotEmpty && newDuration != null && newDuration > 0) {
                setState(() {
                  workouts[index]['name'] = newName;
                  workouts[index]['duration'] = newDuration;
                  workouts[index]['timeLeft'] = newDuration;
                });
                saveWorkouts();
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void startTimer(int index) {
    int duration = workouts[index]['duration'];
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (workouts[index]['timeLeft'] > 0) {
        setState(() {
          workouts[index]['timeLeft']--;
        });
        saveWorkouts();
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Workouts")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: workoutController,
              decoration: InputDecoration(labelText: "Exercise Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Duration (seconds)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addWorkout,
              child: Text("Add Workout"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(workouts[index]['name']),
                      subtitle: Text(
                        "Duration: ${workouts[index]['duration']} sec\nTime Left: ${workouts[index]['timeLeft']} sec",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.play_arrow, color: Colors.green),
                            onPressed: () => startTimer(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => editWorkout(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteWorkout(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
