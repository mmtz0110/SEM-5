# NusaBookstore

Aplikasi katalog dan keranjang buku Flutter sederhana dengan state management
`provider`.

## Fitur

- Katalog empat buku dengan placeholder ikon.
- Tambah, kurangi, dan hapus buku dari keranjang.
- Badge jumlah item dan total pembayaran Rupiah yang reaktif.
- Checkout dengan `SnackBar` dan pengosongan keranjang.
- Light Mode dan Dark Mode di seluruh aplikasi.

## Struktur

```text
lib/
├── models/book.dart
├── providers/cart_provider.dart
├── providers/theme_provider.dart
├── screens/catalog_screen.dart
├── screens/cart_screen.dart
└── main.dart
```

## Menjalankan

```bash
flutter pub get
flutter run
```

Untuk menjalankan melalui script npm:

```bash
npm run dev
```

Aplikasi tersedia di `http://localhost:8081`.

## Screenshot

Tambahkan screenshot hasil aplikasi berikut ke folder `screenshots/` sebelum
pengumpulan repository:

| Katalog dan badge | Keranjang dan total |
| --- | --- |
| ![Katalog](screenshots/catalog.png) | ![Keranjang](screenshots/cart.png) |

| Light Mode | Dark Mode dan SnackBar checkout |
| --- | --- |
| ![Light Mode](screenshots/light-mode.png) | ![Dark Mode](screenshots/dark-mode-checkout.png) |
