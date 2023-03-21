import 'package:flutter/material.dart';
import 'package:men_you_tm/src/HomeAppState.dart';
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
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: Row(
                children: const [
                  Icon(
                    Icons.person,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OrderPage()));
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "My Orders",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: Row(
                children: const [
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                LocalStorage.removeEmail();
                MaterialPageRoute(builder: (context) => const HomeApp());
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
