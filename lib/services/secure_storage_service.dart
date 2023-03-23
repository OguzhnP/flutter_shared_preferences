import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage_example/models/my_models.dart';

class SecureStorageService {
  late final FlutterSecureStorage preferences;

  Future<void> saveDatas(UserInfo userInfo) async {
    final name = userInfo.name;

    await preferences.write(key: "name", value: name);
    await preferences.write(
        key: "gender", value: userInfo.gender.index.toString());
    await preferences.write(
        key: "colors", value: jsonEncode(userInfo.favoriteColors));
    await preferences.write(
        key: "student", value: userInfo.isStudent.toString());
  }

  Future<UserInfo> readDatas() async {
    preferences = FlutterSecureStorage();

    var _name = await preferences.read(key: "name") ?? "";

    var _genderString = await preferences.read(key: "gender") ?? "0";
    var _gender = Gender.values[int.parse(_genderString)];

    var _favoriteColorsString = await preferences.read(key: "colors") ?? "";
    var _favoriteColors = List<String>.from(jsonDecode(_favoriteColorsString));

    var _isStudentString = await preferences.read(key: "student") ?? "false";
    var _isStudent = _isStudentString.toLowerCase() == "true" ? true : false;

    return UserInfo(_name, _gender, _favoriteColors, _isStudent);
  }
}
