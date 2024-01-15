import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tap_and_trip/main.dart';

import 'country_info.dart';

class UserInfo {
  String fullName;
  String email;
  String dateOfBirth;
  String country;
  String profilePic;

  UserInfo({
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.country,
    required this.profilePic,
  });

//takes object value and return map
  Map<dynamic, dynamic> toMap(){
    return {
      'fullName': fullName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'country': country,
      'profilePic': profilePic
    };
  }

// create a UserDetails object from a map
  factory UserInfo.fromMap(Map<dynamic, dynamic> map){
    return UserInfo(
      fullName: map['fullName'],
      email: map['email'],
      dateOfBirth: map['dateOfBirth'],
      country: map['country'],
      profilePic: map['profilePic'],
    );
  }
}

class FirebaseService{
  //check states of User authenticatation if returned null (not authenticated) else (authenticated)
  User? user = Auth().auth.currentUser;
  //create refrence with root name (Users) in real time database
  DatabaseReference userref = FirebaseDatabase.instance.ref()
  .child("Users");

  //test case (Database event)
/* DatabaseReference reference = FirebaseDatabase.instance.reference().child('example');

  reference.onValue.listen((event) {
    // Handle the database event
    print('Data changed: ${event.snapshot.value}');
  });
*/

  Future<UserInfo?> getUserFromDatabase() async{
    try {
      if(user!= null){
      DatabaseEvent event = await userref.child(user!.uid).once();
        if(event.snapshot.value != null){
          Map<dynamic, dynamic> snapMap = event.snapshot.value as dynamic;
            return UserInfo.fromMap(snapMap);
        } else {
          print("User detials null");
          return null;
        }
      } else {
        print("the current user is null");
        return null;
      }
    } catch (e){
      print(e.toString());
      return null;
    }
  }

  Future<List<CountryModel>> getCountryDetails() async {
    DatabaseReference productsRef =
        FirebaseDatabase.instance.ref().child("Countries");

    try {
      DatabaseEvent event = await productsRef.once();

      if (event.snapshot.value != null) {
        print(event.snapshot.value.toString());

        List<CountryModel> countryList = [];
        Map<dynamic, dynamic> snapshotData = event.snapshot.value as dynamic;

        snapshotData.forEach((key, value) {
          countryList.add(CountryModel.fromMap(value as Map<dynamic, dynamic>));
        });

        print("Countries List: $countryList");
        return countryList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting product details: $e');
      return [];
    }
  }
}
