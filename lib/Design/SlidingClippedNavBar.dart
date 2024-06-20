import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goldenphoenix/Design/colors.dart';
import 'package:goldenphoenix/Screens/Authentication/myProfile.dart';
import 'package:goldenphoenix/Screens/Home/home.dart';
import 'package:goldenphoenix/Screens/MyBag/mybag.dart';
import 'package:goldenphoenix/Screens/MyOrders/myorders.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';


class SlidingClippedNavigationBar extends StatefulWidget {
  const SlidingClippedNavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<SlidingClippedNavigationBar> createState() => _SlidingClippedNavigationBarState();
}

class _SlidingClippedNavigationBarState extends State<SlidingClippedNavigationBar> {
  int selectedIndex = 0;


  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          onButtonPressed(index);
          _goBranch(selectedIndex);
        },
        iconSize: 30,
        activeColor: MyColors.primaryColor,
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
           BarItem(
            icon: Icons.home,
            title: 'Home',
            
          ),
          BarItem(
            icon: Icons.shopping_bag,
            title: 'My Bag',
            
          ),
          BarItem(
            icon: Icons.shopping_cart_checkout_sharp,
            title: 'My Order',
          ),
          BarItem(
            icon: Icons.person,
            title: 'My Profile',
          ),
        
        ],
      ),
    );
  }
}

List<Widget> listOfWidget = <Widget>[
  const Home(),
  const MyBag(),
  const MyOrders(),
  const MyProfile()
];
