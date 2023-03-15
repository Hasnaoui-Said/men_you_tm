import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:men_you_tm/src/models/Order.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/services/OrderService.dart';
import 'package:men_you_tm/src/services/converter/OrderConverter.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late String email = "";
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: (email.isNotEmpty && orders.isNotEmpty)
          ? Column(
              children: [
                _dataTable(context),
              ],
            )
          : _emptyListFavorite(context),
    );
  }

  Future<void> _fetchOrder() async {
    String e = await LocalStorage.getEmail();
    setState(() {
      email = e;
    });
    if (e.isNotEmpty) {
      OrderService service = OrderService();
      ResponseBody? response = await service.getOrderByCostumerId(e);
      if (response != null) {
        OrderConverter converter = OrderConverter();
        List<Order> ordersList = converter.toBeans(response.data);
        setState(() {
          orders = ordersList;
        });
      }
    }
  }

  Widget _dataTable(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(
              width: 20,
            ),
            Text(
              'List of Orders : ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              'email : $email',
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text(
                    'Order ID',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                  DataColumn(
                      label: Text(
                    'Items',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                  DataColumn(
                      label: Text(
                    'total (\$)',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                  DataColumn(
                      label: Text(
                    'Status',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ],
                rows: orders
                    .map((order) => DataRow(cells: [
                          DataCell(TextButton(
                              onPressed: () {
                                print("print more for this order ${order.id}");
                              },
                              child: Text(
                                "${order.id.substring(0, 10)}...",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    textBaseline: TextBaseline.alphabetic,
                                    decoration: TextDecoration.underline),
                              ))),
                          DataCell(Text("${order.menuItemsDetail.length}")),
                          DataCell(Text("${order.totalPay}")),
                          DataCell(order.status
                              ? const Icon(Icons.check, color: Colors.green)
                              : GestureDetector(
                                  onTap: () {
                                    _validateCommand(context, order.id);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.close,
                                        color: Colors.red),
                                  ))),
                        ]))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptyListFavorite(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No Order saved at !',
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

  void _validateCommand(BuildContext context, String id) {
    OrderService service = OrderService();
    service.validateOrder(id);
  }
}
