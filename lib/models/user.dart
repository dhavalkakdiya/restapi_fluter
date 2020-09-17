class User {
  final String email;
  final String password;
  final String firstName;
  final String avatar;
  User({this.firstName, this.avatar, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      firstName: json['first_name'],
      avatar : json['avatar'],
    );
  }
}
