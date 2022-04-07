import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
/**
 * created by IT19123196(K.H.T.N Dewangi)
 */

/**From Tutorial
 * Get user details 
 * initialize auth service class and we can call getUserDetails() method in auth service 
 * class
 * notifyListeners() notify all listeners to the user provider
 * that data global variable changed to update value
 * refreshUser() - user variable update
 */
class UserProvider with ChangeNotifier {
  User? _user;
  final AuthService _auth = AuthService();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
