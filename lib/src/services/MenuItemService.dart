import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class MenuItemService{


  Future<ResponseBody?> fetchItems(int currentPage, int sizePage) async {
    String url ='http://165.232.123.254:9090/api/v1/menu-item/?page=$currentPage&size=$sizePage';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        ResponseBody? items = ResponseBody(data: body['data'], success: body['success'], message: body['message']);
        return items;
      } else {
        throw Exception('Failed to load wallet');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<MenuItem>> convertData(dynamic list) async {
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