import 'package:flutter/material.dart';
import 'package:men_you_tm/src/widgets/cart.page.dart';
import 'package:men_you_tm/src/widgets/restaurant.page.dart';
import 'package:men_you_tm/src/widgets/home.page.dart';
import 'package:men_you_tm/src/widgets/setting.page.dart';

class HomeAppState extends StatefulWidget {
  const HomeAppState({super.key});

  @override
  State<HomeAppState> createState() => _HomeAppStateState();
}

class _HomeAppStateState extends State<HomeAppState> {
  int currentPageIndex = 0;
  final tabs = [
    const HomePage(),
    const RestaurantPage(),
    const CartPage(),
    const SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 20,
        unselectedFontSize: 17,
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Restaurant",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }


  //
  // Widget builds(BuildContext context) {
  //   return Scaffold(
  //     bottomNavigationBar: NavigationBar(
  //       onDestinationSelected: (int index) {
  //         setState(() {
  //           currentPageIndex = index;
  //         });
  //       },
  //       selectedIndex: currentPageIndex,
  //       destinations: const <Widget>[
  //         NavigationDestination(
  //           icon: Icon(Icons.home),
  //           label: 'Home',
  //         ),
  //         NavigationDestination(
  //           icon: Icon(
  //             Icons.category,
  //           ),
  //           label: 'Categories',
  //         ),
  //         NavigationDestination(
  //           selectedIcon: Icon(
  //             Icons.add_shopping_cart_outlined,
  //           ),
  //           icon: Icon(
  //             Icons.add_shopping_cart_outlined,
  //           ),
  //           label: 'Cart',
  //         ),
  //         NavigationDestination(
  //           selectedIcon: Icon(
  //             Icons.more_horiz,
  //           ),
  //           icon: Icon(
  //             Icons.more_horiz,
  //           ),
  //           label: 'Settings',
  //         ),
  //       ],
  //     ),
  //     body: <Widget>[
  //       const HomePage(),
  //       const CategoriesPage(),
  //       const CartPage(),
  //       Container(
  //         color: Colors.green,
  //         alignment: Alignment.center,
  //         child: const Text('Page 2'),
  //       ),
  //     ][currentPageIndex],
  //   );
  // }
}
