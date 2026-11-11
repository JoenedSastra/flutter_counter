# 📱 Aplikasi Flutter Counter

Proyek aplikasi Flutter Counter yang dibangun untuk memenuhi tugas praktikum mata kuliah **Pemrograman Mobile**. Aplikasi ini mengimplementasikan konsep fundamental Flutter: manipulasi state lokal dengan `setState()`, arsitektur komponen modular (*passing data* dan *callback function*), serta pengamatan siklus hidup widget (*widget lifecycle* `initState` & `dispose`).

---

## 📑 Daftar Isi
- [Fitur Utama](#-fitur-utama)
- [Pemenuhan Rubrik Penilaian](#-pemenuhan-rubrik-penilaian)
- [Struktur Direktori](#-struktur-direktori)
- [Penjelasan Komponen & Alur Data](#-penjelasan-komponen--alur-data)
- [Widget Lifecycle](#-widget-lifecycle-initstate--dispose)
- [Cara Menjalankan Aplikasi](#-cara-menjalankan-aplikasi)
- [Pengujian Otomatis (Testing)](#-pengujian-otomatis-testing)
- [Panduan Pengambilan Screenshot](#-panduan-pengambilan-screenshot)

---

## ✨ Fitur Utama

1. **Tambah Counter (`+1`)**: Menambahkan nilai counter sebesar 1 secara reaktif menggunakan `setState()`.
2. **Kurang Counter (`-1`)**: Mengurangi nilai counter sebesar 1.
3. **Aturan Tidak Boleh Minus**: Nilai counter tidak akan pernah menjadi negatif. Jika nilai saat ini adalah `0`, tombol Kurang tidak melakukan apa-apa (`if (_counter > 0)`).
4. **Reset ke 0**: Mengembalikan nilai counter kembali ke angka `0`.
5. **Komponen Modular**: Tampilan angka dan tombol-tombol dipisahkan ke dalam widget independen di file terpisah.
6. **Pengujian Lifecycle**: Disediakan tombol aksi di AppBar untuk menguji dan membuktikan jalannya `initState()` dan `dispose()` secara visual dan melalui log console.

---

## 🎯 Pemenuhan Rubrik Penilaian

| Kriteria | Bobot | Implementasi pada Proyek |
| :--- | :---: | :--- |
| **Fungsi Counter Dasar** | **25 Poin** | Tombol Tambah, Kurang, dan Reset bekerja akurat menggunakan `setState()`. Aturan angka tidak boleh minus divalidasi dengan aman sebelum state diubah. |
| **Passing Data & Callback** | **35 Poin** | `CounterDisplay` menerima data `counter` via constructor parameter. `CounterButtons` menerima 3 callback function (`onAdd`, `onSubtract`, `onReset`) dari parent. |
| **Widget Lifecycle** | **20 Poin** | `initState()` mencetak `"Counter dimulai"` saat widget dimuat, dan `dispose()` mencetak `"Counter ditutup"` saat widget dimusnahkan. Dilengkapi toggle wrapper agar kedua lifecycle dapat diuji langsung di console. |
| **Kerapian Kode** | **20 Poin** | Kode terpisah rapi menjadi 3 file modular di `lib/`, penamaan konsisten, lolos `dart format`, dan lolos `dart analyze --fatal-infos` tanpa error maupun warning. |

---

## 📁 Struktur Direktori

Struktur proyek disusun mengikuti konvensi resmi Flutter:

```text
flutter_counter/
│
├── android/                  # Konfigurasi platform Android
├── ios/                      # Konfigurasi platform iOS
├── linux/                    # Konfigurasi platform Linux
├── macos/                    # Konfigurasi platform macOS
├── web/                      # Konfigurasi platform Web
├── windows/                  # Konfigurasi platform Windows Desktop
│
├── lib/
│   ├── main.dart             # Root app, state management, & lifecycle wrapper
│   ├── counter_display.dart  # Widget tampilan angka (Passing data)
│   └── counter_buttons.dart  # Widget tombol aksi (Callback function)
│
├── test/
│   └── widget_test.dart      # Pengujian otomatis (Unit & Widget Test)
│
├── pubspec.yaml              # Metadata proyek & deklarasi dependensi
├── pubspec.lock              # Kunci versi dependensi yang terpasang
├── analysis_options.yaml     # Aturan linting Dart & Flutter
└── README.md                 # Dokumentasi proyek
```

---

## 🧩 Penjelasan Komponen & Alur Data

Aplikasi menerapkan pola *Unidirectional Data Flow* (aliran data satu arah) khas Flutter:

```
        +----------------------------------------+
        |        CounterPage (Stateful)          |
        |  - Menyimpan _counter = 0             |
        |  - Logika: _add, _subtract, _reset     |
        |  - Lifecycle: initState() & dispose()  |
        +-------------------+--------------------+
                            |
           +----------------+----------------+
           | passing data                    | passing callback
           v                                 v
+-----------------------+       +-------------------------+
|    CounterDisplay     |       |     CounterButtons      |
|  (StatelessWidget)    |       |    (StatelessWidget)    |
| - Menerima: counter   |       | - onAdd (Callback)      |
| - Menampilkan angka   |       | - onSubtract (Callback) |
+-----------------------+       | - onReset (Callback)    |
                                +-------------------------+
```

### 1. `lib/counter_display.dart`
Menerima data nilai counter dari parent melalui constructor:
```dart
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({
    super.key,
    required this.counter,
  });

  final int counter;
  // ... build method menampilkan angka dengan styling modern
}
```

### 2. `lib/counter_buttons.dart`
Menerima 3 callback function dari parent untuk mengeksekusi aksi penambahan, pengurangan, dan reset:
```dart
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
  // ... build method menampilkan 3 tombol (Tambah, Kurang, Reset)
}
```

### 3. `lib/main.dart`
Menghubungkan kedua widget, mengelola perubahan state melalui `setState()`, serta membatasi nilai tidak boleh kurang dari 0:
```dart
void _subtractCounter() {
  if (_counter > 0) {
    setState(() {
      _counter--;
    });
  }
}
```

---

## 🔄 Widget Lifecycle (`initState` & `dispose`)

Pada class `_CounterPageState`:
```dart
@override
void initState() {
  super.initState();
  debugPrint('Counter dimulai');
}

@override
void dispose() {
  debugPrint('Counter ditutup');
  super.dispose();
}
```

### Pembuktian Lifecycle
Aplikasi dilengkapi dengan `CounterLifecycleWrapper` dan tombol power di AppBar:
1. Saat aplikasi pertama kali dibuka, `CounterPage` di-mount $\rightarrow$ `initState()` berjalan dan mencetak log:
   ```text
   flutter: Counter dimulai
   ```
2. Saat tombol power di AppBar diklik, `CounterPage` di-unmount $\rightarrow$ `dispose()` berjalan dan mencetak log:
   ```text
   flutter: Counter ditutup
   ```
3. Saat tombol **"Buka Kembali Counter"** diklik, `CounterPage` di-mount ulang $\rightarrow$ `initState()` berjalan kembali:
   ```text
   flutter: Counter dimulai
   ```

---

## 🚀 Cara Menjalankan Aplikasi

### Prasyarat
- Flutter SDK (versi $\ge 3.0.0$)
- Perangkat emulator Android, browser Chrome, atau desktop Windows

### Langkah Instalasi
1. Clone repositori ini:
   ```bash
   git clone https://github.com/JoenedSastra/flutter_counter.git
   cd flutter_counter
   ```
2. Unduh semua dependensi:
   ```bash
   flutter pub get
   ```
3. Jalankan aplikasi pada perangkat yang diinginkan:
   ```bash
   # Jalankan di Google Chrome
   flutter run -d chrome

   # Jalankan di Windows Desktop
   flutter run -d windows

   # Jalankan di Emulator Android / Perangkat Fisik
   flutter run
   ```

---

## 🧪 Pengujian Otomatis (Testing)

Proyek ini telah dilengkapi dengan unit & widget test otomatis pada file [`test/widget_test.dart`](test/widget_test.dart).

Jalankan pengujian dengan perintah:
```bash
flutter test test/widget_test.dart
```

### Hasil Uji
```text
00:00 +0: Counter increments, decrements, does not go below zero, and resets
Counter dimulai
Counter ditutup
00:01 +1: CounterDisplay receives counter value as parameter
00:01 +2: CounterButtons executes callbacks on press
00:01 +3: CounterLifecycleWrapper unmounts and remounts CounterPage (testing lifecycle)
Counter dimulai
Counter ditutup
Counter dimulai
Counter ditutup
00:01 +4: All tests passed!
```

---

## 📸 Panduan Pengambilan Screenshot

Untuk keperluan pengumpulan laporan tugas (submission):

1. **Screenshot UI Aplikasi**:
   - Jalankan aplikasi, tekan tombol **Tambah (+1)** hingga angka bernilai `5` atau lebih. Ambil screenshot layar aplikasi.
2. **Screenshot Aturan Tidak Minus**:
   - Tekan tombol **Reset ke 0** atau kurangi hingga `0`, lalu tekan tombol **Kurang (-1)** untuk membuktikan nilai tetap `0`.
3. **Screenshot Console Log (Lifecycle)**:
   - Klik tombol ikon power di AppBar untuk menutup widget, lalu klik tombol **"Buka Kembali Counter"**.
   - Buka panel **Debug Console** di VS Code / Android Studio / Terminal dan ambil screenshot yang memperlihatkan teks:
     ```text
     flutter: Counter dimulai
     flutter: Counter ditutup
     flutter: Counter dimulai
     ```
