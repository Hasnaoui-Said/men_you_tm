import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> setMenuTest(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> menus = await getMenusTest();
    if (menus.isNotEmpty) {
      int index = menus.indexWhere((menu) => menu['id'] == id);
      if (index != -1) {
        menus.removeAt(index);
        await prefs.setString('menuListItems', json.encode(menus));
        return;
      }
    }
    menus.add({'id': id, 'count': 1});
    await prefs.setString('menuListItems', json.encode(menus));
  }

  static FutureOr<List<Map<String, dynamic>>> getMenusTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var menuListItems = prefs.getString('menuListItems');
    if (menuListItems == null) {
      return [];
    }
    List<dynamic> decodedMenus = json.decode(menuListItems);
    if (decodedMenus.isEmpty) {
      return [];
    }
    List<Map<String, dynamic>> menus = decodedMenus
        .map((menu) => {'id': menu['id'], 'count': menu['count']})
        .toList();
    return menus;
  }

  static Future<void> removeMenuTest(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> menus = await getMenusTest();
    int index = menus.indexWhere((menu) => menu['id'] == id);
    print("remove index $index");
    if (index != -1) {
      menus.removeAt(index);
      await prefs.setString('menuListItems', json.encode(menus));
    }
  }

  static Future<void> removeAllMenusTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('menuListItems');
  }

  static Future<void> incOrDecItemMenu(String id, int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> menus = await getMenusTest();
    menus = menus.map((e) {
      if (e['id'] == id) {
        if (i > 0) {
          e['count'] = int.parse("${e['count']}") + 1;
        } else {
          if (int.parse("${e['count']}") != 1) {
            e['count'] = int.parse("${e['count']}") - 1;
          }
        }
      }
      return e;
    }).toList();

    await prefs.setString('menuListItems', json.encode(menus));
  }
}
