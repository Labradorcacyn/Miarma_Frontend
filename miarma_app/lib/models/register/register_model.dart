class RegisterResponse {
  RegisterResponse({
    required this.avatar,
    required this.birthday,
    required this.fullName,
    required this.email,
    required this.privacy,
    required this.role,
  });
  late final String avatar;
  late final String birthday;
  late final String fullName;
  late final String email;
  late final bool privacy;
  late final String role;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    birthday = json['birthday'];
    fullName = json['fullName'];
    email = json['email'];
    privacy = json['privacy'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['avatar'] = avatar;
    _data['birthday'] = birthday;
    _data['fullName'] = fullName;
    _data['email'] = email;
    _data['privacy'] = privacy;
    _data['role'] = role;
    return _data;
  }
}
