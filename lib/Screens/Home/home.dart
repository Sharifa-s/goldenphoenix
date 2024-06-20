import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:goldenphoenix/Design/colors.dart';
import 'package:goldenphoenix/Screens/Home/Mug.dart';
import 'package:goldenphoenix/Screens/Home/all.dart';
import 'package:goldenphoenix/Screens/Home/bowl.dart';
import 'package:goldenphoenix/Screens/Home/cups.dart';
import 'package:goldenphoenix/Screens/Home/glassware.dart';
import 'package:goldenphoenix/Screens/Home/myFavorite.dart';
import 'package:goldenphoenix/data.dart';
import 'package:goldenphoenix/menuofpages.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = -1;

  List<Widget> pageViews = [
    const All(),
    const Glassware(),
    const Mug(),
    const Cups(),
    const Bowls(),
  ];

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Inside your widget tree:
    Navigator(
      key: navigatorKey,
      // Other navigator configurations...
    );
    return Scaffold(
      backgroundColor: MyColors.background,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.asset("images/woman.png"),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning \u{1F44B}",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Jenny Wilson",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyFavorite()),
                          );

                         
                        },
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          size: 25,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none_outlined,
                            size: 25))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: -10,
                    blurRadius: 15,
                    offset: const Offset(8, 8),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "search",
                  hintStyle: const TextStyle(fontSize: 18),
                  suffixIcon: Icon(Icons.arrow_forward_ios,
                      color: MyColors.primaryColor),
                  prefixIcon: Icon(
                    Icons.search,
                    color: MyColors.primaryColor,
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: pageViews.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10, left: 5),
                      width: 120,
                      height: 40,
                      child: MaterialButton(
                        color: index == selectedIndex
                            ? MyColors.primaryColor
                            : MyColors.background,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: index != selectedIndex
                              ? BorderRadius.circular(0)
                              : BorderRadius.circular(25),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Text(
                          category[index],
                          style: TextStyle(
                              color: index == selectedIndex
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
                child: PageView.builder(
                    itemCount: pageViews.length,
                    onPageChanged: (value) {
                      setState(() {
                        selectedIndex = value;
                        print("==============$selectedIndex");
                      });
                    },
                    itemBuilder: (context, int index) {
                      return pageViews[index];
                    }))
          ],
        ),
      )),
    );
  }
}
