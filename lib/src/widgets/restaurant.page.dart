import 'package:flutter/material.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/services/RestaurantService.dart';
import 'package:men_you_tm/src/services/converter/RestaurantConverter.dart';
import 'package:men_you_tm/src/widgets/rastaurantDetail.page.dart';

import '../models/Restaurant.dart';

void main() => runApp(const RestaurantPage());

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  List<dynamic> items = [];
  List<Restaurant> listRestaurants = [];

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    RestaurantService service = RestaurantService();
    ResponseBody? res = await service.fetch();
    if (res != null) {
      items.addAll(res.data);
      RestaurantConverter converter = RestaurantConverter();
      List<Restaurant> restaurants = await converter.toBeans(items);
      setState(() {
        listRestaurants.addAll(restaurants);
      });
    }
    print("items length: ${listRestaurants.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: MySearchDelegate(),
                    );
                  },
                  child: const Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.black26,
                      letterSpacing: 2,
                      fontSize: 17,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black26,
                  ),
                  onPressed: () => {
                    showSearch(context: context, delegate: MySearchDelegate())
                  },
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestaurantDetailPage(
                                      idRestaurant: listRestaurants[index].id,
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 25.0,
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
                                    tag: listRestaurants[index].imageStore,
                                    child: Image.network(
                                      listRestaurants[index].imageStore,
                                      height: 220.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        listRestaurants[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      _ratingStars(context, listRestaurants[index].rating)
                                    ],
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        listRestaurants[index].address,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
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
                  },
                  // separatorBuilder: (context, index) => const Divider(height: 10,),
                  itemCount: listRestaurants.length
              )
          )
        ],
      ),
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

}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    "Pizza",
    "Hamburger",
    "Chicken Legs",
    "Taco",
    "Drinks"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () => {
                if (query.isEmpty) {close(context, null)} else {query = ""}
              },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => {query = '', close(context, null)},
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> suggestions = searchResults.where((searchResult) {
      return searchResult.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () => {query = suggestion},
          );
        });
  }
}
