import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login Method
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Signup Method
  Future<bool> signup(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user details in Firestore
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );
      await _firestore.collection("users").doc(user.uid).set(user.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  // Logout Method
  Future<void> logout() async {
    await _auth.signOut();
  }
}
