import 'package:flutter/material.dart';

enum PaymentMethod { payOnDelivery, cashOnDelivery }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod? _selectedPaymentMethod = PaymentMethod.payOnDelivery; // Default option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Confirmation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.orange, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Order Confirmed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const SizedBox(height: 10),
            const Text(
              'Thank you for your payment.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const Text(
              'Select a Payment Method',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Option for Pay on Delivery
            RadioListTile<PaymentMethod>(
              title: const Text("Pay on Delivery"),
              value: PaymentMethod.payOnDelivery,
              groupValue: _selectedPaymentMethod,
              onChanged: (PaymentMethod? value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            // Option for Cash on Delivery
            RadioListTile<PaymentMethod>(
              title: const Text("Cash on Delivery (Mobile Money)"),
              value: PaymentMethod.cashOnDelivery,
              groupValue: _selectedPaymentMethod,
              onChanged: (PaymentMethod? value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 40),
            // Show appreciation messages based on payment method
            if (_selectedPaymentMethod == PaymentMethod.payOnDelivery) ...[
              const Text(
                'Thank you for trusting us! Your delivery person is on the way.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ] else if (_selectedPaymentMethod == PaymentMethod.cashOnDelivery) ...[
              const Text(
                'Thank you for choosing to pay with Mobile Money! We appreciate your trust.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // You can add navigation or further actions here, if necessary.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _selectedPaymentMethod == PaymentMethod.payOnDelivery
                          ? 'You selected: Pay on Delivery'
                          : 'You selected: Cash on Delivery (Mobile Money)',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
