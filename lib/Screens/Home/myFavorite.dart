import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/colors.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({super.key});

  @override
  State<MyFavorite> createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  void getDataFromSubcollection() async {
    DocumentReference mainDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference subcollectionRef = mainDocRef.collection('myFavorites');
    QuerySnapshot subcollectionSnapshot = await subcollectionRef.get();
    subcollectionSnapshot.docs.forEach((doc) {
      print('Subcollection document ID: ${doc.id}');
      print('Subcollection document data: ${doc.data()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('myFavorites')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final List<DocumentSnapshot> myFavorites = snapshot.data!.docs;
      

            return ListView.builder(
                itemCount: myFavorites.length,
                itemBuilder: (context, index) {
                         final DocumentSnapshot favorite = myFavorites[index];
        final DocumentReference favoriteRef = favorite.reference;
                  return Card(
                    child: ListTile(
                      leading: ClipOval(
                          child: Image.asset(
                              "${myFavorites[index]["item image"]}")),
                      title: Text("${myFavorites[index]["item name"]}"),
                      subtitle: Text("${myFavorites[index]["item price"]}"),
                      trailing: InkWell(
                        onTap: ()async {
                            await _deleteFavorite(favoriteRef);

                        },
                        child: Icon(
                          Icons.favorite,
                          size: 25,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
  Future<void> _deleteFavorite(DocumentReference favoriteRef) async {
    try {
      await favoriteRef.delete();
      print('Favorite deleted successfully!');
    } catch (e) {
      print('Error deleting favorite: $e');
      // Handle error
    }
  }
}
