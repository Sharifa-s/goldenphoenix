
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/button.dart';
import 'package:goldenphoenix/Design/colors.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> form = GlobalKey();
  bool obscureText = true;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 270,
              width: 420,
              decoration: const BoxDecoration(
                  color: Color(0xffcd8a8a),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50))),
              padding: const EdgeInsets.only(top: 175, left: 25),
              child: const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'EagleLake',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 270),
              color: const Color(0xffcd8a8a),
              child: Container(
                height: 600,
                width: 410,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Form(
                    key: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome! Please log in using your credentials.",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontFamily: 'EagleLake'),
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
                          controller: _email,
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
                          controller: _password,
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
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Forgot your password?",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Button(
                            title: 'Sign In',
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text);
                                Navigator.popAndPushNamed(
                                    context, '/pagesMenu');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/register');
                            },
                            child: const Text(
                              "Don't have an account",
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
            )
          ],
        ),
      ),
    );
  }
}
