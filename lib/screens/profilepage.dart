import 'package:flutter/material.dart';
import 'package:tap_and_trip/class%20models/country_info.dart';

import '../class models/user_info.dart';
import '../main.dart';
import 'homepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseService fbs = FirebaseService();
  UserInfo? usr;
  bool isEditing = false;
  late String selectedCountry;
  late String imgurl;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  List <String> countries = ["Jordan", "Saudi Arabia", "Emirates", "Oman", "Syria","United States","Canada"];

  @override
  void initState(){
    super.initState();
    if(Auth().auth.currentUser != null){
      fatchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (usr != null){
      return Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
        ),
        drawer: LeftDrawerWidget(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [SizedBox(
                width: 150, height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  
                  child: Image.network(usr!.profilePic,fit: BoxFit.cover,)),
              ),
              const SizedBox(height: 20.0),
              // fullname textForm
              isEditing
                  ? TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(labelText: "Full Name"),
                  )
                  : Text(
                      "Full Name: ${usr!.fullName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  const SizedBox(height: 30.0),
                  // email textForm
                  isEditing
                    ? TextFormField(
                      controller: emailAddressController,
                      decoration: const InputDecoration(labelText: "Email Address"),
                      )
                    :  Text("Email: ${usr!.email}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),
                    
                  const SizedBox(height: 30.0),
                  // country textForm
                   isEditing
                  ? DropdownButtonFormField<String>(
                  value: selectedCountry,
                  items: countries
                      .map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      value = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
                  :  Text("Country: ${usr!.country}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                  const SizedBox(height: 30.0),
                   isEditing
                  ? TextFormField(
                      controller: dateOfBirthController,
                      decoration: const InputDecoration(labelText: "Date of Birth"),
                    )
                  :  Text("Date of Birth: ${usr!.dateOfBirth}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      // Save the edited data
                      onPressed: () {
                        setState(() {
                          if (isEditing) {
                            print("Data Saved");
                            // widget.fullName = fullNameController.text;
                            // widget.emailAddress = emailAddressController.text;
                            // widget.country = countryController.text;
                            // widget.dateOfBirth = dateOfBirthController.text;
                          }
                          // Toggle the isEditing flag
                          isEditing = !isEditing;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                          child: Text(isEditing ? "Save" : "Edit Profile"),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      // Save the edited data
                      onPressed: () {
                        Navigator.of(context).pushNamed('login');
                        },
                      child: const Text("SignOut"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          side: BorderSide.none,
                          shape: const StadiumBorder()
                      ),
                    )
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: (){
                addtodb();
              }, child: Text("Add products to Database"))
              ] 
            ),
          )
        )
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
  
  Future<void> fatchUserData()  async{
    try{
      UserInfo? us = await fbs.getUserFromDatabase();
      if(us != null){
        setState((){
          usr = us;
          imgurl = usr!.profilePic;
          selectedCountry = usr!.country;
        });
      } else {
        print("user not found");
      }
    } catch (e){
      print(e.toString());
    }
  }
}