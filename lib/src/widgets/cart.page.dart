import 'package:flutter/material.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> menuItemsCart = [];

  @override
  void initState() {
    super.initState();
    _getMenuCart();
  }

  Future<void> _getMenuCart() async {
    List<dynamic> menus = await LocalStorage.getMenus();
    setState(() {
      menuItemsCart = menus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart page'),
      ),
      body: Center(
        child: Text("cart item $menuItemsCart"),
      ),
    );
  }
}
