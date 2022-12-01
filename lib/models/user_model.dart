const String tblUser = 'tbl_user';
const String tblUserColId = 'user_id';
const String tblUserColEmail = 'email';
const String tblUserColPassword = 'password';
const String tblUserColAdmin = 'admin';

class UserModel {
  int? userId;
  String email;
  String password;
  bool isAdmin;

  UserModel({
    this.userId,
    required this.email,
    required this.password,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblUserColEmail: email,
      tblUserColPassword: password,
      tblUserColAdmin: isAdmin ? 1 : 0,
    };
    if (userId != null) {
      map[tblUserColId] = userId;
    }
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        userId: map[tblUserColId],
        email: map[tblUserColEmail],
        password: map[tblUserColPassword],
        isAdmin: map[tblUserColAdmin] == 0 ? false : true,
      );
}
