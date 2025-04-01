import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _result = "";

  void _calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);
    double bmi = weight / (height * height);

    String message;
    if (bmi < 18.5) {
      message = "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      message = "Normal";
    } else {
      message = "Overweight";
    }

    setState(() {
      _result = "Your BMI: ${bmi.toStringAsFixed(2)} ($message)\nCheck workout and diet pages to improve.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: "Height (cm)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text("Calculate BMI"),
            ),
            SizedBox(height: 20),
            Text(_result, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
