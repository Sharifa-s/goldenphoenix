import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/colors.dart';
import 'package:goldenphoenix/data.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  List myFavorites = [];
  bool isFavorite = false;
  int indexFavorite = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Combo Deals",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.black),
                ),
                Text(
                  "See All",
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 320,
              width: 500,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: comboDeals.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(clipBehavior: Clip.none, children: [
                            Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    comboDeals[index]["image"],
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  isFavorite = true;
                                  indexFavorite = index;
                                  myFavorites.add(index);
                                });

                                print(myFavorites);
                                await FirebaseFirestore.instance
                                    .collection('myFavorites')
                                    .doc()
                                    .set({
                                  'id': FirebaseAuth.instance.currentUser!.uid,
                                  'ItemImage': comboDeals[index]["image"],
                                  'itemName': comboDeals[index]["description"],
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.only(top: 15, left: 200),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: myFavorites.contains(index)
                                    ? Icon(
                                        Icons.favorite,
                                        color: MyColors.primaryColor,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_outlined,
                                      ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 13,
                          ),
                          Text(
                            comboDeals[index]["description"],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "\$ ${comboDeals[index]["price"]}",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "\$ ${comboDeals[index]["previousPrice"]}",
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Products",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.black),
                ),
                Text(
                  "See All",
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 500,
              height: 320,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      color: const Color(0xfffef1f1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset("images/img24514.jpg",
                                      fit: BoxFit.cover))),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Round Crystal Design Plate",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    "4.9(76Review)",
                                    style: TextStyle(color: Colors.grey[700]),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$ 49.6",
                                    style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "\$ 66.0}",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  const SizedBox(
                                    width: 150,
                                  ),
                                  const Icon(
                                    Icons.favorite_border_outlined,
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
