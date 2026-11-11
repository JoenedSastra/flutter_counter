import 'package:flutter/material.dart';

import 'counter_buttons.dart';
import 'counter_display.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Counter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5267D8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      home: const CounterLifecycleWrapper(),
    );
  }
}

/// Wrapper untuk mendemonstrasikan lifecycle widget (initState & dispose).
/// Pengguna dapat menutup dan membuka kembali CounterPage untuk melihat log di console.
class CounterLifecycleWrapper extends StatefulWidget {
  const CounterLifecycleWrapper({super.key});

  @override
  State<CounterLifecycleWrapper> createState() =>
      _CounterLifecycleWrapperState();
}

class _CounterLifecycleWrapperState extends State<CounterLifecycleWrapper> {
  bool _isCounterActive = true;

  void _toggleCounter() {
    setState(() {
      _isCounterActive = !_isCounterActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isCounterActive) {
      return CounterPage(onClose: _toggleCounter);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aplikasi Counter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.power_settings_new,
                  size: 72,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Counter Telah Ditutup',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Method dispose() telah dipanggil dan mencetak log "Counter ditutup" ke console.\n\nKlik tombol di bawah untuk membuka kembali counter (memanggil initState).',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 28),
                FilledButton.icon(
                  onPressed: _toggleCounter,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Buka Kembali Counter'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Halaman Counter utama (StatefulWidget)
class CounterPage extends StatefulWidget {
  const CounterPage({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Lifecycle log saat widget diinisialisasi
    debugPrint('Counter dimulai');
  }

  @override
  void dispose() {
    // Lifecycle log saat widget dihancurkan/ditutup
    debugPrint('Counter ditutup');
    super.dispose();
  }

  void _addCounter() {
    setState(() {
      _counter++;
    });
  }

  void _subtractCounter() {
    // Angka tidak boleh minus (kalau sudah 0, tidak melakukan apa-apa)
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _resetCounter() {
    // Reset counter kembali ke 0
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aplikasi Counter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          if (widget.onClose != null)
            IconButton(
              icon: const Icon(Icons.power_settings_new),
              tooltip: 'Tutup Counter (Uji dispose)',
              onPressed: widget.onClose,
            ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'NILAI COUNTER',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 18),
                // Widget terpisah untuk tampilan angka counter (Passing data)
                CounterDisplay(counter: _counter),
                const SizedBox(height: 32),
                // Widget terpisah untuk tombol-tombol counter (Passing callback)
                CounterButtons(
                  onAdd: _addCounter,
                  onSubtract: _subtractCounter,
                  onReset: _resetCounter,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Counter tidak dapat bernilai di bawah 0.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
