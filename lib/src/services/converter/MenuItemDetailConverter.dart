import 'package:men_you_tm/src/models/MenuItemDetail.dart';

class MenuItemDetailConverter {

  List<MenuItemsDetail> toBeans(dynamic list) {
    List<MenuItemsDetail> items = [];
    list.forEach((item) {
      MenuItemsDetail menu = toBean(item);
      items.add(menu);
    });
    return items;
  }

  MenuItemsDetail toBean(dynamic item) {
    return MenuItemsDetail(idMenuItem: item['idMenuItem'], count: item['count']);
  }
}
