import 'package:json_annotation/json_annotation.dart';

part 'jwtUserResponse.g.dart';

@JsonSerializable()
class JwtUserResponse {
  const JwtUserResponse({
    required this.token,
    required this.refreshToken,
    required this.id,
    required this.userName,
    required this.fullName,
    required this.avatar,
    required this.createdAt,
  });

  factory JwtUserResponse.fromJson(Map<String, dynamic> json) =>
      _$JwtUserResponseFromJson(json);

  final String token;
  final String refreshToken;
  final String id;
  final String userName;
  final String fullName;
  final String avatar;
  final DateTime createdAt;
}
