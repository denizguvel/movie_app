class SignupModel {
  final String email;
  final String name;
  final String password;

  SignupModel({required this.email, required this.name, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'password': password,
    };
  }
}
