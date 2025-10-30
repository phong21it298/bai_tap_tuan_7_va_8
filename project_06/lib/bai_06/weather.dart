class Weather {
  final String description;
  final double temp;
  final String icon;
  final String city;

  Weather({
    required this.description,
    required this.temp,
    required this.icon,
    required this.city,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temp: (json['main']['temp'] as num).toDouble(),
      icon: json['weather'][0]['icon'],
      city: json['name'],
    );
  }
}
