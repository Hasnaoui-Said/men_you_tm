import 'package:men_you_tm/src/models/Order.dart';

class OrderConverter {
  Future<List<Order>> toBeans(dynamic list) async {
    List<Order> items = [];
    list.forEach((item) async {
      Order menu = await toBean(item);
      items.add(menu);
    });
    return items;
  }

  Future<Order> toBean(dynamic item) async {

    return Order();
  }
}
