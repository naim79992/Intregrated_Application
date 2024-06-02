import 'package:flutter/material.dart';
import 'package:port/Fragment/personal_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Predefined user credentials
  final Map<String, String> _predefinedUsers = {
    'user1@gmail.com': 'password1',
    'user2@gmail.com': 'password2',
  };

  List<PersonalInfo> _personalInfoList = [];

  List<PersonalInfo> get personalInfoList => _personalInfoList;

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    final storedPassword = prefs.getString('password');

    // Check predefined users first
    if (_predefinedUsers.containsKey(email) &&
        _predefinedUsers[email] == password) {
      _isLoggedIn = true;
      notifyListeners();
    }
    // Then check shared preferences
    else if (email == storedEmail && password == storedPassword) {
      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception('Incorrect email or password');
    }
  }

  Future<void> signUp(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void addPersonalInfo(PersonalInfo personalInfo) {
    _personalInfoList.add(personalInfo);
    notifyListeners();
  }
}
