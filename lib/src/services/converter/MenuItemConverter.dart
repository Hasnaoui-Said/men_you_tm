import 'dart:ffi';

import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class MenuItemConverter {
  Future<List<MenuItem>> toBeans(dynamic list) async {
    List<MenuItem> items = [];
    list.forEach((item) async {
      MenuItem menu = await toBean(item);
      items.add(menu);
    });
    return items;
  }

  Future<MenuItem> toBean(dynamic item) async {
    List<Map<String, dynamic>> menus = await LocalStorage.getMenusTest();

    List<String> ids = menus.map((e) => e['id'].toString()).toList();
    int count = 0;
    for (var menu in menus) {
      if(menu['id'] == item['id']){
        count = int.parse("${menu["count"]}");
      }
    }


    return MenuItem(
        count: count,
        id: item['id'],
        name: item['name'],
        description: item['description'],
        category: item['category'],
        imageStore: item['imageStore'],
        price: item['price'],
        isAddToCart: menus.isNotEmpty ? ids.contains(item["id"]) : false);
  }
}
