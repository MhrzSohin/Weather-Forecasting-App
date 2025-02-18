import 'package:flutter/material.dart';

class WeatherForecastCard extends StatelessWidget {
  final String time;
  final String weatherIcon;
  final String temperature;

  const WeatherForecastCard({
    super.key,
    required this.time,
    required this.weatherIcon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 90,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 135, 134, 137),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Image.asset(
              weatherIcon,
              height: 35,
              width: 35,
            ),
            Text(
              '$temperature°',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
