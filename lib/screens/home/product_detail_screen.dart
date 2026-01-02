import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../providers/product_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/auth_provider.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import '../../utils/logout_helper.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>().getById(widget.productId);

    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('Không tìm thấy sản phẩm')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(product.name, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      // ===== BODY =====
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // NAME
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // PRICE
            Text(
              '${product.price.toStringAsFixed(0)} đ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 12),

            // CATEGORY
            Text(
              'Danh mục: ${product.category}',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 16),

            // DESCRIPTION
            Text(product.description, style: const TextStyle(fontSize: 15)),

            const SizedBox(height: 30),

            // ADD TO CART
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B5FB5), // tím như mockup
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text(
                  'Thêm vào giỏ hàng',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  context.read<CartProvider>().addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã thêm vào giỏ hàng')),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ===== BOTTOM NAV =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        onTap: (index) {
          setState(() => _currentIndex = index);

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          }
          if (index == 2) {
            _showProfileSheet(context);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
      ),
    );
  }

  // ===== PROFILE SHEET =====
  void _showProfileSheet(BuildContext context) {
    final auth = context.read<AuthProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person, size: 60),
            const SizedBox(height: 12),
            Text(
              auth.user?.fullName ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(auth.user?.email ?? ''),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () {
                Navigator.pop(context); // đóng sheet
                logoutAndGoToLogin(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
