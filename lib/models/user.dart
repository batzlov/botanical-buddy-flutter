class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? token;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.token
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      firstName: json['user']['firstName'],
      lastName: json['user']['lastName'],
      email: json['user']['email'],
      token: json['token']
    );
  }
}