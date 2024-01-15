
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_trip/screens/profilepage.dart';
import 'firebase_options.dart';
import 'screens/cartpage.dart';
import 'screens/homepage.dart';
import 'screens/login.dart';
import 'screens/signup.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
runApp(
    ChangeNotifierProvider(
      create: (context) => TripDataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

 // initail state (only used for stateful widgets) 
  @override
 void initState(){
  super.initState();

  // check authentication users if active or not using Auth.instance
  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('Please enter User and password to sign in');
    } else {
      print('User is signed in!');
    }
  });
  
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50],
          titleTextStyle: TextStyle(color: Colors.orange, fontSize: 17.0, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.orange)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? LoginScreen() : ProductDetailsWidget(),
      routes: {
        "Register": (context) => Register(),
        "login": (context)=> LoginScreen(),
        "homepage": (context)=> ProductDetailsWidget(),
        "profile":(context) => ProfilePage(),
        "cart":(context) => CartPage(),
       // "addCategory": (context)=> AddCategory(),
      },
    );
  }
}

class Auth {
  //create reference of  class FirebaseAuth(instance)
  final FirebaseAuth auth = FirebaseAuth.instance;

  //method returns currentUser states
  User? get currentUser => auth.currentUser;

  // gets state of the authentication in firebase
  Stream<User?> get authStateChanges => auth.authStateChanges();

  // SIGN IN 
  Future<void> signInWithEmailAndPassword(
    {
    required String email, 
    required String password
    }
  ) async {
    await auth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );
  }

  // SIGN UP
  Future<void> createUserWithEmailAndPassword(
      {
        required String email, 
        required String password
      }
  ) async {
    auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  // SIGN OUT
  Future<void> signOut() async {
    await auth.signOut();
  }
}

class TripDataProvider extends ChangeNotifier {
  // Your provider logic and variables go here

  // Example variable
  double _totalPurchasedItems = 0;
  int _totalItems = 0;
  List<double> cart = [];

  double get totalPurchasedItems => _totalPurchasedItems;
  int get totalItems => _totalItems; 
  List<double> get cartPrices => cart;

  void addToTotalPurchasedItems(double quantity) {
    _totalPurchasedItems += quantity;
    _totalItems++;
    notifyListeners(); // Notify listeners when the data changes
    print("${totalPurchasedItems}");
    print("${_totalItems}");
  }
  void addToCart(double price) {
    print('Adding to cart: $price');
    cart.add(price);
    notifyListeners(); // Notify listeners when the data changes
    
  }
  void removeFromCart(double price) {
    print('Removed from cart: $price');
    cart.remove(price);
    notifyListeners(); // Notify listeners when the data changes
  }

  void removeFromTotalPurchasedItems(double quantity) {
    _totalPurchasedItems -= quantity;
    --_totalItems;
    notifyListeners(); // Notify listeners when the data changes
    print("${totalPurchasedItems}");
    print("${_totalItems}");
  }

}