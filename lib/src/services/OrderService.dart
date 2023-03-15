import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:men_you_tm/src/models/MenuItemDetail.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

import '../models/Order.dart';

class OrderService {
  final String url = "http://165.232.123.254:9090/api/v1";

  Future<ResponseBody?> save(String email, String address, String typeOrder) async {
    Order order = await _getOrder(email, address, typeOrder);
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(Uri.parse('$url/order/'), headers: headers, body: json.encode(order));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      ResponseBody? items = ResponseBody(
          data: body['data'],
          success: body['success'],
          message: body['message']);
      return items;
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<ResponseBody?> saves(
      String email, String address, String typeOrder) async {
    Order order = await _getOrder(email, address, typeOrder);
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$url/order/'));
    request.body = json.encode(order);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic resp = await response.toString();
      print(resp);
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<ResponseBody?> getOrderByCostumerId(String costumerId) async {
    String url = '${this.url}/order/costumer/$costumerId';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        ResponseBody? items = ResponseBody(
            data: body['data'],
            success: body['success'],
            message: body['message']);
        return items;
      } else {
        throw Exception('Failed to load order by costumer id');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ResponseBody?> getOrderId(String id) async {
    String url = '${this.url}/order/$id';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        ResponseBody? items = ResponseBody(
            data: body['data'],
            success: body['success'],
            message: body['message']);
        return items;
      } else {
        throw Exception('Failed to load order by id');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
  Future<ResponseBody?> validateOrder(String id) async {
    // String url = '${this.url}/order/$id';
    // try {
    //   var response = await http.get(Uri.parse(url));
    //   if (response.statusCode == 200) {
    //     var body = jsonDecode(response.body);
    //     ResponseBody? items = ResponseBody(
    //         data: body['data'],
    //         success: body['success'],
    //         message: body['message']);
    //     return items;
    //   } else {
    //     throw Exception('Failed to load order by id');
    //   }
    // } catch (e) {
    //   print(e);
    // }
    return null;
  }

  Future<Order> _getOrder(
      String email, String address, String typeOrder) async {
    List<Map<String, dynamic>> menus = await LocalStorage.getMenusTest();

    List<MenuItemsDetail> itemDetails = menus
        .map((item) =>
            MenuItemsDetail(idMenuItem: item['id'], count: item['count']))
        .toList();

    return Order(
        typeOrder: typeOrder,
        deliveryAddress: address,
        menuItemsDetail: itemDetails,
        customerId: email);
  }
}
