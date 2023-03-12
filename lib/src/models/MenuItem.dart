class MenuItem {
  final String id;
  final String name;
  final String imageStore;
  final String description;
  final double price;
  final String category;
  late bool isAddToCart;

  MenuItem(
      {this.id = "",
      this.isAddToCart = false,
      required this.name,
      required this.imageStore,
      required this.description,
      this.price = 0,
      required this.category});

  @override
  String toString() {
    return 'MenuItem{id: $id, name: $name, imageStore: $imageStore, description: $description, price: $price, category: $category}';
  }


}
