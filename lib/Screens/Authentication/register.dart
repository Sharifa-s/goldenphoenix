import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/button.dart';
import 'package:goldenphoenix/Design/colors.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> form = GlobalKey();
  bool obscureText = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 170,
              width: 420,
              decoration: const BoxDecoration(
                  color: Color(0xffcd8a8a),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50))),
              padding: const EdgeInsets.only(top: 80, left: 25),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'EagleLake',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 170),
              color: const Color(0xffcd8a8a),
              child: Container(
                height: 700,
                width: 410,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    )),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 30),
                    child: Form(
                      key: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome! Please fill the your details",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontFamily: 'EagleLake'),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.primaryColor),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: userName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "xxxx xxxx",
                              prefixIcon: Icon(
                                Icons.person,
                                color: MyColors.primaryColor,
                                size: 30,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Email address",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.primaryColor),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "xxx.xxx@gmail.com",
                              prefixIcon: Icon(
                                Icons.mail,
                                color: MyColors.primaryColor,
                                size: 30,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.primaryColor),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: password,
                            obscureText: obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Xxxx2455!99",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: MyColors.primaryColor,
                                size: 30,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                child: Icon(
                                  obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Phone Number",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.primaryColor),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: phoneNumber,
                            obscureText: obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "9866 6543",
                              prefixIcon: Icon(
                                Icons.phone,
                                color: MyColors.primaryColor,
                                size: 30,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Button(
                              title: 'Register',
                              onPressed: () async {
                                if (form.currentState!.validate()) {
                                  try {
                                    final credential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text,
                                    );

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(credential.user!.uid)
                                        .set({
                                      'id': credential.user!.uid,
                                      'name': userName.text,
                                      'email': email.text,
                                      'phoneNumber': phoneNumber.text,
                                    });
                                    Navigator.pushReplacementNamed(
                                        context, '/logIn');
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print(
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      print(
                                          'The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  print('Invalid Form');
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/logIn');
                              },
                              child: const Text(
                                "have an account",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'EagleLake',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
