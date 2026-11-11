import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({
    super.key,
    required this.counter,
  });

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        '$counter',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5267D8),
        ),
      ),
    );
  }
}
