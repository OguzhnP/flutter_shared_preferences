import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:storage_example/models/my_models.dart';
import 'package:storage_example/services/shared_pref_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedGender = Gender.KADIN;
  var isStudent = false;
  List<String> selectedColors = [];
  TextEditingController nameController = TextEditingController();
  final _prefService = SharedPreferenceService();

  @override
  void initState() {
    super.initState();
    readDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("Shared Preferences Kullanımı"),
      ),
      body: Padding(
        padding: 20.allP,
        child: ListView(
          children: [
            ListTile(
              title: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Adınızı giriniz',
                  prefixIcon: const Icon(CupertinoIcons.person_2_fill),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0.0,
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
              ),
            ),
            for (var item in Gender.values)
              _buildRadioListTiles(describeEnum(item), item),
            for (var item in FavoriteColors.values)
              Padding(
                padding: 18.horizontalP,
                child: _buildCheckboxListTiles(item),
              ),
            _buildSwitchButton(),
            OutlinedButton(
              onPressed: () {
                var userInfo = UserInfo(nameController.text, selectedGender,
                    selectedColors, isStudent);
                _prefService.saveDatas(userInfo);
              },
              child: const Text("Kaydet"),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildSwitchButton() {
    return Padding(
      padding: 35.horizontalP,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Öğrenci misin?",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          CupertinoSwitch(
            value: isStudent,
            onChanged: (value) {
              setState(() {
                isStudent = value;
              });
            },
          ),
        ],
      ),
    );
  }

  CheckboxListTile _buildCheckboxListTiles(FavoriteColors favoriteColors) {
    return CheckboxListTile(
      title: Text(describeEnum(favoriteColors)),
      value: selectedColors.contains(describeEnum(favoriteColors)),
      onChanged: (bool? value) {
        if (value == false) {
          selectedColors.remove(describeEnum(favoriteColors));
        } else {
          selectedColors.add(describeEnum(favoriteColors));
        }
        setState(() {});
      },
    );
  }

  RadioListTile<Gender> _buildRadioListTiles(String title, Gender gender) {
    return RadioListTile(
        title: Text(title),
        value: gender,
        groupValue: selectedGender,
        onChanged: (value) {
          setState(() {
            selectedGender = value!;
          });
        });
  }

  void readDatas() async {
    var info = await _prefService.readDatas();
    nameController.text = info.name;
    selectedGender = info.gender;
    selectedColors = info.favoriteColors;
    isStudent = info.isStudent;
    setState(() {});
  }
}
