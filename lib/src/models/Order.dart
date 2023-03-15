
import 'package:men_you_tm/src/models/MenuItemDetail.dart';

class Order {

  String id;
  String typeOrder;
  String dateCreate;
  String timeDelivery;
  String deliveryAddress;
  List<MenuItemsDetail> menuItemsDetail;
  String customerId;
  double totalPay;
  bool status;

  Order({
    this.id = "",
    this.dateCreate = "",
    this.timeDelivery = "",
    this.totalPay = 0,
    this.status = false,
    required this.typeOrder,
    required this.deliveryAddress,
    required this.menuItemsDetail,
    required this.customerId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeOrder'] = this.typeOrder;
    data['deliveryAddress'] = this.deliveryAddress;
    data['menuItemsDetail'] =
        menuItemsDetail.map((e) => e.toJson()).toList();
    data['customerId'] = this.customerId;
    return data;
  }

  @override
  String toString() {
    return 'Order{typeOrder: $typeOrder, deliveryAddress: $deliveryAddress, menuItemsDetail: $menuItemsDetail, customerId: $customerId}';
  }
}