import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_trip/main.dart';

class TripDetailPage extends StatelessWidget {
  final String tripImageUrl;
  final String tripDescription;
  final String tripPrice;

  TripDetailPage(
      {required this.tripImageUrl, required this.tripDescription, required this.tripPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              tripImageUrl,
              height: 400, // Set the desired height for the image
              width: double
                  .infinity, // Set the image width to match the screen width
              fit: BoxFit.cover, // Ensure the image covers the entire space
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                tripDescription,
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, "cart");
    String cleanedPrice = tripPrice.replaceAll(RegExp('[^0-9.]'), '');
    double price = double.parse(cleanedPrice);
    Provider.of<TripDataProvider>(context, listen: false).addToCart(price);
    Provider.of<TripDataProvider>(context, listen: false).addToTotalPurchasedItems(price);
    
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("${tripPrice} purchase"),
      Icon(Icons.arrow_right),
    ],
  ),
),
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, "cart");
    String cleanedPrice = tripPrice.replaceAll(RegExp('[^0-9.]'), '');
    double price = double.parse(cleanedPrice);
    double cartAmount = Provider.of<TripDataProvider>(context, listen: false).totalPurchasedItems;
    List cartList = Provider.of<TripDataProvider>(context, listen: false).cartPrices;

    if(price <= cartAmount){
      if(cartList.contains(price)){
        Provider.of<TripDataProvider>(context, listen: false).removeFromCart(price);
        Provider.of<TripDataProvider>(context, listen: false).removeFromTotalPurchasedItems(price);
        ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Item has been removed from Basket'),
              ),
            );
        print(cartList);
      }
       ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('The item is not in basket list'),
              ),
            );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('The item is not in basket'),
              ),
            );
    }
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Remove from basket"),
      Icon(Icons.arrow_right),
    ],
  ),
)
          ],
        ),
      ),
    );
  }
}
