class LoginModel {
  final String? username;
  final String? email;
  final String? password;

  const LoginModel({
    this.username,
    this.email,
    this.password,
  });

  LoginModel copyWith({
    String? username,
    String? email,
    String? password,
  }) {
    return LoginModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }
}
