import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth_background.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/auth_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool _isEmailValid(String v) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(v);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return AuthBackground(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context), // quay lại Login
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Đăng ký',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),

            AuthFormField(
              controller: nameCtrl,
              hint: 'Nhập họ tên',
              validator: (v) {
                final value = (v ?? '').trim();
                if (value.isEmpty) return 'Vui lòng nhập họ tên';
                if (value.length < 2) return 'Họ tên quá ngắn';
                return null;
              },
            ),
            AuthFormField(
              controller: emailCtrl,
              hint: 'Nhập email',
              validator: (v) {
                final value = (v ?? '').trim();
                if (value.isEmpty) return 'Vui lòng nhập email';
                if (!_isEmailValid(value)) return 'Email không hợp lệ';
                return null;
              },
            ),
            AuthFormField(
              controller: passCtrl,
              hint: 'Nhập mật khẩu',
              obscure: true,
              validator: (v) {
                final value = (v ?? '').trim();
                if (value.isEmpty) return 'Vui lòng nhập mật khẩu';
                if (value.length < 6) return 'Mật khẩu tối thiểu 6 ký tự';
                return null;
              },
            ),

            const SizedBox(height: 10),

            PrimaryButton(
              text: auth.isLoading ? 'Đang xử lý...' : 'Tiếp tục',
              onPressed: auth.isLoading
                  ? () {}
                  : () async {
                      // Validate trước khi gọi API
                      final okForm = _formKey.currentState?.validate() ?? false;
                      if (!okForm) return;

                      final ok = await context.read<AuthProvider>().register(
                        emailCtrl.text,
                        passCtrl.text,
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            ok ? 'Đăng ký thành công' : 'Đăng ký thất bại',
                          ),
                        ),
                      );

                      if (ok) Navigator.pop(context);
                    },
            ),
          ],
        ),
      ),
    );
  }
}
