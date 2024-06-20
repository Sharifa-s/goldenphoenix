import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/colors.dart';
import 'package:goldenphoenix/Screens/Home/dataBridge.dart';
import 'package:goldenphoenix/Screens/MyBag/payment.dart';
import 'package:provider/provider.dart';

class MyBag extends StatefulWidget {
  const MyBag({super.key});

  @override
  State<MyBag> createState() => _MyBagState();
}

class _MyBagState extends State<MyBag> {
  int count_ = 1;
  double totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    var cart_ = Provider.of<DataBridge>(context);
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        title: const Text("My Bag"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 650,
              width: double.infinity,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: cart_.basketItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              cart_.basketItems[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Text(
                                    cart_.basketItems[index].name,
                                    softWrap: true,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (cart_.itemQuantity(
                                            cart_.basketItems[index]) >
                                        1) {
                                      cart_.decreaseItemQuantity(
                                          cart_.basketItems[index]);
                                    } else {
                                      cart_
                                          .removeItem(cart_.basketItems[index]);
                                    }
                                  },
                                  icon: const Icon(Icons.remove)),
                              Text(
                                  "${cart_.itemQuantity(cart_.basketItems[index])}"),
                              IconButton(
                                  onPressed: () {
                                    cart_.increaseItemQuantity(
                                        cart_.basketItems[index]);
                                  },
                                  icon: const Icon(Icons.add))
                            ],
                          )
                        ],
                      ),
                    ));
                  }),
            ),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "OM ${cart_.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Payment(totalPrice: cart_.totalPrice,)));
                    },
                    color: MyColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: const Text(
                      "CHECKOUT",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
