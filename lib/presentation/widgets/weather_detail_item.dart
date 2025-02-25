import 'package:flutter/material.dart';

class WeatherDetailItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String unit;

  const WeatherDetailItem(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      required this.unit});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.17),
      ),
      child: Row(
        children: [
          Icon(
            color: Colors.white,
            icon,
            size: 32,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value != 'N/A' ? "$value $unit" : value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          )
        ],
      ),
    ));
  }
}
