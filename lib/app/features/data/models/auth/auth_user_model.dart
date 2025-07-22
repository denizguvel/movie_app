   
import 'package:hive_ce/hive.dart';

part 'auth_user_model.g.dart';

@HiveType(typeId: 0)
class AuthUserModel {
  @HiveField(0)
  final int? pk;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? username;
  @HiveField(3)
  final String? firstName;
  @HiveField(4)
  final String? lastName;

  const AuthUserModel({
    this.pk,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
  });

  AuthUserModel copyWith({
    int? pk,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
  }) {
    return AuthUserModel(
      pk: pk ?? this.pk,
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      pk: map['pk'] != null ? map['pk'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
    );
  }
}
