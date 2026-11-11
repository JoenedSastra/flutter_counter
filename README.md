# Praktikum Flutter: Aplikasi Counter dengan State, Lifecycle, Passing Data, dan Callback

Aplikasi Flutter Counter yang dibangun untuk memenuhi tugas praktikum pemrograman mobile. Proyek ini mengimplementasikan konsep dasar dan lanjutan dari Flutter:
- **`setState()`** untuk reaktivitas state internal.
- **Passing Data** ke child widget melalui constructor parameter.
- **Callback Function** untuk meneruskan aksi dari child widget kembali ke parent.
- **Widget Lifecycle** (`initState` dan `dispose`) yang terbukti berjalan melalui log console.
- **Logika Batasan**: Counter tidak dapat bernilai di bawah 0 (tidak minus).

---

## 📁 Struktur Direktori

```text
flutter_counter/
│
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
│
├── lib/
│   ├── main.dart
│   ├── counter_display.dart
│   └── counter_buttons.dart
│
├── test/
│   └── widget_test.dart
│
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
└── README.md
```

---

## 🛠️ Pembagian & Tanggung Jawab Widget

### 1. `main.dart`
- **`CounterApp`**: Widget root yang mengonfigurasi tema Material 3 dan rute aplikasi.
- **`CounterPage` (`StatefulWidget`)**:
  - Menyimpan state utama `int _counter = 0`.
  - Mengimplementasikan `_addCounter()`, `_subtractCounter()`, dan `_resetCounter()`.
  - Memiliki batasan angka: tombol kurang tidak akan mengurangi jika `_counter == 0`.
  - Mengimplementasikan **Lifecycle**:
    - `initState()` mencetak log `"Counter dimulai"`.
    - `dispose()` mencetak log `"Counter ditutup"`.
- **`CounterLifecycleWrapper`**:
  - Menyediakan tombol di AppBar untuk menutup dan membuka kembali widget `CounterPage`, memudahkan pengujian dan pengambilan screenshot pemanggilan `dispose()` dan `initState()` secara nyata di console debug.

### 2. `counter_display.dart` (`CounterDisplay`)
- Menerima nilai counter dari parent melalui constructor:
  ```dart
  final int counter;
  const CounterDisplay({super.key, required this.counter});
  ```
- Bertanggung jawab murni pada tampilan angka dengan styling modern (kartu putih berbayang halus, teks berukuran besar dan jelas).

### 3. `counter_buttons.dart` (`CounterButtons`)
- Menerima 3 callback function dari parent:
  ```dart
  final VoidCallback onAdd;
  final VoidCallback onSubtract;
  final VoidCallback onReset;
  ```
- Menampilkan 3 tombol:
  - **Tambah (+1)**: Tombol utama (`FilledButton`).
  - **Kurang (-1)**: Tombol outline (`OutlinedButton`).
  - **Reset ke 0**: Tombol outline lebar untuk mereset counter.

---

## 🚀 Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK sudah terpasang di sistem.
2. Jalankan perintah berikut di terminal:
   ```bash
   flutter pub get
   ```
3. Jalankan aplikasi pada perangkat yang diinginkan:
   - **Chrome (Web)**:
     ```bash
     flutter run -d chrome
     ```
   - **Windows Desktop**:
     ```bash
     flutter run -d windows
     ```
   - **Android Emulator / Device**:
     ```bash
     flutter run
     ```

---

## 🧪 Pengujian Otomatis

Seluruh logika tombol, batasan minus, passing data, callback, dan lifecycle telah diuji dengan test suite otomatis:
```bash
flutter test test/widget_test.dart
```

Hasil pengujian:
```text
00:00 +0: Counter increments, decrements, does not go below zero, and resets
Counter dimulai
Counter ditutup
00:00 +1: CounterDisplay receives counter value as parameter
00:01 +2: CounterButtons executes callbacks on press
00:01 +3: CounterLifecycleWrapper unmounts and remounts CounterPage (testing lifecycle)
Counter dimulai
Counter ditutup
Counter dimulai
Counter ditutup
00:01 +4: All tests passed!
```

---

## 📸 Panduan Screenshot untuk Pengumpulan Tugas

1. **Screenshot 1 (Tampilan UI Utama)**:
   - Jalankan aplikasi.
   - Tekan tombol **Tambah (+1)** beberapa kali (misalnya hingga angka bernilai 5).
   - Ambil screenshot layar aplikasi.
2. **Screenshot 2 (Pengujian Tombol Kurang & Aturan Tidak Minus)**:
   - Tekan tombol **Kurang (-1)** hingga mencapai angka 0, lalu tekan lagi untuk menunjukkan angka tidak menjadi minus.
   - Tekan tombol **Reset ke 0**.
   - Ambil screenshot layar aplikasi.
3. **Screenshot 3 (Bukti Widget Lifecycle di Console)**:
   - Tekan tombol power/tutup di pojok kanan atas AppBar untuk menutup widget `CounterPage` (memicu `dispose()`).
   - Tekan tombol **Buka Kembali Counter** (memicu `initState()`).
   - Buka panel **Debug Console** di VS Code / Android Studio / Terminal.
   - Ambil screenshot yang menampilkan log:
     ```text
     flutter: Counter dimulai
     flutter: Counter ditutup
     flutter: Counter dimulai
     ```

