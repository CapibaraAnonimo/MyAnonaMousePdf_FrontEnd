class User {
  String? id;
  String? userName;
  String? name;
  DateTime? createdAt;
  String? accessToken;
  String? avatar;

  User(
      {required this.id,
      required this.name,
      required this.userName,
      required this.createdAt,
      required this.accessToken,
      this.avatar});

  @override
  String toString() => 'User { id: $id, userName: $userName}';

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    name = json['name'];
    createdAt = json['createdAt'];
    accessToken = json['accessToken'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['accessToken'] = accessToken;
    data['avatar'] = avatar;
    return data;
  }
}
