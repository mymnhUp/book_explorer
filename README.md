# Book Explorer

## Deskripsi Aplikasi

Book Explorer adalah aplikasi mobile berbasis Flutter yang digunakan untuk mencari dan melihat informasi mengenai buku. Aplikasi ini mengambil data buku dari API sehingga pengguna dapat mencari buku dan melihat informasi buku dengan lebih mudah.

Aplikasi ini dibuat sebagai project Ujian Tengah Semester pada mata kuliah Mobile Programming.

## Fitur Utama

- Menampilkan rekomendasi buku.
- Mencari buku berdasarkan judul atau nama penulis.
- Menampilkan buku berdasarkan kategori.
- Menampilkan cover buku.
- Menampilkan informasi detail buku.
- Menampilkan nama penulis.
- Menampilkan informasi penerbit.
- Menampilkan tanggal terbit buku.
- Menampilkan rating buku.
- Menampilkan jumlah halaman buku.
- Mengambil data buku dari API.
- Menampilkan pesan error apabila data gagal dimuat.

## Teknologi yang Digunakan

- Flutter
- Dart
- Android Studio
- REST API
- JSON
- Package `http`

## Struktur Project

```text
lib/
├── models/
│   └── book.dart
├── pages/
│   ├── home_page.dart
│   └── detail_page.dart
├── services/
│   └── api_service.dart
├── widgets/
│   └── book_card.dart
└── main.dart
```

## Package yang Digunakan

### HTTP

Package `http` digunakan untuk melakukan request ke API dan mengambil data buku dari server.

## Cara Menjalankan Aplikasi

### 1. Clone Repository

```bash
git clone https://github.com/mymnhUp/book_explorer.git
```

### 2. Masuk ke Folder Project

```bash
cd book_explorer
```

### 3. Install Dependency

```bash
flutter pub get
```

### 4. Jalankan Aplikasi

Pastikan emulator Android atau perangkat Android sudah terhubung, kemudian jalankan:

```bash
flutter run
```

## Tampilan Aplikasi

Aplikasi Book Explorer memiliki beberapa bagian utama, yaitu halaman Explore, pencarian buku, kategori buku, detail buku, Favourite, Library, dan Settings.

## Repository GitHub

Source code aplikasi Book Explorer tersedia pada repository GitHub berikut:

https://github.com/mymnhUp/book_explorer
