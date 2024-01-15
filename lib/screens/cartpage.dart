import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Basket"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Text(
              '''Items in Cart: ${Provider.of<TripDataProvider>(context).totalItems}
              Total: \$${Provider.of<TripDataProvider>(context).totalPurchasedItems}''',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
        )
      ),
    );
  }
}
