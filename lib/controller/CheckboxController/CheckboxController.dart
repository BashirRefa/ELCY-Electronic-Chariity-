
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CheckboxController extends GetxController {
  RxList<bool> isCheckedList = <bool>[].obs;
  RxList<bool> isCheckedListMedical = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the isCheckedList from shared preferences
    _loadCheckboxState();
  }

  void _loadCheckboxState() async {
    final prefs = await SharedPreferences.getInstance();
    isCheckedList.assignAll(List<bool>.generate(
      6, (index) => prefs.getBool('checkbox_$index') ?? false,
    ));
    final prefs2 = await SharedPreferences.getInstance();
    isCheckedListMedical.assignAll(List<bool>.generate(
        11, (index) => prefs2.getBool('checkbox_$index') ?? false
    ));
  }

  void _saveCheckboxState() async {
    final prefs = await SharedPreferences.getInstance();
    final prefs2 = await SharedPreferences.getInstance();
    for (var i = 0; i < isCheckedList.length; i++) {
      prefs.setBool('checkbox_$i', isCheckedList[i]);
    }
    for (var i = 0; i < isCheckedListMedical.length; i++) {
      prefs2.setBool('checkbox_$i', isCheckedListMedical[i]);
    }
  }

  void toggleCheckboxState(int index, bool value) {
    isCheckedList[index] = value;
    _saveCheckboxState();
  }
  void toggleCheckboxState2(int index, bool value) {
    isCheckedListMedical[index]=value;
    _saveCheckboxState();
  }
}