class Settings {
  int id;
  bool pourNotifications;
  bool fertilizeNotifications;
  bool mondayNotifications;
  bool tuesdayNotifications;
  bool wednesdayNotifications;
  bool thursdayNotifications;
  bool fridayNotifications;
  bool saturdayNotifications;
  bool sundayNotifications;
  bool remindDaily;
  bool remindWeekly;

  Settings({
    required this.id,
    required this.pourNotifications,
    required this.fertilizeNotifications,
    required this.mondayNotifications,
    required this.tuesdayNotifications,
    required this.wednesdayNotifications,
    required this.thursdayNotifications,
    required this.fridayNotifications,
    required this.saturdayNotifications,
    required this.sundayNotifications,
    required this.remindDaily,
    required this.remindWeekly
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      pourNotifications: json['pourNotifications'],
      fertilizeNotifications: json['fertilizeNotifications'],
      mondayNotifications: json['mondayNotifications'],
      tuesdayNotifications: json['tuesdayNotifications'],
      wednesdayNotifications: json['wednesdayNotifications'],
      thursdayNotifications: json['thursdayNotifications'],
      fridayNotifications: json['fridayNotifications'],
      saturdayNotifications: json['saturdayNotifications'],
      sundayNotifications: json['sundayNotifications'],
      remindDaily: json['remindDaily'],
      remindWeekly: json['remindWeekly']
    );
  }
}