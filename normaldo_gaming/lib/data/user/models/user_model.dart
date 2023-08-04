import 'package:normaldo_gaming/domain/user/entities/user.dart';

final class UserModel {
  final String id;
  final String name;
  final int dollars;
  final int highScore;
  final int level;
  final int exp;
  final int extraLives;

  UserModel({
    required this.id,
    required this.name,
    required this.dollars,
    required this.highScore,
    required this.level,
    required this.exp,
    required this.extraLives,
  });

  UserModel.fromEntity(User user)
      : id = user.id,
        name = user.name,
        dollars = user.dollars,
        highScore = user.highScore,
        level = user.level,
        exp = user.exp,
        extraLives = user.extraLives;

  User toEntity() {
    return User(
      id: id,
      name: name,
      highScore: highScore,
      dollars: dollars,
      level: level,
      exp: exp,
      extraLives: extraLives,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      dollars: json['dollars'],
      highScore: json['highScore'],
      level: json['level'],
      exp: json['exp'],
      extraLives: json['extraLives']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dollars': dollars,
      'highScore': highScore,
      'level': level,
      'exp': exp,
      'extraLives': extraLives,
    };
  }

  UserModel copyWith({
    String? name,
    int? dollars,
    int? highScore,
    int? level,
    int? exp,
    int? extraLives,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        dollars: dollars ?? this.dollars,
        highScore: highScore ?? this.highScore,
        level: level ?? this.level,
        exp: exp ?? this.exp,
        extraLives: extraLives ?? this.extraLives,
      );
}
