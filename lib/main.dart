import 'package:flutter/material.dart';
import 'package:men_you_tm/src/widgets/cart.page.dart';
import 'package:men_you_tm/src/widgets/categories.page.dart';
import 'package:men_you_tm/src/widgets/home.page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeAppState());
  }
}

class HomeAppState extends StatefulWidget {
  const HomeAppState({super.key});

  @override
  State<HomeAppState> createState() => _HomeAppStateState();
}

class _HomeAppStateState extends State<HomeAppState> {
  int currentPageIndex = 0;
  final tabs = [
    const HomePage(),
    const CategoriesPage(),
    const CartPage(),
    const Center(
      child: Text("Setting"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 20,
        unselectedFontSize: 17,
        selectedItemColor: Colors.orange,
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
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


  Widget builds(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home, color: Colors.orange),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.category,
              color: Colors.orange,
            ),
            label: 'Categories',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.orange,
            ),
            icon: Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.orange,
            ),
            label: 'Cart',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.more_horiz,
              color: Colors.orange,
            ),
            icon: Icon(
              Icons.more_horiz,
              color: Colors.orange,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        const HomePage(),
        const CategoriesPage(),
        const CartPage(),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
      ][currentPageIndex],
    );
  }
}