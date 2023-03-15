import 'package:flutter/material.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';
import 'package:men_you_tm/src/widgets/order.page.dart';

import '../../main.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 20,),
                    Text("Profile")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPage()
                    )
                );
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  children: const [
                    Icon(Icons.shopping_cart),
                    SizedBox(width: 20,),
                    Text("My Orders")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPage()
                    )
                );
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  children: const [
                    Icon(Icons.settings),
                    SizedBox(width: 20,),
                    Text("Settings")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                LocalStorage.removeEmail();
                MaterialPageRoute(
                    builder: (context) => const HomeApp()
                );
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  children: const [
                    Icon(Icons.logout),
                    SizedBox(width: 20,),
                    Text("Log Out")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
