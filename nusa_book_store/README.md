<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NusaBookstore</title>
</head>
<body>

    <h1>NusaBookstore</h1>

    <p>Aplikasi katalog dan keranjang buku Flutter sederhana dengan state management <code>provider</code>.</p>

    <h2>Fitur</h2>

    <ul>
        <li>Katalog empat buku dengan placeholder ikon.</li>
        <li>Tambah, kurangi, dan hapus buku dari keranjang.</li>
        <li>Badge jumlah item dan total pembayaran Rupiah yang reaktif.</li>
        <li>Checkout dengan <code>SnackBar</code> dan pengosongan keranjang.</li>
        <li>Light Mode dan Dark Mode di seluruh aplikasi.</li>
    </ul>

    <h2>Struktur</h2>

    <pre><code>lib/
├── models/book.dart
├── providers/cart_provider.dart
├── providers/theme_provider.dart
├── screens/catalog_screen.dart
├── screens/cart_screen.dart
└── main.dart</code></pre>

    <h2>Menjalankan</h2>

    <pre><code class="language-bash">flutter pub get
flutter run</code></pre>

    <p>Untuk menjalankan melalui script npm:</p>

    <pre><code class="language-bash">npm run dev</code></pre>

    <p>Aplikasi tersedia di <code>http://localhost:8081</code>.</p>

    <h2>Screenshot</h2>

    <p>Tambahkan screenshot hasil aplikasi berikut ke folder <code>screenshots/</code> sebelum pengumpulan repository:</p>

    <table>
        <thead>
            <tr>
                <th>Katalog dan badge</th>
                <th>Keranjang dan total</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><img src="screenshots/catalog.png" alt="Katalog"></td>
                <td><img src="screenshots/cart.png" alt="Keranjang"></td>
            </tr>
        </tbody>
    </table>

    <table>
        <thead>
            <tr>
                <th>Light Mode</th>
                <th>Dark Mode dan SnackBar checkout</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><img src="screenshots/light-mode.png" alt="Light Mode"></td>
                <td><img src="screenshots/dark-mode-checkout.png" alt="Dark Mode dan SnackBar checkout"></td>
            </tr>
        </tbody>
    </table>

</body>
</html>
