class User {
  String? id;
  String? userName;
  String? name;
  //DateTime? createdAt;
  String? accessToken;
  String? avatar;
  String? token;
  String? refreshToken;

  User(
      {required this.id,
      required this.name,
      required this.userName,
      //required this.createdAt,
      required this.accessToken,
      this.avatar,
      this.token,
      this.refreshToken});

  @override
  String toString() => 'User { id: $id, userName: $userName}';

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    name = json['fullName'];
    //createdAt = DateTime.tryParse(reformat(json['createdAt']));
    accessToken = json['accessToken'];
    avatar = json['avatar'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['fullName'] = name;
    //data['createdAt'] = dateToString(createdAt!);
    data['accessToken'] = accessToken;
    data['avatar'] = avatar;
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

reformat(String dateTime) {
  print(dateTime);
  String day = dateTime.substring(0, 2);
  print(day);
  String month = dateTime.substring(3, 5);
  String year = dateTime.substring(6, 10);
  String rest = dateTime.substring(11);
  String newString = year + '-' + month + '-' + day + ' ' + rest;
  print(newString);
  return newString;
}

reformat2(String dateTime) {
  print(dateTime);
  String year = dateTime.substring(0, 4);
  String month = dateTime.substring(5, 7);
  String day = dateTime.substring(8, 10);
  String rest = dateTime.substring(11);
  String newString = year + '-' + month + '-' + day + ' ' + rest;
  print(newString);
  return newString;
}

dateToString(DateTime date) {
  return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
}
