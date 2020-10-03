import 'package:hive/hive.dart';

enum UserType{
  user, admin
}

class UserTypeDb{

  Box box;

  UserTypeDb();

  static Future<UserTypeDb> getDb() async{
    final db = UserTypeDb();
    db.initBox();
    return db;
  }

  Future<void> initBox() async {
    if (this.box == null) {
      this.box = await Hive.openBox("user type");
    }
  }

  Future<void> setUserType(UserType type) async{
    await this.initBox();
    return await this.box.put("password",_getUserTypeString(type));
  }

  Future<String> getUserType() async{
    await this.initBox();
    return await this.box.get("password");
  }


  void delete() async {
    return this.box.delete("user type");
  }

  bool isEmpty() {
    return this.box.isEmpty;
  }

  static String _getUserTypeString(UserType type){
    switch(type){
      case UserType.admin : return "admin";
      case UserType.user : return "user";
      default: return "user";
    }
  }
}