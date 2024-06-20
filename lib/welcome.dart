import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/colors.dart';



class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              children: [
                SizedBox(
                  height: 550,
                  width: 500,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Image.asset(
                        'images/hero-1.jpg',
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "\t\t\t\t\tWelcome To \nGolden Phoenix\u{1F44B}",
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, height: 1.4),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  child: Center(
                    child: Text(
                      "Golden Phoenix offers glassware, tableware and all what you need for retail and Horeca.",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/logIn', (route) => false);
                    },
                    color: MyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 0.0,
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text(
                            'Let\'s Get Started',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
