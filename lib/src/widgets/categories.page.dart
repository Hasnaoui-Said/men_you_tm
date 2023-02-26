import 'package:flutter/material.dart';

void main() => runApp(CategoriesPage());

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat page'),),
      body: const Center(
        child: Text("Hello"),
      ),
    );
  }
}
