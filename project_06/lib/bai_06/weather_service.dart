import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather.dart';

class WeatherService {
  static const String apiKey = 'xxx';

  static Future<Weather> fetchWeather(double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
