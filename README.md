# Flutter Counter App

Aplikasi Counter Flutter untuk tugas praktikum (memahami `setState`, widget lifecycle, passing data, dan callback function).

## Fitur Utama
- **Fungsi Counter Dasar**: Tombol Tambah (+1), Kurang (-1), dan Reset ke 0.
- **Aturan Tidak Minus**: Nilai counter tidak dapat berkurang di bawah 0.
- **Passing Data**: Widget `CounterDisplay` menerima nilai counter melalui constructor parameter.
- **Callback Function**: Widget `CounterButtons` menerima 3 callback function (`onAdd`, `onSubtract`, `onReset`).
- **Widget Lifecycle**: Memiliki `initState()` yang mencetak `"Counter dimulai"` dan `dispose()` yang mencetak `"Counter ditutup"` ke console.

## Struktur Proyek
```text
lib/
├── main.dart             # Root app, state management, & lifecycle
├── counter_display.dart  # Widget tampilan angka (Passing data)
└── counter_buttons.dart  # Widget tombol aksi (Callback function)
test/
└── widget_test.dart      # Pengujian otomatis
```

## Menjalankan Aplikasi
```bash
flutter pub get
flutter run
```
