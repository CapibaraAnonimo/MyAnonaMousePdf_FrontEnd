import 'models.dart';

class LoginResponse {
  String? id;
  String? username;
  String? fullName;
  //DateTime? createdAt;
  String? avatar;
  String? token;
  String? refreshToken;

  LoginResponse(
      {this.id,
      this.username,
      this.fullName,
      //this.createdAt,
      this.avatar,
      this.token,
      this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    //createdAt = DateTime.tryParse(reformat2(json['createdAt']));
    avatar = json['avatar'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullName'] = fullName;
    //data['createdAt'] = dateToString(createdAt!);
    data['avatar'] = avatar;
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
