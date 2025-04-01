import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DietScreen extends StatefulWidget {
  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final TextEditingController weightController = TextEditingController();
  String selectedGoal = "loss";
  Map<String, dynamic>? mealPlan;
  bool isLoading = false;

  void fetchMealPlan() async {
    setState(() => isLoading = true);
    try {
      Map<String, dynamic> data = await ApiService.fetchMealPlan(selectedGoal);
      setState(() {
        mealPlan = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching meal plan: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diet Planner")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter your weight (kg)"),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedGoal,
              items: [
                DropdownMenuItem(value: "loss", child: Text("Weight Loss")),
                DropdownMenuItem(value: "gain", child: Text("Weight Gain")),
              ],
              onChanged: (value) => setState(() => selectedGoal = value!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchMealPlan,
              child: Text("Get Meal Plan"),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : mealPlan != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: mealPlan!['meals'].length,
                          itemBuilder: (context, index) {
                            var meal = mealPlan!['meals'][index];
                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(meal['title']),
                                subtitle: Text("Ready in: ${meal['readyInMinutes']} min"),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}

