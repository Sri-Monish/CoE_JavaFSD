import 'dart:convert';
import 'package:http/http.dart' as http;

class WorkoutApiService {
  Future<List<Map<String, dynamic>>> fetchWorkoutPlans() async {
    final url = Uri.parse("https://wger.de/api/v2/exercise/?language=2"); // Sample API
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception("Failed to load workouts");
    }
  }
}
