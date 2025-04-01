import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String workoutApiUrl = "https://wger.de/api/v2/exercise/?language=2&limit=10";
  static const String dietApiUrl = "https://api.spoonacular.com/mealplanner/generate";
  static const String apiKey = "c7c65bc28d2d440a91b7ca9196f76f09"; // Replace with your API Key

  // Fetch workouts
  static Future<List<dynamic>> fetchWorkouts() async {
  final response = await http.get(Uri.parse(workoutApiUrl));

  print("Workout API Response: ${response.body}"); // Debugging API response

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return data['results'] ?? []; // Ensure it returns a list
  } else {
    throw Exception('Failed to load workouts');
  }
}


  // Fetch meal plan based on weight goal
  static Future<Map<String, dynamic>> fetchMealPlan(String goal) async {
    final response = await http.get(
      Uri.parse("$dietApiUrl?timeFrame=day&targetCalories=${goal == 'gain' ? 2800 : 1800}&apiKey=$apiKey"),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load meal plan');
    }
  }
}
