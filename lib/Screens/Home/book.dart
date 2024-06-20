import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/colors.dart';
import 'package:goldenphoenix/Screens/Home/dataBridge.dart';
import 'package:goldenphoenix/Screens/Home/items.dart';
import 'package:provider/provider.dart';

class ShowDetails extends StatefulWidget {
  final Items data;
  const ShowDetails({super.key, required this.data});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  int xx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<DataBridge>(builder: (context, myItems, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.asset(
              widget.data.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          "\$ ${widget.data.price}",
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "\$ ${widget.data.previousPrice}",
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.data.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  widget.data.description,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          
          Center(
            child: MaterialButton(
              elevation: 0.0,
              color: MyColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              onPressed: () {
                myItems.addItem(widget.data);
              },
              child: const Text(
                "ADD TO CART",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          )
        ],
      );
    }));
  }
}
