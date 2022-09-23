class DiaryEntry {
  final DateTime notedAt;
  final int height;

  DiaryEntry({
    required this.notedAt, 
    required this.height
  });

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    var dateString = json['notedAt'].split('.');
    dateString =  dateString[2] + dateString[1] + dateString[0]; 

    return DiaryEntry(
      notedAt: DateTime.parse(dateString),
      height: json['heightMeasured']
    );
  }
}