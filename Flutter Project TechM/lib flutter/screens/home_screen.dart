import 'package:flutter/material.dart';
import 'bmi_screen.dart';
import 'workout_screen.dart';
import 'diet_screen.dart';
import 'my_workout_screen.dart';
import 'login_screen.dart'; // Import your login screen
import 'package:intl/intl.dart'; // For formatting time

// Language translation map
Map<String, Map<String, String>> translations = {
  'en': {
    'title': 'FitMate',
    'welcome': 'Welcome to FitMate!',
    'description': 'Your ultimate fitness companion. Track your BMI, workouts, and diet all in one place.',
    'bmi': 'Calculate BMI',
    'workouts': 'Workouts',
    'diet': 'Diet Tracker',
    'my_workouts': 'My Workouts',
    'good_morning': 'Good Morning!',
    'good_afternoon': 'Good Afternoon!',
    'good_evening': 'Good Evening!',
    'logout': 'Logout',
  },
  'es': {
    'title': 'FitMate',
    'welcome': '¡Bienvenido a FitMate!',
    'description': 'Tu compañero de fitness definitivo. Controla tu IMC, entrenamientos y dieta en un solo lugar.',
    'bmi': 'Calcular IMC',
    'workouts': 'Entrenamientos',
    'diet': 'Seguimiento de dieta',
    'my_workouts': 'Mis entrenamientos',
    'good_morning': '¡Buenos días!',
    'good_afternoon': '¡Buenas tardes!',
    'good_evening': '¡Buenas noches!',
    'logout': 'Cerrar sesión',
  },
};

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = 'en'; // Default language
  bool isDarkMode = false; // Dark mode state

  // Toggle Language
  void _changeLanguage() {
    setState(() {
      selectedLanguage = selectedLanguage == 'en' ? 'es' : 'en';
    });
  }

  // Toggle Dark Mode
  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  // Get Greeting Based on Time
  String _getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return translations[selectedLanguage]?['good_morning'] ?? "Good Morning!";
    } else if (hour < 18) {
      return translations[selectedLanguage]?['good_afternoon'] ?? "Good Afternoon!";
    } else {
      return translations[selectedLanguage]?['good_evening'] ?? "Good Evening!";
    }
  }

  // Logout Function
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Redirect to Login Screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(), // Apply theme
      home: Scaffold(
        appBar: AppBar(
          title: Text(translations[selectedLanguage]?['title'] ?? "FitMate"),
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.blueAccent,
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: _toggleDarkMode, // Toggle Dark Mode
            ),
            IconButton(
              icon: Icon(Icons.language),
              onPressed: _changeLanguage, // Toggle Language
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.redAccent),
              onPressed: _logout, // Logout Button
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _getGreeting(), // Display greeting
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                translations[selectedLanguage]?['welcome'] ?? "Welcome to FitMate!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                translations[selectedLanguage]?['description'] ??
                    "Your ultimate fitness companion. Track your BMI, workouts, and diet all in one place.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                ),
              ),
              SizedBox(height: 30),

              // Buttons
              _buildButton(context, translations[selectedLanguage]?['bmi'] ?? "Calculate BMI",
                  Icons.fitness_center, BMIScreen()),

              _buildButton(context, translations[selectedLanguage]?['workouts'] ?? "Workouts",
                  Icons.directions_run, WorkoutScreen()),

              _buildButton(context, translations[selectedLanguage]?['diet'] ?? "Diet Tracker",
                  Icons.restaurant, DietScreen()),

              _buildButton(context, translations[selectedLanguage]?['my_workouts'] ?? "My Workouts",
                  Icons.timer, MyWorkoutScreen()),

              SizedBox(height: 20),

              // Logout Button (Also available in AppBar)
              ElevatedButton.icon(
                onPressed: _logout,
                icon: Icon(Icons.exit_to_app, color: Colors.white),
                label: Text(translations[selectedLanguage]?['logout'] ?? "Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, Widget screen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          textStyle: TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
        icon: Icon(icon, size: 24),
        label: Text(text),
      ),
    );
  }
}
