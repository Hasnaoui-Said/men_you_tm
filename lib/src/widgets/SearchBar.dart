import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search",
            style: TextStyle(color: Colors.black26, fontSize: 15)),
        shadowColor: Colors.white54,
        backgroundColor: Colors.white,
        elevation: 0.2,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black26,
            ),
            onPressed: () =>
                {showSearch(context: context, delegate: MySearchDelegate())},
          )
        ],
      ),
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
