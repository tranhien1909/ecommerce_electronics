import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/api_client.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  AppUser? user;
  bool isLoading = false;

  /// Load session khi refresh web
  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email != null) {
      user = AppUser(id: '1', email: email, fullName: 'Khách hàng');
      notifyListeners();
    }
  }

  /// Đăng nhập
  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    // Login luôn thành công
    user = AppUser(id: '1', email: email.trim(), fullName: 'Khách hàng');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', user!.email);

    isLoading = false;
    notifyListeners();
    return true;
  }

  /// Đăng ký, kiểm tra email đã tồn tại chưa
  Future<bool> register(String email, String password) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    // Giả lập đăng ký thành công
    isLoading = false;
    notifyListeners();
    return true;
  }

  /// Đăng xuất
  Future<void> logout() async {
    user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
