
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatItemHome extends StatefulWidget{
  const CatItemHome({super.key});

  @override
  State<CatItemHome> createState() => _CatItemHomeState();
}

class _CatItemHomeState extends State<CatItemHome> {
@override
Widget build(BuildContext context) {
return Container(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.topLeft,
        child: const Text(
          "Categories",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 22,
          ),
          textAlign: TextAlign.start,
        ),
      ),

      SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: const [
            Text("data")
          ],
        ),
      )
    ],

  ),
);
}
}


