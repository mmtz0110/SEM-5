class EventItem {
  const EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.speaker,
    required this.colorValue,
    required this.iconCodePoint,
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final String date;
  final String time;
  final String location;
  final String speaker;
  final int colorValue;
  final int iconCodePoint;
}
