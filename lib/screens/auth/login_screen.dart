import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth_background.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/primary_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return AuthBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TAB
          Row(
            children: [
              const Text(
                'Đăng nhập',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          AuthTextField(controller: emailCtrl, hint: 'Nhập email'),
          AuthTextField(
            controller: passCtrl,
            hint: 'Nhập mật khẩu',
            obscure: true,
            showToggle: true, // 👈 bật icon con mắt
          ),

          const SizedBox(height: 10),

          PrimaryButton(
            text: auth.isLoading ? 'Đang xử lý...' : 'Đăng nhập',
            onPressed: auth.isLoading
                ? () {}
                : () async {
                    final ok = await context.read<AuthProvider>().login(
                      emailCtrl.text,
                      passCtrl.text,
                    );
                    if (!ok && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sai thông tin đăng nhập'),
                        ),
                      );
                    }
                  },
          ),

          const SizedBox(height: 12),
          const Center(
            child: Text('Quên mật khẩu?', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
