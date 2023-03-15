import 'package:men_you_tm/src/models/MenuItemDetail.dart';
import 'package:men_you_tm/src/models/Order.dart';
import 'package:men_you_tm/src/services/converter/MenuItemDetailConverter.dart';

class OrderConverter {
  List<Order> toBeans(dynamic orders) {
    List<Order> items = [];
    orders.forEach((order) {
      Order menu = toBean(order);
      items.add(menu);
    });
    return items;
  }

  Order toBean(dynamic order) {
    MenuItemDetailConverter converter = MenuItemDetailConverter();
    List<MenuItemsDetail> items = converter.toBeans(order['menuItemsDetail']);
    return Order(
        menuItemsDetail: items,
        typeOrder: order['typeOrder'],
        customerId: order['customerId'],
        deliveryAddress: order['deliveryAddress'],
        id: order['id'],
        dateCreate: order['dateCreate'],
        status: order['status'],
        timeDelivery: order['timeDelivery'],
        totalPay: order['totalPay'],
    );
  }
}
