class User {
  String name;
  String avatar;
  String email;
  String token;

  User({this.name, this.avatar, this.email, this.token});

  factory User.fromJsonAfterLogin(Map<String, dynamic> json, String email) =>
      User(
          name: json["name"],
          avatar: json["avatar"] == 'http://test.touri.sa/app/images/users'
              ? null
              : json['avatar'],
          token: json['token'],
          email: email);

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json["fname"] + ' ' + json['lname'],
      avatar: json["avatar"] == 'http://test.touri.sa/app/images/users'
          ? null
          : json['avatar'],
      email: json['email']);
}
/*
  Map<String, dynamic> toJson() => {
        "name": name,
        "avatar": avatar,
      };

*/
