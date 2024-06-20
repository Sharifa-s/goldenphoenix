
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import  'package:http/http.dart' as http;

Future createPaymentIntent({
  required String name,
  required String address,
  required String pin,
  required String city,
  required String state,
  required String country,
  required String currency,
  required String amount,
}) async {
  try {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final secretKey = dotenv.env['STRIPE_SECRET_KEY'];

    if (secretKey == null) {
      throw Exception('Stripe secret key not found in environment variables');
    }

    final body = {
      'amount': amount,
      'currency': currency.toLowerCase(),
      'automatic_payment_methods[enabled]': 'true',
      'description': 'Golden Phoenix',
      'shipping[name]': name,
      'shipping[address][line1]': address,
      'shipping[address][postal_code]': pin,
      'shipping[address][city]': city,
      'shipping[address][state]': state,
      'shipping[address][country]': country,
    };

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    print(body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
      return json;
    } else {
      print('Error in calling payment intent');
      throw Exception('Failed to create payment intent');
    }
  } catch (e) {
    print('Error creating payment intent: $e');
    throw e; 
  }
}
