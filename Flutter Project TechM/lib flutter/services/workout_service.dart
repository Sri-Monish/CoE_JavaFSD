import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/workout_model.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addWorkout(WorkoutModel workout) async {
    String userId = _auth.currentUser!.uid;

    await _firestore.collection('workouts').doc(userId).collection('userWorkouts').doc(workout.id).set(workout.toMap());
  }

  Future<List<WorkoutModel>> getWorkouts() async {
  String userId = _auth.currentUser!.uid; // Get current user ID
  QuerySnapshot snapshot = await _firestore
      .collection('workouts')
      .doc(userId)
      .collection('userWorkouts')
      .get();

  return snapshot.docs.map((doc) {
    return WorkoutModel(
      id: doc.id, // Firestore auto-generated ID
      name: doc['name'],
      duration: doc['duration'],
      date: (doc['date'] as Timestamp).toDate(),
    );
  }).toList();
}


Future<void> saveWorkout(String name, int duration) async {
  try {
    await FirebaseFirestore.instance.collection('workouts').add({
      'name': name,
      'duration': duration,
      'date': Timestamp.now(),
    });
    print("Workout saved successfully!"); // Debugging
  } catch (e) {
    print("Error saving workout: $e");
  }
}


}
