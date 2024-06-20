import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/colors.dart';
import 'package:goldenphoenix/Screens/Home/book.dart';
import 'package:goldenphoenix/data.dart';

class Mug extends StatefulWidget {
  const Mug({super.key});

  @override
  State<Mug> createState() => _MugState();
}

class _MugState extends State<Mug> {
  CollectionReference myFavorite = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('myFavorites');

  // Future<void> addRequest() {
  //   return myFavorite.add({
  //     'id': FirebaseAuth.instance.currentUser!.uid,
  //     "item image": wasteType_.text,
  //     "item name": itemType_.text,
  //     "item price": dateTime,
  //   }).then((value) {
  //     print("item Added to myFavorite list");
  //   }).catchError((error) {
  //     setState(() {});
  //     print("Failed to add item Added to myFavorite list: $error");
  //     error();
  //   });
  // }
  List myFavorites = [];
  bool isFavorite = false;
  int indexFavorite = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 15,
                mainAxisExtent: 300,
                mainAxisSpacing: 5),
            itemCount: mugs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShowDetails(
                            data: mugs[index],
                          )));
                },
                child: Container(
                  color: MyColors.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(clipBehavior: Clip.none, children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                mugs[index].image,
                                fit: BoxFit.cover,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isFavorite = true;
                              indexFavorite = index;
                              myFavorites.add(index);
                              myFavorite.add({
                                'id': FirebaseAuth.instance.currentUser!.uid,
                                "item image":  mugs[index].image,
                                "item name": mugs[index].name,
                                "item price": mugs[index].price,
                              }).then((value) {
                                print("item Added to myFavorite list");
                              }).catchError((error) {
                                setState(() {});
                                print(
                                    "Failed to add item Added to myFavorite list: $error");
                                error();
                              });
                            });

                            print(myFavorites);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(top: 15, left: 130),
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
                        mugs[index].name,
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
                            "\$ ${mugs[index].price}",
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "\$ ${mugs[index].previousPrice}",
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
