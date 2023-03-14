import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class RestaurantService{

  final String url = "http://165.232.123.254:9090/api/v1";

  Future<ResponseBody?> fetch() async {
    String url ='${this.url}/restaurant/';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        ResponseBody? items = ResponseBody(data: body['data'], success: body['success'], message: body['message']);
        return items;
      } else {
        throw Exception('Failed to load List restaurant');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ResponseBody?> getRestaurantById(String idRestaurant) async {
    String url ='${this.url}/restaurant/$idRestaurant';
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