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
    final id = prefs.getString('userId');
    final email = prefs.getString('email');
    final fullName = prefs.getString('fullName');

    if (id != null && email != null && fullName != null) {
      user = AppUser(id: id, email: email, fullName: fullName);
      notifyListeners();
    }
  }

  /// Đăng nhập
  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await ApiClient.dio.get('/users');
      final List list = res.data;

      final found = list.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => null,
      );

      if (found == null) return false;

      user = AppUser.fromJson(found);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user!.id);
      await prefs.setString('email', user!.email);
      await prefs.setString('fullName', user!.fullName);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Đăng ký, kiểm tra email đã tồn tại chưa
  Future<bool> register(String fullName, String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      // 1) Check trùng email
      final res = await ApiClient.dio.get('/users');
      final List list = res.data;
      final existed = list.any((u) => u['email'] == email);
      if (existed) return false;

      // 2) Post tạo user
      final created = await ApiClient.dio.post(
        '/users',
        data: {'fullName': fullName, 'email': email, 'password': password},
      );

      // 3) Đảm bảo API trả về object có id
      final data = created.data;
      if (data == null || data['id'] == null) return false;

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Đăng xuất
  Future<void> logout() async {
    user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
