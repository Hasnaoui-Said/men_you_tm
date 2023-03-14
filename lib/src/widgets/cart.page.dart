import 'package:flutter/material.dart';
import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/services/MenuItemService.dart';
import 'package:men_you_tm/src/services/converter/MenuItemConverter.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> menuItemsCart = [];

  List<MenuItem> menuItems = [];

  @override
  void initState() {
    super.initState();
    _getMenuCart();
  }

  Future<void> _getMenuCart() async {
    List<Map<String, dynamic>> menus = await LocalStorage.getMenusTest();

    setState(() {
      menuItemsCart = menus;
    });
    if (menuItemsCart.isNotEmpty) {
      MenuItemService service = MenuItemService();

      for (Map<String, dynamic> elm in menuItemsCart) {
        String id = elm['id'];
        int count = elm['count'];
        ResponseBody? item = await service.getMenuItemById(id);
        if (item != null) {
          if (item.data == null) {
            LocalStorage.removeMenuTest(id);
            break;
          }
          MenuItemConverter converter = MenuItemConverter();
          MenuItem menu = await converter.toBean(item.data);
          setState(() {
            menuItems.add(menu);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart page'),
      ),
      body: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(35),
                child: Column(
                  children: [
                    const Text("Order"),
                    Text("${menuItems.length} items"),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(35),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: const BorderSide(color: Colors.orange, width: 2),
                      ),
                      onPressed: null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Amount",),
                          Text("\$ 456"),
                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      title: Row(
                        children: [
                          Expanded(
                              child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Image.network(
                                          menuItems[index].imageStore,
                                          height: 70.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(height: 4.0),
                                              Text(
                                                menuItems[index].name,
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(height: 4.0),
                                              Text(
                                                "\$ ${menuItems[index].price}",
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                              Text(
                                                "X ${menuItems[index].count}",
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Any Special Demand?",
                                            style:
                                                TextStyle(color: Colors.green)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove_circle,
                                                  color: (menuItems[index]
                                                              .count) !=
                                                          1
                                                      ? Colors.orange
                                                      : Colors.grey,
                                                  weight: 2),
                                              onPressed: () {
                                                if (menuItems[index].count !=
                                                    1) {
                                                  _incOrDecItemMenu(
                                                      menuItems[index].id, -1);
                                                }
                                              },
                                            ),
                                            Text("${menuItems[index].count}"),
                                            IconButton(
                                              icon: const Icon(Icons.add_circle,
                                                  color: Colors.orange,
                                                  weight: 2),
                                              onPressed: () {
                                                _incOrDecItemMenu(
                                                    menuItems[index].id, 1);
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 1,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.orange, weight: 4),
                                      onPressed: () {
                                        _addOrRemoveItemToCart(
                                            menuItems[index].id);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  },
                  // separatorBuilder: (context, index) => const Divider(height: 10,),
                  itemCount: menuItems.length))
        ],
      ),
    );
  }

  void _addOrRemoveItemToCart(String id) {
    for (MenuItem item in menuItems) {
      if (item.id == id) {
        LocalStorage.setMenuTest(id);
        setState(() {
          item.isAddToCart = !item.isAddToCart;
        });
        return;
      }
    }
  }

  void _incOrDecItemMenu(String id, int i) {
    List<MenuItem> menuItemsList = menuItems.map((item) {
      if (item.id != id || (item.count == 1 && i < 0)) {
        return item;
      } else {
        LocalStorage.incOrDecItemMenu(id, i);
        item.count += i;
      }
      return item;
    }).toList();

    setState(() {
      menuItems = menuItemsList;
    });
  }

  bool _getCount(int count) {
    return count == 1;
  }
}
