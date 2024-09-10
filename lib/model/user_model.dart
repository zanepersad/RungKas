class User {
  String? id;
  String? phoneNumber;

  User({required this.id, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
