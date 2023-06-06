import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? avatar;
  final String? password;
  final String? userCreated;
  final String? createdAt;
  final String? role;

  User(this.id, this.name, this.email, this.avatar, this.password, this.role, this.userCreated, this.createdAt);

  const User._(this.id, this.name, this.email, this.avatar, this.password, this.userCreated, this.createdAt, this.role);
  static const empty = User._(0, '-', '-', '-', '-', '-', '-', '-');

  @override
  List<Object?> get props => [];

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        avatar = json['avatar'],
        password = json['password'],
        userCreated = json['user_created'],
        createdAt = json['created_at'],
        role = json['roles'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['password'] = this.password;
    data['user_created'] = this.userCreated;
    data['created_at'] = this.createdAt;
    data['roles'] = this.role;
    return data;
  }
}
