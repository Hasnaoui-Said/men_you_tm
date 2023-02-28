import 'package:flutter/material.dart';
import 'package:men_you_tm/src/widgets/CatItemHome.page.dart';

import 'SearchBar.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Order Best',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Foot Fast',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Image.asset(
                  'assets/images/logo_tm.jpg',
                  width: 95,
                ))
          ],
        ),
      ),
      // body: SearchBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: const [
              SearchBar(),
              CatItemHome(),
            ],
          ),
          // children: [
          //   ListView(
          //     children: const [
          //       SearchBar(),
          //       Divider(height: 4),
          //       Text(
          //         "Categories",
          //         style: TextStyle(color: Colors.black54, fontSize: 22),
          //       ),
          //     ],
          //   ),
          //
          // ],
        ),
      ),
    );
  }
}

class ClipRRectExample extends StatelessWidget {
  const ClipRRectExample({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: Colors.white);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              maxWidth: 300,
              maxHeight: 100,
            ),
            color: Colors.blue,
            child: const Text('No ClipRRect', style: style),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                maxWidth: 300,
                maxHeight: 100,
              ),
              color: Colors.green,
              child: const Text('ClipRRect', style: style),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(40.0),
            ),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                maxWidth: 300,
                maxHeight: 100,
              ),
              color: Colors.purple,
              child: const Text('ClipRRect', style: style),
            ),
          ),
        ],
      ),
    );
  }
}
