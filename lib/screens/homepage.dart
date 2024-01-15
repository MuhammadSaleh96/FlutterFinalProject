import 'package:flutter/material.dart';
import 'package:tap_and_trip/class%20models/country_info.dart';
import 'package:tap_and_trip/main.dart';
import 'package:tap_and_trip/screens/cartpage.dart';
import 'package:tap_and_trip/screens/profilepage.dart';



import '../class models/user_info.dart';
import 'login.dart';
import 'productpage.dart';

class LeftDrawerWidget extends StatefulWidget {
  const LeftDrawerWidget({super.key});

  @override
  State<LeftDrawerWidget> createState() => _LeftDrawerWidgetState();
}
class _LeftDrawerWidgetState extends State<LeftDrawerWidget> {
  // Create an instance of the FirebaseService class
  final FirebaseService fbs = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          UserAccountsDrawerHeader(
            accountName: Text("",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                  )
                ), 
            accountEmail: Text("${Auth().auth.currentUser!.email}"),
            otherAccountsPictures: [
              Icon(
                Icons.bookmark_border,
                color: Colors.white,
              )
            ],
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4rq4-1Oi3Lc6ItGLuyenbt5Da9dDkHVAbHg&usqp=CAU"),
                fit: BoxFit.cover
                )              
             ),            
           ),
          NavigationBar(),   
        ],
      ),
    );  
  }
}
class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});
  @override
  State<NavigationBar> createState() => _NavigationBarState();
}
class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- Home Tile ---
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: 
            (_){
              // add home page here 
              return  ProductDetailsWidget();
            })
            );
          },
        ),
        // --- My Profile Tile ---
        ListTile(
          leading: const Icon(Icons.account_circle_rounded),
          title: const Text("My Profile"),
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: 
            (_){
              return ProfilePage();
            })
            );
          },
        ),
        // --- My Trips Tile ---
        ListTile(
          leading: const Icon(Icons.airplanemode_active_sharp),
          title: const Text("My Trips"),
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: 
            (_){
              return CartPage();
            })
            );
          },
        ),
        const Divider(
          color: Colors.grey,
          
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Log out"),
          onTap: () {
            Auth().auth.signOut();
             Navigator.push(context, 
            MaterialPageRoute(builder: 
            (_){
              return LoginScreen();
            })
            );
          },
        ),
      ],
    );  
  }
}

class ProductDetailsWidget extends StatefulWidget {
  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  // Sample product data
  List<CountryModel>? countries;
  @override
  initState() {
    super.initState();
    fatchProductDetails();
  }

  Future<void> fatchProductDetails() async {
    try {
      List<CountryModel>? ps = await FirebaseService().getCountryDetails();
      if (ps != null) {
        setState(() {
          countries = ps;
        });
      } else {
        print("Product Data not Found not found");
      }
    } catch (e) {
      print("hello ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      drawer: LeftDrawerWidget(),
      body: countries == null
          ? Center(
              child: Column(
              children: [
                Text("Still loading the product details"),
                CircularProgressIndicator()
              ],
            ))
          : ListView.builder(
              itemCount: countries!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Card(
                    elevation: 5, // Add elevation for a shadow effect
                    margin: EdgeInsets.all(
                        8), // Add margin for spacing between cards
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            "${countries![index].imageUrl}",
                            height: 150, // Set the desired height for the image
                            width: 100, // Set the image width to match the card
                            fit: BoxFit
                                .cover, // Ensure the image covers the entire space
                          ),
                          SizedBox(
                              width:
                                  8), // Add spacing between the image and text
                          Column(
                            children: [
                              Text(
                                "${countries![index].countryName}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width:
                                      8), // Add spacing between the name and price
                              Text(
                                'Tours: ${countries![index].numOfTours}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                  width:
                                      8), // Add spacing between the name and price
                              Text(
                                'Rating: ${countries![index].rating}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                  width:
                                      8), // Add spacing between the name and price
                              Text(
                                'Price: ${countries![index].price}',
                                style: TextStyle(fontSize: 16),
                              ),  
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    print("Clicked on Product ${countries![index].countryName}");
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return TripDetailPage(
                          tripImageUrl: "${countries![index].imageUrl}",
                          tripDescription: "${countries![index].countryDesc}",
                          tripPrice: "${countries![index].price}",);
                    }));
                  },
                );
              },
            ),
    );
  }
}


