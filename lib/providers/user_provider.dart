import 'package:flutter/cupertino.dart';
import 'package:rent_a_car_design_four/database/db_helper.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  Future<UserModel?> getUserByEmail(String email) {
    return DbHelper.getUserByEmail(email);
  }

  Future<int> insertNewUser(UserModel userModel) {
    return DbHelper.insertUser(userModel);
  }
}
