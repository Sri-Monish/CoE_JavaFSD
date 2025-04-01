import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final List<Map<String, dynamic>> workoutCategories = [
    {'name': 'Fat Burn', 'exercises': ['Jump Rope - 5 min', 'Burpees - 3x15', 'Mountain Climbers - 3x30 sec']},
    {'name': 'Biceps', 'exercises': ['Bicep Curls - 3x12', 'Hammer Curls - 3x12', 'Concentration Curls - 3x10']},
    {'name': 'Triceps', 'exercises': ['Tricep Dips - 3x12', 'Skull Crushers - 3x10', 'Close-Grip Push-ups - 3x15']},
    {'name': 'Thigh', 'exercises': ['Squats - 3x12', 'Lunges - 3x12', 'Leg Press - 3x10']},
    {'name': 'Full Body', 'exercises': ['Push-ups - 3x15', 'Jump Squats - 3x12', 'Deadlifts - 3x10']},
  ];

  void showExercises(BuildContext context, List<String> exercises) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: exercises.map((exercise) => ListTile(title: Text(exercise))).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workouts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: workoutCategories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => showExercises(context, workoutCategories[index]['exercises']),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: Center(
                  child: Text(
                    workoutCategories[index]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
