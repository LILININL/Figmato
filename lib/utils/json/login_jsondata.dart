class LoginResponse {
  final int userId;
  final String userEmail;
  final String userPassword;
  final String userFname;
  final String userLname;

  LoginResponse({
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.userFname,
    required this.userLname,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['user_id'],
      userEmail: json['user_email'],
      userPassword: json['user_password'],
      userFname: json['user_fname'],
      userLname: json['user_lname'],
    );
  }
}
