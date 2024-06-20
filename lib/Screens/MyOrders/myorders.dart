import 'package:flutter/material.dart';
import 'package:goldenphoenix/Screens/Home/dataBridge.dart';
import 'package:goldenphoenix/Screens/Home/items.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
   final dataBridge = Provider.of<DataBridge>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Basket Items'),
      ),
     body: FutureBuilder<Map<Items, int>>(
        future: Provider.of<DataBridge>(context, listen: false).loadBasketItemsFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items in basket.'));
          } else {
            Map<Items, int> basketItems = snapshot.data!;
            return ListView.builder(
              itemCount: basketItems.length,
              itemBuilder: (context, index) {
                Items item = basketItems.keys.elementAt(index);
                int quantity = basketItems[item]!;

                return ListTile(
                  leading: Image.asset(item.image),
                  title: Text(item.name),
                  subtitle: Text('Quantity: $quantity\nPrice: \$${item.price}'),
                  trailing: Text('Total: \$${item.price * quantity}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}