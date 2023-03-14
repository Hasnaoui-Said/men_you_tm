import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/services/MenuItemService.dart';
import 'package:men_you_tm/src/services/converter/MenuItemConverter.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

import '../models/domains/ResponseBody.dart';

class CatItemHome extends StatefulWidget {
  const CatItemHome({super.key});

  @override
  State<CatItemHome> createState() => _CatItemHomeState();
}

class _CatItemHomeState extends State<CatItemHome> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> items = [];
  List<MenuItem> listItems = [];

  int currentPage = 0;
  int totalPage = 0;
  int sizePage = 10;

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPage - 1) {
          currentPage++;
          _getData();
        }
      }
    });
  }

  Future<void> _getData() async {
    MenuItemService service = MenuItemService();
    ResponseBody? res = await service.fetchItems(currentPage, sizePage);
    if (res != null) {
      items.addAll(res.data['content']);
      MenuItemConverter converter = MenuItemConverter();
      List<MenuItem> menuItems = await converter.toBeans(items);
      setState(() {
        listItems.addAll(menuItems);
        totalPage = res.data['totalPages'];

        print("items length: ${listItems.length}");
        print("totalPages: $totalPage");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      controller: _scrollController,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Categories"),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'List of menu',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Column(
              children: [_buildMenuItems(context)],
            ),
          ],
        )
      ],
    ));
  }

  Widget _buildMenuItems(BuildContext context) {
    List<Widget> menuItemsWidget = [];

    // Iterate through the list items in pairs
    for (int i = 0; i < listItems.length; i += 2) {
      var menuItem1 = listItems[i];
      var menuItem2 = i + 1 < listItems.length ? listItems[i + 1] : null;

      // Create a row with two menu items
      var row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _buildMenuItem(context, menuItem1),
          ),
          if (menuItem2 != null)
            Expanded(
              child: _buildMenuItem(context, menuItem2),
            ),
        ],
      );

      menuItemsWidget.add(row);
    }

    return Column(children: menuItemsWidget);
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1.0, color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Hero(
                    tag: item.imageStore,
                    child: Image.network(
                      item.imageStore,
                      height: 150.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      _addOrRemoveItemToCart(item.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 1.0, color: Colors.deepOrangeAccent),
                      ),
                      child: Icon(
                        Icons.shopping_cart_sharp,
                        color: (item.isAddToCart)
                            ? Colors.deepOrangeAccent
                            : Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.category,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "${item.price}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addOrRemoveItemToCart(String id) {
    for (MenuItem item in listItems) {
      if (item.id == id) {
        LocalStorage.setMenu(id);
        setState(() {
          item.isAddToCart = !item.isAddToCart;
        });
        return;
      }
    }
  }
}
