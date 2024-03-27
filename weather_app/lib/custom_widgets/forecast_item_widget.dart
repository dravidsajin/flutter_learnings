import 'package:flutter/material.dart';

class ForeCastItemWidget extends StatelessWidget {
  final String time;
  final IconData icon;
  final String value;
  const ForeCastItemWidget({super.key, required this.time, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              value,
              // style: TextStyle(fontSize: 14),
            )
          ]),
        ),
      ),
    );
  }
}