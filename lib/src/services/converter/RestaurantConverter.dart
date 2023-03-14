

import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class MenuItemConverter{

  Future<List<MenuItem>> toBeans(dynamic list) async {
    List<MenuItem> items = [];
    List<dynamic> menus = await LocalStorage.getMenus();
    menus ??= [];
    list.forEach((item) {
      items.add(MenuItem(id: item['id'], name: item['name'], description: item['description'], category: item['category'],
          imageStore: item['imageStore'], price: item['price'], isAddToCart: menus.contains(item["id"])));
    });
    return items;
  }
}