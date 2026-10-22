class TourPackage {
  const TourPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
}

const tourPackages = <TourPackage>[
  TourPackage(
    id: 'bali-selatan',
    title: 'Bali Selatan',
    description:
        'Nikmati senja di Uluwatu, pantai yang tenang, dan hidangan lokal di pesisir selatan.',
    price: 1850000,
    imageUrl:
        'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=900&q=80',
  ),
  TourPackage(
    id: 'labuan-bajo',
    title: 'Labuan Bajo',
    description:
        'Berlayar menuju pulau-pulau kecil, menyapa komodo, dan melihat laut dari sudut terbaik.',
    price: 3250000,
    imageUrl:
        'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?w=900&q=80',
  ),
  TourPackage(
    id: 'raja-ampat',
    title: 'Raja Ampat',
    description:
        'Pelarian tropis dengan air sebening kaca, teluk karst, dan hari-hari yang berjalan pelan.',
    price: 4900000,
    imageUrl:
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=900&q=80',
  ),
  TourPackage(
    id: 'yogyakarta',
    title: 'Yogyakarta',
    description:
        'Temukan cerita di balik candi, jalan kota yang hangat, dan rasa manis khas Jawa.',
    price: 1250000,
    imageUrl:
        'https://images.unsplash.com/photo-1555899434-94d1368aa7af?w=900&q=80',
  ),
];
