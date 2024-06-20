import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:goldenphoenix/Design/colors.dart';
import 'package:goldenphoenix/Screens/Home/dataBridge.dart';
import 'package:goldenphoenix/Screens/Home/items.dart';
import 'package:goldenphoenix/Screens/MyBag/ReusableText.dart';
import 'package:goldenphoenix/Screens/MyBag/createPayment.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  Payment({super.key, required this.totalPrice});
  final double totalPrice;
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  DataBridge dataBridge = DataBridge();
//   void saveBasketItemsToFirestore(List<Items> basketItems) {
//   final CollectionReference itemsCollection =FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection('basketItems');

//   basketItems.forEach((item) {
//     itemsCollection
//         .doc(item.id)
//         .set({
//       'id': item.id,
//       'name': item.name,
//       'description': item.description,
//       'price': item.price,
//       'image': item.image,
//       //'quantity': item.quantity,
//     })
//         .then((value) => print('==================================Item ${item.id} added to Firestore'))
//         .catchError((error) => print('=====================================Failed to add item ${item.id}: $error'));
//   });
// }

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  @override
  void initState() {
    amountController.text = widget.totalPrice.toStringAsFixed(2);
    super.initState();
  }

  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final formkey4 = GlobalKey<FormState>();
  final formkey5 = GlobalKey<FormState>();
  final formkey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>[
    'USD',
    // 'INR',
    // 'EUR',
    // 'JPY',
    // 'GBP',
    // 'AED'
  ];
  String selectedCurrency = 'USD';

  bool hasDonated = false;

  Future<void> initPaymentSheet() async {
    try {
      int amountInCents = (widget.totalPrice * 100).toInt();
      final data = await createPaymentIntent(
          amount: amountInCents.toString(),
          currency: selectedCurrency,
          name: nameController.text,
          address: addressController.text,
          pin: pincodeController.text,
          city: cityController.text,
          state: stateController.text,
          country: countryController.text);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print(e);
      //throw ();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage("images/hero-1.jpg"),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            hasDonated
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Thanks for your shopping",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          "We appreciate your support",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade400),
                            child: const Text(
                              "Shopping again",
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              setState(() {
                                hasDonated = false;
                                amountController.clear();
                              });
                            },
                          ),
                        ),
                       const SizedBox(height: 10,),
                        Center(
                          child: RatingBar.builder(
                   
                            minRating: 1,
                            direction: Axis.horizontal,
                          updateOnDrag: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your comfort is our priority",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: ReusableTextField(
                                    enabled: false,
                                    formkey: formkey,
                                    controller: amountController,
                                    isNumber: true,
                                    title: "Total Price",
                                    hint: "${widget.totalPrice}"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              DropdownMenu<String>(
                                inputDecorationTheme: InputDecorationTheme(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                initialSelection: currencyList.first,
                                onSelected: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    selectedCurrency = value!;
                                  });
                                },
                                dropdownMenuEntries: currencyList
                                    .map<DropdownMenuEntry<String>>(
                                        (String value) {
                                  return DropdownMenuEntry<String>(
                                      value: value, label: value);
                                }).toList(),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ReusableTextField(
                            enabled: true,
                            formkey: formkey1,
                            title: "Name",
                            hint: "Ex. abdallah",
                            controller: nameController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ReusableTextField(
                            enabled: true,
                            formkey: formkey2,
                            title: "Address Line",
                            hint: "Ex. 123 Main St",
                            controller: addressController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: ReusableTextField(
                                    enabled: true,
                                    formkey: formkey3,
                                    title: "City",
                                    hint: "Ex. Muscat",
                                    controller: cityController,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 5,
                                  child: ReusableTextField(
                                    enabled: true,
                                    formkey: formkey4,
                                    title: "State (Short code)",
                                    hint: "Ex. Mu for Muscat",
                                    controller: stateController,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: ReusableTextField(
                                    enabled: true,
                                    formkey: formkey5,
                                    title: "Country (Short Code)",
                                    hint: "Ex. OM for Oman",
                                    controller: countryController,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 5,
                                  child: ReusableTextField(
                                    enabled: true,
                                    formkey: formkey6,
                                    title: "Pincode",
                                    hint: "Ex. 123456",
                                    controller: pincodeController,
                                    isNumber: true,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.primaryColor),
                              child: const Text(
                                "Proceed to Pay",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () async {
                                if (formkey.currentState!.validate() &&
                                    formkey1.currentState!.validate() &&
                                    formkey2.currentState!.validate() &&
                                    formkey3.currentState!.validate() &&
                                    formkey4.currentState!.validate() &&
                                    formkey5.currentState!.validate() &&
                                    formkey6.currentState!.validate()) {
                                  await initPaymentSheet();

                                  try {
                                    await Stripe.instance.presentPaymentSheet();

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        "Payment Done",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.green,
                                    ));

                                    setState(() {
                                      hasDonated = true;
                                    });
                                    nameController.clear();
                                    addressController.clear();
                                    cityController.clear();
                                    stateController.clear();
                                    countryController.clear();
                                    pincodeController.clear();

                                    final dataBridge = Provider.of<DataBridge>(
                                        context,
                                        listen: false);
                                    await dataBridge
                                        .saveBasketItemsToFirestore();

                                    // Optionally show success message or navigate to the next screen
                                  } catch (e) {
                                    print(
                                        "Payment sheet failed or saving to Firestore failed: $e");
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        "Payment Failed",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ));
                                  }
                                }
                              },
                            ),
                          )
                        ])),
          ],
        ),
      ),
    );
  }
}
