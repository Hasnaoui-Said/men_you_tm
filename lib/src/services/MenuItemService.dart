import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';

class MenuItemService{
  final String url = "http://165.232.123.254:9090/api/v1";


  Future<ResponseBody?> fetchItems(int currentPage, int sizePage) async {
    String url ='${this.url}/menu-item/?page=$currentPage&size=$sizePage';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        ResponseBody? items = ResponseBody(data: body['data'], success: body['success'], message: body['message']);
        return items;
      } else {
        throw Exception('Failed to load Menu items');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
  Future<ResponseBody?> getMenuItemById(String id) async {
    String url ='${this.url}/menu-item/$id';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        ResponseBody? items = ResponseBody(data: body['data'], success: body['success'], message: body['message']);
        return items;
      } else {
        throw Exception('Failed to load restaurant by id');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}