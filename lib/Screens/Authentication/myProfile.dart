import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goldenphoenix/Screens/Authentication/loginIn.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
                    children: [
           
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    "images/profile2.jpg",
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
                child: Text(
              "Hajer Abdallah",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            )),
            const SizedBox(
              height: 15,
            ),
            Card(
              child: ListTile(
               leading: Icon(Icons.person , color: Colors.grey[500],),
                title: const Text("Edit Profile" , style: TextStyle(fontWeight: FontWeight.bold , ),),
                trailing: Icon(Icons.arrow_forward_ios , color: Colors.grey[500],),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Card(
              child: ListTile(
               leading: Icon(Icons.location_on_sharp, color: Colors.grey[500],),
                title: const Text("Shopping Address" , style: TextStyle(fontWeight: FontWeight.bold , ),),
                trailing: Icon(Icons.arrow_forward_ios , color: Colors.grey[500],),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Card(
              child: ListTile(
               leading: Icon(Icons.favorite, color: Colors.grey[500],),
                title: const Text("Wishlist" , style: TextStyle(fontWeight: FontWeight.bold , ),),
                trailing: Icon(Icons.arrow_forward_ios , color: Colors.grey[500],),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Card(
              child: ListTile(
               leading: Icon(Icons.file_copy, color: Colors.grey[500],),
                title: const Text("Order History" , style: TextStyle(fontWeight: FontWeight.bold , ),),
                trailing: Icon(Icons.arrow_forward_ios , color: Colors.grey[500],),
              ),
            ),
             const SizedBox(
              height: 3,
            ),
            Card(
              child: ListTile(
               leading: Icon(Icons.notifications, color: Colors.grey[500],),
                title: const Text("Notification" , style: TextStyle(fontWeight: FontWeight.bold , ),),
                trailing: Icon(Icons.arrow_forward_ios , color: Colors.grey[500],),
              ),
            ),
             const SizedBox(
              height: 3,
            ),
            Card(
              child: ListTile(
               leading: Icon(Icons.credit_card, color: Colors.grey[500],),
                title: const Text("Cards" , style: TextStyle(fontWeight: FontWeight.bold , ),),
                trailing: Icon(Icons.arrow_forward_ios , color: Colors.grey[500],),
              ),
            ),
            InkWell(
              onTap: ()async {
                   await FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LogIn()));
              },
              child: Card(
                child: ListTile(
                 leading: Icon(Icons.exit_to_app_rounded, color: Colors.grey[500],),
                  title: const Text("Sign Out" , style: TextStyle(fontWeight: FontWeight.bold , ),),
                  trailing: Icon(Icons.arrow_forward_ios , color: Colors.grey[500],),
                ),
              ),
            )
                    ],
                  ),
          )),
    );
  }
}
