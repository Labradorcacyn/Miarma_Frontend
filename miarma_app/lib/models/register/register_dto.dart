class RegisterDTO {
  RegisterDTO({
    required this.avatar,
    required this.fullname,
    required this.birthday,
    required this.email,
    required this.password,
    required this.password2,
    required this.privacy,
  });
  late final String avatar;
  late final String fullname;
  late final DateTime birthday;
  late final String email;
  late final String password;
  late final String password2;
  late final String privacy;

  RegisterDTO.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    fullname = json['fullname'];
    birthday = json['birthday'];
    email = json['email'];
    password = json['password'];
    password2 = json['password2'];
    privacy = json['privacy'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['avatar'] = avatar;
    _data['fullname'] = fullname;
    _data['birthday'] = birthday;
    _data['email'] = email;
    _data['password'] = password;
    _data['password2'] = password2;
    _data['privacy'] = privacy;
    return _data;
  }
}
