import 'package:flutter/material.dart';
import 'package:men_you_tm/src/models/MenuItem.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/services/MenuItemService.dart';
import 'package:men_you_tm/src/services/converter/MenuItemConverter.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';
import 'package:men_you_tm/src/widgets/peckUp.page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> menuItemsCart = [];

  List<MenuItem> menuItems = [];

  late double _amount = 0;

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
    _calculTotal();
  }
  Widget _emptyListFavorite(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No items added to favorites',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart page'),
      ),
      body: menuItems.isNotEmpty ?
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(35),
                child: const Text("Checkout Order"),
              ),
              Container(
                padding: const EdgeInsets.all(35),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        //     backgroundColor:
                        //         MaterialStatePropertyAll(Colors.transparent),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.orange,
                          width: 1.5,
                        )),
                      ),
                      onPressed: null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Amount"),
                            const SizedBox(height: 8.0),
                            Text(
                              "\$ ${_amount.toStringAsFixed(2)}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 35, right: 35),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      //     backgroundColor:
                      //         MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Colors.orange,
                        width: 1.5,
                      )),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Would you like to get order ? ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      child: const Text('Peck Up',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) => PeckUpPage(amount: _amount.toString(), typeOrder: "Peck Up",)
                                            )
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      child: const Text('Delivery',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) => PeckUpPage(amount: _amount.toString(), typeOrder: "Delivery",)
                                            )
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Check Out",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      title: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
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
                                          height: 90.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(height: 4.0),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  menuItems[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
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
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Any Special Demand?",
                                            style:
                                                TextStyle(color: Colors.green)),
                                        Container(
                                          padding: const EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            color: Colors.orange[50],
                                            borderRadius:
                                                BorderRadius.circular(200),
                                          ),
                                          child: Row(
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
                                                        menuItems[index].id,
                                                        -1);
                                                  }
                                                },
                                              ),
                                              Text(
                                                "${menuItems[index].count}",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.add_circle,
                                                    color: Colors.orange,
                                                    weight: 2),
                                                onPressed: () {
                                                  _incOrDecItemMenu(
                                                      menuItems[index].id, 1);
                                                },
                                              )
                                            ],
                                          ),
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
      ) 
      : _emptyListFavorite(context),
    );
  }

  void _addOrRemoveItemToCart(String id) {
    for (MenuItem item in menuItems) {
      if (item.id == id) {
        LocalStorage.setMenuTest(id);
        setState(() {
          menuItems.remove(item);
        });
        _calculTotal();
        return;
      }
    }
    _calculTotal();
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
    _calculTotal();
  }

  void _calculTotal() {
    _amount = 0;
    setState(() {
      for (var item in menuItems) {
        _amount += (item.price * item.count);
      }
    });
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
