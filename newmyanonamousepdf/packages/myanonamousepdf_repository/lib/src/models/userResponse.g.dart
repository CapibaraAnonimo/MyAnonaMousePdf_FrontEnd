// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserResponse',
      json,
      ($checkedConvert) {
        final val = UserResponse(
          id: $checkedConvert('id', (v) => v as String),
          userName: $checkedConvert('user_name', (v) => v as String),
          fullName: $checkedConvert('full_name', (v) => v as String),
          avatar: $checkedConvert('avatar', (v) => v as String),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'userName': 'user_name',
        'fullName': 'full_name',
        'createdAt': 'created_at'
      },
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'full_name': instance.fullName,
      'avatar': instance.avatar,
      'created_at': instance.createdAt.toIso8601String(),
    };
