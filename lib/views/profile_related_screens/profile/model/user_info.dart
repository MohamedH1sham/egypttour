class UserInfo {
  final String id;
  final String fullname;
  final String email;
  final String password;
  // final List<dynamic>? avatar;
  final String role;
  final bool activateEmail;
  final String token;

  UserInfo({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    // this.avatar,
    required this.role,
    required this.activateEmail,
    required this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final userData = json['data']['users'];
    return UserInfo(
      id: userData['_id'],
      fullname: userData['fullname'],
      email: userData['email'],
      password: userData['password'],
      // avatar: userData['avatar'],
      role: userData['role'],
      activateEmail: userData['activateEmail'],
      token: userData['token'],
    );
  }
}
