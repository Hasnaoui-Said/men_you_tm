import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/models/Restaurant.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/services/RestaurantService.dart';
import 'package:men_you_tm/src/services/converter/RestaurantConverter.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({Key? key, required this.idRestaurant})
      : super(key: key);

  final String idRestaurant;

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Restaurant restaurant;
  late bool _buildRestaurant = false;

  @override
  void initState() {
    super.initState();
    _getRestaurantById();
  }

  Future<void> _getRestaurantById() async {
    RestaurantService service = RestaurantService();
    ResponseBody? res = await service.getRestaurantById(widget.idRestaurant);
    if (res != null) {
      RestaurantConverter converter = RestaurantConverter();
      Restaurant restaurant = await converter.toBean(res.data);
      setState(() {
        this.restaurant = restaurant;
        _buildRestaurant = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          foregroundColor: Colors.white,
          flexibleSpace: _buildRestaurant
              ? Image.network(
                  restaurant.imageStore,
                  fit: BoxFit.cover,
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _buildRestaurant ? restaurant.name : "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _ratingStars(context, _buildRestaurant ? restaurant.rating :0)
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    _buildRestaurant ? restaurant.address:"",
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_buildMenuItems(context)],
            ),
          ],
        ),
      )
    );
  }
  Widget _ratingStars(BuildContext context, double rating) {
    String stars = '';
    String remainingStars = '';
    for (int i = 0; i < rating.round(); i++) {
      stars += '⭐ ';
    }
    for (int i = 0; i < 5 - rating.round(); i++) {
      remainingStars += '☆ ';
    }
    stars.trim();
    return Row(
      children: [
        Text(
          stars,
          style: const TextStyle(
            fontSize: 17.0, // Set color to grey for remaining stars
          ),
        ),
        Text(
          remainingStars,
          style: const TextStyle(
              fontSize: 19.0,
              color: Colors.grey // Set color to grey for remaining stars
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    List<Widget> menuItemsWidget = [];

    if(_buildRestaurant){
      for (int i = 0; i < restaurant.menuItems.length; i += 2) {
        var menuItem1 = restaurant.menuItems[i];
        var menuItem2 = i + 1 < restaurant.menuItems.length ? restaurant.menuItems[i + 1] : null;

        // Create a row with two menu items
        var row = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: _buildMenuItem(context, menuItem1),
            ),
            if (menuItem2 != null)
              Expanded(
                child: _buildMenuItem(context, menuItem2),
              ),
          ],
        );

        menuItemsWidget.add(row);
      }
    }else{
      return const Center(child: CircularProgressIndicator());
    }

    return Column(children: menuItemsWidget);
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1.0, color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Hero(
                    tag: item.imageStore,
                    child: Image.network(
                      item.imageStore,
                      height: 150.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      _addOrRemoveItemToCart(item.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 1.0, color: Colors.deepOrangeAccent),
                      ),
                      child: Icon(
                        Icons.shopping_cart_sharp,
                        color: (item.isAddToCart)
                            ? Colors.deepOrangeAccent
                            : Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.category,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "\$ ${item.price}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _addOrRemoveItemToCart(String id) {
    for (MenuItem item in restaurant.menuItems) {
      if (item.id == id) {
        LocalStorage.setMenuTest(id);
        setState(() {
          item.isAddToCart = !item.isAddToCart;
        });
        return;
      }
    }
  }
}
