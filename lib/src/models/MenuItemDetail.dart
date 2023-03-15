
class Order {
  String typeOrder;
  String deliveryAddress;
  List<MenuItemsDetail> menuItemsDetail;
  String customerId;

  Order({
    required this.typeOrder,
    required this.deliveryAddress,
    required this.menuItemsDetail,
    required this.customerId,
  });
}