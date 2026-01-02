import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // LOGO
              Image.network(
                'https://png.pngtree.com/png-vector/20230705/ourmid/pngtree-electronic-store-logo-vector-png-image_7481118.png',
                width: 160,
              ),

              const SizedBox(height: 30),

              // CARD
              Container(
                width: 360,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
