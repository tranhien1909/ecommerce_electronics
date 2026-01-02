import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class CheckoutScreen extends StatelessWidget {
  final double totalPrice;

  const CheckoutScreen({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    const shippingFee = 50000.0;
    final finalTotal = totalPrice + shippingFee;

    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== ADDRESS =====
            const Text(
              'Vị trí giao hàng',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Đại học Sài Gòn'),
                        Text(
                          '475 An Dương Vương, Phường 3, Quận 5',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text('Thay đổi', style: TextStyle(color: AppColors.primary)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== PAYMENT METHOD =====
            const Text(
              'Hình thức thanh toán',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _paymentTile(
              image:
                  'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
              title: 'Thẻ ngân hàng',
              selected: true,
            ),
            _paymentTile(
              image:
                  'https://png.pngtree.com/png-clipart/20190322/ourmid/pngtree-creative-stereo-dollar-stacked-paper-money-elements-png-image_858180.jpg',
              title: 'Tiền mặt',
              selected: false,
            ),

            const Spacer(),

            // ===== SUMMARY =====
            Column(
              children: [
                _summaryRow('Tổng tiền sản phẩm', totalPrice),
                _summaryRow('Phí vận chuyển', shippingFee),
                const Divider(),
                _summaryRow('Tổng tiền', finalTotal, bold: true),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thanh toán thành công (demo)'),
                        ),
                      );
                    },
                    child: const Text(
                      'Thanh toán',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile({
    required String image,
    required String title,
    required bool selected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Icon(
            selected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: selected ? AppColors.primary : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '${value.toStringAsFixed(0)} đ',
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
