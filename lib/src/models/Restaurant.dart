import 'package:men_you_tm/src/models/MenuItem.dart';

class Restaurant {
  final String id;
  final String name;
  final String imageStore;
  final String address;
  final double rating;
  final String phone;
  final List<MenuItem> menuItems;

  Restaurant(
      {this.id = "",
      required this.name,
      required this.imageStore,
      required this.address,
      required this.rating,
      required this.phone,
      required this.menuItems});

  @override
  String toString() {
    return 'Restaurant{id: $id, name: $name, imageStore: $imageStore, address: $address, rating: $rating, phone: $phone, menuItems: $menuItems}';
  }
}
