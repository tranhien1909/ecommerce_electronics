import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../main.dart';

void logoutAndGoToLogin(BuildContext context) async {
  final auth = context.read<AuthProvider>();
  await auth.logout();

  if (!context.mounted) return;

  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const Root()),
    (route) => false,
  );
}
