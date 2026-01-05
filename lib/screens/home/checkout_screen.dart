import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

enum PaymentMethod { bank, cash }

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;

  const CheckoutScreen({super.key, required this.totalPrice});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.bank;

  @override
  Widget build(BuildContext context) {
    const shippingFee = 50000.0;
    final finalTotal = widget.totalPrice + shippingFee;

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

            _paymentRadioTile(
              image:
                  'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
              title: 'Thẻ ngân hàng',
              value: PaymentMethod.bank,
            ),
            _paymentRadioTile(
              image:
                  'https://png.pngtree.com/png-clipart/20190322/ourmid/pngtree-creative-stereo-dollar-stacked-paper-money-elements-png-image_858180.jpg',
              title: 'Tiền mặt',
              value: PaymentMethod.cash,
            ),

            const Spacer(),

            // ===== SUMMARY =====
            Column(
              children: [
                _summaryRow('Tổng tiền sản phẩm', widget.totalPrice),
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
                        SnackBar(
                          content: Text(
                            _selectedMethod == PaymentMethod.bank
                                ? 'Thanh toán bằng thẻ ngân hàng thành công'
                                : 'Thanh toán tiền mặt thành công',
                          ),
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

  // ===== RADIO TILE =====
  Widget _paymentRadioTile({
    required String image,
    required String title,
    required PaymentMethod value,
  }) {
    final selected = _selectedMethod == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethod = value;
        });
      },
      child: Container(
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
