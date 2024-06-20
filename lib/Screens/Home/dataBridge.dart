import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goldenphoenix/Screens/Home/items.dart';
import 'package:goldenphoenix/data.dart';

class DataBridge with ChangeNotifier {
  final Map<Items, int> _itemQuantities = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void addItem(Items item) {
    if (_itemQuantities.containsKey(item)) {
      _itemQuantities[item] = (_itemQuantities[item] ?? 0) + 1;
    } else {
      _itemQuantities[item] = 1;
    }
    notifyListeners();
  }

  void removeItem(Items item) {
    _itemQuantities.remove(item);
    notifyListeners();
  }

  void increaseItemQuantity(Items item) {
    if (_itemQuantities.containsKey(item)) {
      _itemQuantities[item] = (_itemQuantities[item] ?? 0) + 1;
      notifyListeners();
    }
  }

  void decreaseItemQuantity(Items item) {
    if (_itemQuantities.containsKey(item)) {
      if (_itemQuantities[item]! > 1) {
        _itemQuantities[item] = _itemQuantities[item]! - 1;
      } else {
        _itemQuantities.remove(item);
      }
      notifyListeners();
    }
  }

  int itemQuantity(Items item) {
    return _itemQuantities[item] ?? 0;
  }

  List<Items> get basketItems {
    return _itemQuantities.keys.toList();
  }

  double get totalPrice {
    double total = 0.0;
    _itemQuantities.forEach((item, quantity) {
      total += item.price * quantity;
    });
    return total;
  }

  Future<void> saveBasketItemsToFirestore() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Map<String, dynamic> data = {
        'items': _itemQuantities
            .map((item, quantity) => MapEntry(item.id, quantity)),
      };
      await _firestore.collection('users').doc(user.uid)..set(data);
    }
  }

  Future<Map<Items, int>> loadBasketItemsFromFirestore() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        Map<String, int> items = Map<String, int>.from(data['items']);

        Map<Items, int> matchedItems = {};
        items.forEach((id, quantity) {
          Items? item = getItemById(id);
          if (item != null) {
            matchedItems[item] = quantity;
          }
        });

        return matchedItems;
      }
    }
    return {};
  }

  Items? getItemById(String id) {
    try {
      return allItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
