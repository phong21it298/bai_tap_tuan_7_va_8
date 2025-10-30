import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'weather.dart';
import 'weather_service.dart';

class MyProject06 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject06State();
}

class _MyProject06State extends State<MyProject06> {

  Future<Weather>? _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = _getWeather();
  }

  Future<Weather> _getWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, cannot request.');
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return WeatherService.fetchWeather(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Weather App 06')),
      body: Center(
        child: FutureBuilder<Weather>(
          future: _weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final weather = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather.city,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  ),
                  Text(
                    '${weather.temp.toStringAsFixed(1)} °C',
                    style: const TextStyle(fontSize: 28),
                  ),
                  Text(
                    weather.description,
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              );
            }
            return const Text('No data');
          },
        ),
      ),
    );
  }
}
