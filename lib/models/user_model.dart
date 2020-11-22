import 'package:json_annotation/json_annotation.dart';

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
      json['userInfo'] == null
          ? null
          : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      json['token'] as String);
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{'userInfo': instance.userInfo, 'token': instance.token};

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(json['id'] as String, json['avatarUrl'] as String);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'id': instance.id,
  'avatarUrl': instance.avatarUrl
};


@JsonSerializable()
class UserEntity extends Object {

  @JsonKey(name: 'userInfo')
  UserInfo userInfo;

  @JsonKey(name: 'token')
  String token;

  UserEntity(this.userInfo,this.token,);


  factory UserEntity.fromJson(Map<String, dynamic> srcJson) => _$UserEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

}


@JsonSerializable()
class UserInfo extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  UserInfo(this.id,this.avatarUrl,);

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) => _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

}


