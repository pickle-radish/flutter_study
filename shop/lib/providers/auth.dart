import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/httpException.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expriyDate = DateTime.now();
  String _userId = '';
  Timer _authTimer = Timer(Duration.zero, () {});
  bool _setTimer = false;

  bool get isAuth {
    return _token.isNotEmpty;
  }

  String get token {
    if (_expriyDate.isAfter(DateTime.now()) && _token.isNotEmpty) {
      return _token;
    }
    return '';
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyB-gP7isUitZeN3gw8tQdDv-Ax0tzT6eWI');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expriyDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expriyDate': _expriyDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    try {
      final extractedUserData =
          json.decode(prefs.getString('userData') as String)
              as Map<String, dynamic>;
      final expiryDate =
          DateTime.parse(extractedUserData['expriyDate'] as String);
      if (expiryDate.isBefore(DateTime.now())) {
        return false;
      }

      _token = extractedUserData['token'] as String;
      _userId = extractedUserData['userId'] as String;
      _expriyDate = expiryDate;
    } catch (err) {
      print(err);
    }

    notifyListeners();
    _autoLogout();
    return true;
  }

  void logout() async {
    _token = '';
    _userId = '';
    _expriyDate = DateTime.now();
    if (_setTimer) {
      _authTimer.cancel();
      _authTimer = Timer(Duration.zero, () {});
      _setTimer = false;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_setTimer) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expriyDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
    _setTimer = true;
  }
}
