import 'package:flutter/material.dart';

class CounterButtons extends StatelessWidget {
  const CounterButtons({
    super.key,
    required this.onAdd,
    required this.onSubtract,
    required this.onReset,
  });

  final VoidCallback onAdd;
  final VoidCallback onSubtract;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Tambah (+1)'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onSubtract,
                icon: const Icon(Icons.remove),
                label: const Text('Kurang (-1)'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onReset,
          icon: const Icon(Icons.refresh),
          label: const Text('Reset ke 0'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }
}
