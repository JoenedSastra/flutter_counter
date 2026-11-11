import 'package:flutter/material.dart';
import 'package:flutter_counter/counter_buttons.dart';
import 'package:flutter_counter/counter_display.dart';
import 'package:flutter_counter/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Counter increments, decrements, does not go below zero, and resets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    // Awal nilai counter harus 0
    expect(find.text('0'), findsOneWidget);

    // Tombol Kurang ditekan saat 0 -> nilai tetap 0 (tidak boleh minus)
    await tester.tap(find.text('Kurang (-1)'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);

    // Tombol Tambah ditekan 3 kali -> nilai menjadi 3
    await tester.tap(find.text('Tambah (+1)'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('Tambah (+1)'));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('Tambah (+1)'));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);

    // Tombol Kurang ditekan 1 kali -> nilai menjadi 2
    await tester.tap(find.text('Kurang (-1)'));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    // Tombol Reset ditekan -> nilai kembali ke 0
    await tester.tap(find.text('Reset ke 0'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('CounterDisplay receives counter value as parameter',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CounterDisplay(counter: 42),
        ),
      ),
    );

    expect(find.text('42'), findsOneWidget);
  });

  testWidgets('CounterButtons executes callbacks on press',
      (WidgetTester tester) async {
    var addCalls = 0;
    var subtractCalls = 0;
    var resetCalls = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CounterButtons(
            onAdd: () => addCalls++,
            onSubtract: () => subtractCalls++,
            onReset: () => resetCalls++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tambah (+1)'));
    expect(addCalls, 1);

    await tester.tap(find.text('Kurang (-1)'));
    expect(subtractCalls, 1);

    await tester.tap(find.text('Reset ke 0'));
    expect(resetCalls, 1);
  });

  testWidgets(
      'CounterLifecycleWrapper unmounts and remounts CounterPage (testing lifecycle)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    // CounterPage aktif
    expect(find.byType(CounterPage), findsOneWidget);

    // Tekan tombol tutup counter di AppBar (trigger dispose)
    await tester.tap(find.byIcon(Icons.power_settings_new));
    await tester.pumpAndSettle();

    // CounterPage sudah unmounted
    expect(find.byType(CounterPage), findsNothing);
    expect(find.text('Counter Telah Ditutup'), findsOneWidget);

    // Tekan tombol Buka Kembali Counter (trigger initState)
    await tester.tap(find.text('Buka Kembali Counter'));
    await tester.pumpAndSettle();

    // CounterPage kembali aktif
    expect(find.byType(CounterPage), findsOneWidget);
  });
}
