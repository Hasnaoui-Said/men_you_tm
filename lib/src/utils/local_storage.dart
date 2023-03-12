import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> setMenu(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> menus = await getMenus();
    menus ??= [];
    if (menus.contains(item)) {
      removeMenu(item);
      return;
    }

    // print("Add To cart $item");
    menus.add(item);
    await prefs.setString('menuListItems', json.encode(menus));
  }

  static FutureOr<List<dynamic>> getMenus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var menuListItems = prefs.getString('menuListItems');
    return menuListItems == null ? [] : json.decode(menuListItems);
  }

  static FutureOr<void> removeMenu(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> menus = await getMenus();
    menus ??= [];
    if (!menus.contains(item)) {
      // print("Item no found $item");
      return;
    }
    // print("Remove item in cart $item");
    menus.remove(item);
    await prefs.setString('menuListItems', json.encode(menus));
  }
}
