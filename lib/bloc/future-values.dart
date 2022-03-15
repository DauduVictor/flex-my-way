import 'package:flex_my_way/database/user-db-helper.dart';
import '../model/user.dart';

class FutureValues {

  ///Function to get current [user] in the database using the
  ///[DataBase] class
  Future<User> getCurrentUser() async {
    var db = DatabaseHelper();
    Future<User> user = db.getUser();
    return user;
  }
}