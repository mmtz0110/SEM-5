# NusaTravel

Aplikasi Flutter sederhana untuk menjelajahi paket wisata Indonesia dan mengirim pemesanan.

## Menjalankan di web

```bash
flutter pub get
flutter run -d chrome
```

Untuk membuat build web:

```bash
flutter build web
```

## Alur navigasi

- `/` menampilkan Splash Screen dan memakai `pushReplacementNamed()` ke Home.
- `/home` menampilkan empat paket wisata dan tombol Logout.
- `/detail` menerima `TourPackage` melalui `arguments`.
- `/booking` menerima `TourPackage`, memvalidasi form, lalu mengembalikan `true` dengan `Navigator.pop()`.
- Rute yang tidak dikenal ditangani oleh `onUnknownRoute` dan menampilkan Error 404.

## Struktur

Model, route, dan setiap screen dipisah ke folder `lib/models`, `lib/routes`, dan `lib/screens`.

## Pengumpulan

1. Upload project ini ke GitHub dan kirim URL repository.
2. Pastikan repository memiliki folder `lib/` dan file `pubspec.yaml`.
3. Screenshot setiap halaman tersedia di folder `screenshots/`.
4. Screenshot dialog `PopScope` dan `SnackBar` setelah pemesanan juga disertakan.
5. Jalankan pemeriksaan project dengan:

```bash
flutter analyze
flutter build web
```

### Splash Screen

![Splash Screen](screenshots/splashscreen.png)

### Home Screen

![Home Screen](screenshots/homescreen.png)

### Detail Screen

![Detail Screen](screenshots/detailscreen.png)

### Booking Screen

![Booking Screen](screenshots/bookingscreen.png)

### Dialog PopScope

![Dialog PopScope](screenshots/popscope.png)

### Not Found Screen

![Not Found Screen](screenshots/errorscreen.png)

### SnackBar setelah pemesanan

SnackBar ditampilkan setelah form booking berhasil dikirim dan halaman kembali ke Detail Screen. Tambahkan hasil tangkapan layar SnackBar ke folder `screenshots/` dengan nama `snackbar.png`, lalu gambar akan tampil di GitHub menggunakan Markdown berikut:

![SnackBar setelah pemesanan](screenshots/snackbar.png)
