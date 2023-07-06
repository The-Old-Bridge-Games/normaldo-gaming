import 'package:normaldo_gaming/domain/user/entities/user.dart';

final class UserModel {
  final String id;
  final String name;
  final int dollars;
  final int highScore;

  UserModel({
    required this.id,
    required this.name,
    required this.dollars,
    required this.highScore,
  });

  UserModel.fromEntity(User user)
      : id = user.id,
        name = user.name,
        dollars = user.dollars,
        highScore = user.highScore;

  User toEntity() {
    return User(id: id, name: name, highScore: highScore, dollars: dollars);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        dollars: json['dollars'],
        highScore: json['highScore'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dollars': dollars,
      'highScore': highScore,
    };
  }

  UserModel copyWith({
    String? name,
    int? dollars,
    int? highScore,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        dollars: dollars ?? this.dollars,
        highScore: highScore ?? this.highScore,
      );
}
