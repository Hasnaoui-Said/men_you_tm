import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:men_you_tm/src/models/domains/ResponseBody.dart';
import 'package:men_you_tm/src/services/OrderService.dart';
import 'package:men_you_tm/src/utils/local_storage.dart';

class PeckUpPage extends StatefulWidget {
  final String amount;

  final String typeOrder;

  const PeckUpPage({Key? key, required this.amount, required this.typeOrder})
      : super(key: key);

  @override
  State<PeckUpPage> createState() =>
      _PeckUpPageState(amount: this.amount, typeOrder: this.typeOrder);
}

class _PeckUpPageState extends State<PeckUpPage> {
  final String amount;

  final String typeOrder;

  late bool statusOrder = false;

  TextEditingController emailAddress = TextEditingController();
  TextEditingController deliveryAddress = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _errorSaveOrder;

  _PeckUpPageState({required this.amount, required this.typeOrder});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            foregroundColor: Colors.black,
            flexibleSpace: Image.network(
              "https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg",
              fit: BoxFit.cover,
              height: 250,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: !statusOrder,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(typeOrder == 'Delivery' ? '$typeOrder address' : 'Peck Up',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(35),
                            child: Column(
                              children: const [
                                Text("Order"),
                              ],
                            ),
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
                                          "\$ $amount",
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
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text('Email'),
                                    hintText: 'Enter email address',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter an email address';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                Visibility(
                                  visible: typeOrder == 'Delivery',
                                  child: TextFormField(
                                    controller: deliveryAddress,
                                    decoration: const InputDecoration(
                                      label: Text('Address'),
                                      hintText: 'Enter delivery address',
                                      border: OutlineInputBorder(),
                                    ),
                                    maxLines: 3,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter an address';
                                      }
                                      return _errorSaveOrder;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      child: const Text('Pick Up'),
                                      onPressed: () {
                                        print(_formKey.currentState.toString());
                                        if (_formKey.currentState?.validate() ==
                                            true) {
                                          _formKey.currentState?.save();
                                          save(emailAddress.text,
                                              deliveryAddress.text);
                                        } else {
                                          print("_formKey not valid");
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: statusOrder,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: const Center(child: Text("Order saved")),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> save(String email, String address) async {
    String type = typeOrder == 'Delivery' ? address : 'Peck Up';
    address = typeOrder == 'Delivery' ? address : 'Peck Up';
    OrderService service = OrderService();
    ResponseBody? response = await service.save(email, address, type);
    print("response");
    print(response);
    if (response != null) {
      print(response);
      if (response.success) {
        LocalStorage.saveEmail(email);
        LocalStorage.removeAllMenusTest();
        setState(() {
          statusOrder = true;
        });
      } else {
        print(response.message);
      }
    }
  }
}
