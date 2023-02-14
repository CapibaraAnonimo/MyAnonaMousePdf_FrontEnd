class RegisterResponse {
  String? id;
  String? userName;
  String? avatar;
  String? fullName;
  DateTime? createdAt;
  String? token;
  String? refreshToken;

  RegisterResponse(
      {this.id,
      this.userName,
      this.avatar,
      this.fullName,
      this.createdAt,
      this.token,
      this.refreshToken});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    avatar = json['avatar'];
    fullName = json['fullName'];
    createdAt = json['createdAt'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['avatar'] = avatar;
    data['fullName'] = fullName;
    data['createdAt'] = createdAt;
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class RegisterRequest {
  String? username;
  String? password;
  String? verifyPassword;
  String? avatar;
  String? fullName;

  RegisterRequest({
    this.username,
    this.password,
    this.verifyPassword,
    this.avatar,
    this.fullName,
  });

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    verifyPassword = json['verifyPassword'];
    avatar = json['avatar'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = username;
    data['password'] = password;
    data['verifyPassword'] = verifyPassword;
    data['avatar'] = avatar;
    data['fullName'] = fullName;
    return data;
  }
}
