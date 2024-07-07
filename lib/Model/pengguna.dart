// Model pengguna.dart
class User {
  final String id;
  final String name;
  final double balance;

  User({required this.id, required this.name, required this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      balance: json['balance'].toDouble(),
    );
  }
}
