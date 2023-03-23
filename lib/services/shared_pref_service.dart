import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_example/models/my_models.dart';

class SharedPreferenceService {
  Future<void> saveDatas(UserInfo userInfo) async {
    final name = userInfo.name;
    final preferences = await SharedPreferences.getInstance();

    preferences.setString("name", name);
    preferences.setInt("gender", userInfo.gender.index);
    preferences.setStringList("colors", userInfo.favoriteColors);
    preferences.setBool("student", userInfo.isStudent);
  }

  Future<UserInfo> readDatas() async {
    final preferences = await SharedPreferences.getInstance();

    var _name = preferences.getString("name") ?? "";
    var _gender = Gender.values[preferences.getInt("gender") ?? 0];
    var _favoriteColors = preferences.getStringList("colors") ?? [];
    var _isStudent = preferences.getBool("student") ?? false;

    return UserInfo(_name, _gender, _favoriteColors, _isStudent);
  }
}
