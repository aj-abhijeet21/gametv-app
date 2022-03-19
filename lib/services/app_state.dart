import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider extends ChangeNotifier {
  String user = '';

  Future<void> setUser(String userName) async {
    user = userName;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', userName);

    notifyListeners();
  }

  void logoutUser() async {
    user = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    notifyListeners();
  }
}
