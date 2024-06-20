import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:goldenphoenix/Screens/Authentication/loginIn.dart';
import 'package:goldenphoenix/Screens/Authentication/register.dart';
import 'package:goldenphoenix/Screens/Home/myFavorite.dart';
import 'package:goldenphoenix/firebase_options.dart';
import 'package:goldenphoenix/menuofpages.dart';
import 'package:goldenphoenix/splash.dart';
import 'package:goldenphoenix/welcome.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey=dotenv.env["STRIPE_PUBLISH_KEY"]!;
  print(dotenv.env['STRIPE_SECRET_KEY']);
  print(dotenv.env['STRIPE_PUBLISH_KEY']);
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: FirebaseAuth.instance.currentUser != null
          ? const  PagesMenu()
          : const Splash(),
      //initialRoute: '/pagesMenu',
      routes: {
        '/splash': (context) => const Splash(),
        '/welcome': (context) => const Welcome(),
        '/logIn': (context) => LogIn(
              key: GlobalKey(),
            ),
        '/register': (context) => const Register(),
        '/pagesMenu': (context) => const PagesMenu(),
        '/myFav':(context) => const  MyFavorite()
      },
      onGenerateRoute: (settings) {
    if (settings.name == '/myFav') {
      // Return the route for '/myFav'
      return MaterialPageRoute(
        builder: (context) => const  MyFavorite(),
      );
    }
 
    return null; 
  },
    );
  }
}
