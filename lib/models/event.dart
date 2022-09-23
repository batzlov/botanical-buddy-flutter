enum EventType {
  pour,
  fertilize
}

class Event {
  final String date;
  final String details;
  final EventType eventType;

  const Event({
    required this.date,
    required this.details,
    required this.eventType
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      date: json['date'],
      details: json['details'],
      eventType: EventType.values[json['type']]
    );
  }
}