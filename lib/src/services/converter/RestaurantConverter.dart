import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/models/Restaurant.dart';
import 'package:men_you_tm/src/services/converter/MenuItemConverter.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class RestaurantConverter {
  Future<List<Restaurant>> toBeans(dynamic list) async {
    List<Restaurant> restaurants = [];
    MenuItemConverter menuItemConverter = MenuItemConverter();
    list.forEach((restaurant) async {
      restaurants.add(Restaurant(
          id: restaurant["id"],
          name: restaurant["name"],
          imageStore: restaurant["imageStore"],
          address: restaurant["address"],
          rating: double.parse(restaurant["rating"]),
          phone: restaurant["phone"],
          menuItems: await menuItemConverter.toBeans(restaurant["menuItems"])));
    });
    return restaurants;
  }
  Future<Restaurant> toBean(dynamic restaurant) async {
    MenuItemConverter menuItemConverter = MenuItemConverter();
      return Restaurant(
          id: restaurant["id"],
          name: restaurant["name"],
          imageStore: restaurant["imageStore"],
          address: restaurant["address"],
          rating: double.parse(restaurant["rating"]),
          phone: restaurant["phone"],
          menuItems: await menuItemConverter.toBeans(restaurant["menuItems"]));
  }
}
