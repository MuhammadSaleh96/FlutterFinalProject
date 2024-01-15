import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tap_and_trip/main.dart';
import 'package:file_picker/file_picker.dart';
import '../class models/country_info.dart';
import '../class models/user_info.dart';
import '../component/customLogo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../component/customTextFormField.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _selectedCountry = "Jordan";
  DateTime _selectedDate = DateTime.now();
  TextEditingController datePickedController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  List <String> countries = ["Jordan", "Saudi Arabia", "Emirates", "Oman", "Syria","United States","Canada"];
  bool _obscureText = true;
  bool _obscureText2 = true;
  FilePickerResult? _img;
  
  String datePicked = "";
  

  Future<void> pickAnImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result == null) {
        return;
      } else {
        setState(() {
          _img = result;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
                                                                            
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        datePickedController.text = "${_selectedDate.toLocal()}".split(' ')[0];
      });
      
    }
  }

  final DatabaseReference userRef = FirebaseDatabase.instance.ref().child("Users");
  final Reference profileimageref = FirebaseStorage.instance.ref().child(
    "UserProfileImage/${DateTime.now().millisecondsSinceEpoch}.jpg"
  );

//add user info to real time database
  Future<void> _handleSignUp() async{
    UploadTask uploadTask = profileimageref.putData(_img!.files.first.bytes!); 

    String imgurl = await(await uploadTask).ref.getDownloadURL();
    Auth().createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
      ).whenComplete(() {
        print("User created successfully");
        Auth().auth.authStateChanges().first;
        Future.delayed(Duration(seconds: 3)).then((value) {
          try{
            UserInfo user = UserInfo(
              fullName: _fullNameController.text,
              email: _emailController.text,
              dateOfBirth: datePickedController.text,
              country: _selectedCountry,
              profilePic: imgurl
            );
          if (Auth().auth.currentUser!=null ){
            userRef.child(Auth().auth.currentUser!.uid).set(user.toMap())
            .then((value) {             
              print("User added successfully to Database");
              Navigator.pushNamed(context, "homepage");
            }).catchError((error){
              print("Failed to add user to real time Database");
              print("error occured.....");
              print(error.message);
            });
          }else{
            print("The user uid is still null");
          }  
          } on FirebaseException catch (error){
            print(error.toString());
        }
        Navigator.pushNamed(context, "homepage");
      });
    });     
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(

      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
           children: [
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 50.0),
                CustomLogo(),
                SizedBox(height: 20.0),
                Text("Register",
                     style: TextStyle(fontSize: 30.0,
                                      fontWeight: FontWeight.bold)
                     ),
                  kIsWeb
                    ? _img == null
                        ? IconButton(
                            onPressed: () {
                              pickAnImage();
                            },
                            icon: const CircleAvatar(
                              radius: 25, // Adjust the radius as needed
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              pickAnImage();
                            },
                            icon: CircleAvatar(
                              radius: 25, // Adjust the radius as needed
                              backgroundImage:
                                  MemoryImage(_img!.files.first.bytes!),
                            ),
                          )
                    : _img == null
                        ? IconButton(
                            onPressed: () {
                              pickAnImage();
                            },
                            icon: const CircleAvatar(
                              radius: 25, // Adjust the radius as needed
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              pickAnImage();
                            },
                            icon: CircleAvatar(
                              radius: 25, // Adjust the radius as needed
                              backgroundImage:
                                  MemoryImage(_img!.files.first.bytes!),
                            ),
                          ),

                SizedBox(height: 20.0), 
                //             --- FULLNAME FIELD ---
                CustomTextForm(hinttext: "Enter your Full Name", myController: _fullNameController,
                 validatorInfo:
                    (value) {
                      if (value!.isEmpty) {
                        return 'Required Filed';
                      } else {
                        return null;
                      }
                    }
                ),
                SizedBox(height: 20.0),
                //             --- USERNAME(EMAIL) FIELD ---
                CustomTextForm(hinttext: "Enter your Email", myController: _emailController,
                 validatorInfo: (value) {
                    if (value!.isEmpty) {
                      return 'Required Filed';
                    } else {
                      return null;
                    }
                  }
                ),
                SizedBox(height: 20.0),
                //             --- DATE_SELECTOR FIELD ---
                GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: datePickedController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
                SizedBox(height: 20.0),
                //             --- COUNTRY SELECT DROP DOWN MENU ---
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  items: countries
                      .map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCountry = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //             --- PASSWORD FIELD ---
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black38,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required Field';
                    } else if (value.length < 6 || value.length > 16) {
                      return 'Password must be between 6 and 16 characters';
                    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
                      return 'Password must contain at least one capital letter';
                    } else if (!RegExp(r'(?=.*?[!@#$%^&*()_+])').hasMatch(value)) {
                      return 'Password must contain at least one special character';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                //            --- CONFIRM PASSWORD FIELD ---
                TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureText2,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText2 ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black38,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText2 = !_obscureText2;
                            });
                          },
                        ),
                ),
                  validator: (value) {
                    if (value!.isEmpty) {
                        return 'Required Field';
                    } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: Container(
                    width: double.infinity,
                    height: 40.0,
                    child: 
                    MaterialButton(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.lightBlue,
                      onPressed: () async{// here code for create account 
                        if(formKey.currentState!.validate()){
                          _handleSignUp();
                        }
                      },
                    child: Text("Sign up"),
                    )
                  )
                ),
               SizedBox(height: 20.0),
               InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("login");
                },
                child: Container(
                  alignment: Alignment.center,
                  // child: Text("Don't Have An Account? Register")
                    child: Text.rich(TextSpan(children: [TextSpan(text:"Have An Account ?"),
                    TextSpan(text:" Login", style: TextStyle(
                      color:Colors.lightBlue, 
                      fontWeight: FontWeight.bold
                    )
                          ),                       
                        ],
                      ),
                    ),
                  ),
                ),         
              ],
            ),
          ],
          ),
        ),
      ),
    );
  }
}