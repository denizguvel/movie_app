   
import 'package:hive_ce/hive.dart';

part 'auth_user_model.g.dart';

@HiveType(typeId: 0)
class AuthUserModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? username;
  @HiveField(3)
  final String? firstName;
  @HiveField(4)
  final String? lastName;
  @HiveField(5)
  final String? name;
  @HiveField(6)
  final String? photoUrl;

  const AuthUserModel({
    this.id,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.name,
    this.photoUrl,
  });

  AuthUserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? name,
    String? photoUrl,
  }) {
    return AuthUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
    );
  }
}
