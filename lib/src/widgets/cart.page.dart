import 'package:flutter/material.dart';

void main() => runApp(CartPage());

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart page'),),
      body: const Center(
        child: Text("Hello"),
      ),
    );
  }
}
