import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences? ref;
  String? token;

  void init() async {
    ref = await SharedPreferences.getInstance();
    token = ref?.getString('token');
  }
}
