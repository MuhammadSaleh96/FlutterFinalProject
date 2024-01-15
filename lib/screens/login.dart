
import 'package:flutter/material.dart';
import 'package:tap_and_trip/main.dart';
import '../component/customLogo.dart';
import '../component/customTextFormField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController= TextEditingController(); 
  // here we create obiect 
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool _obscureText = true;
  bool checkVal = false;

  // --- SIGN IN METHOD --- 
  _handleSignIn() {
    Auth().signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
    ).whenComplete(() {
      print("User signed in Successfully");
      Navigator.pushNamed(context, "homepage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
         child: Padding(
            padding: EdgeInsets.only(bottom: 24.0 ,
                                    top:56.0,
                                    right:24.0,
                                    left:24.0),
            child: Column(
                    children: [
                      // to put the log and title and subtitle in column "part1Section"
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLogo(),
                          Center(
                            child: RichText(
                                text: TextSpan(
                                  text: 'Tap ',
                                style: DefaultTextStyle.of(context).style.copyWith(
                                decoration: TextDecoration.none, // Remove underline
                                color: Colors.black, // Set text color to black
                                ),
                                children: const <TextSpan>[
                                TextSpan(text: 'and', style: TextStyle(fontWeight: FontWeight.w300,),),
                                TextSpan(text: ' Trip!', style: TextStyle(color: Color.fromARGB(255, 9, 135, 194))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),//end part1Section
                      Form(
                        key: formState,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0 ),
                          child: Column(
                            children: [
                        // USERNAME (EMAIL) TEXT FORM FIELD
                            CustomTextForm(
                              hinttext: "Enter username or email",
                              myController: emailController,
                              validatorInfo:  (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Must enter username';
                                } 
                                return null;
                              }),
                            SizedBox(height: 16.0),
                            // PASSWORD TEXT FORM FIELD
                            TextFormField(
                                obscureText: _obscureText,
                                validator: 
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Must enter password';
                                    } 
                                    return null;
                                  },
                                controller: 
                                  passwordController,
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
                            ),
                            SizedBox(height: 8.0),
                            // remember me & Forget Password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //remember me 
                                Row(
                                  children: [
                                    Checkbox(
                                      value: checkVal, 
                                      onChanged: (value){
                                        setState(() {
                                          checkVal = value!;
                                        });
                                      },
                                      activeColor: Colors.black12,
                                      checkColor: Colors.lightBlue,
                                    ),
                                    Text("Remember Me",style: TextStyle(color: Colors.lightBlue),),
                                  ],
                                ),
                                TextButton(
                                  child: 
                                  Text("Forget Password?", style: TextStyle(color: Colors.lightBlue),), 
                                  onPressed:(){} 
                                  ,)
                              ],
                            ),
                            SizedBox(height: 32.0),                       
                            // sign in and sign up  buttons 
                            Container(
                              width:double.infinity,
                              child: 
                              ElevatedButton(child: 
                                  Text("Sign in"), 
                                  onPressed:() {
                                    if(formState.currentState!.validate()){
                                     _handleSignIn();
                                     Navigator.of(context).pushReplacementNamed("homepage");  
                                    } 
                                  }
                                )                               
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              width:double.infinity,
                              child: ElevatedButton(
                                child:Text("Create Account"), 
                                onPressed: (){
                                  Navigator.of(context).pushNamed("Register");
                                },
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  // divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Divider(color: Colors.grey, thickness: 0.5, indent: 60, endIndent: 5,)),
                      Text("Or Sign In With"),
                      Flexible(child: Divider(color: Colors.grey, thickness: 0.5, indent: 5, endIndent: 60,)),
                    ],
                  ),
                  SizedBox(height:32.0),     
                  // footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: (){},
                    icon: Image(
                      width: 24.0,
                      height:24.0,
                      image: AssetImage("../images/Google-Logo.jpg"),
                    )
                  )
                ),
                SizedBox(width:16.0),
                Container(
                  decoration: BoxDecoration(
                    border: 
                      Border.all(color: Colors.grey),
                    borderRadius: 
                      BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: (){},
                    icon: Image(
                      width: 24.0,
                      height:24.0,
                      image: AssetImage("../images/Google-Logo.jpg"),
                      )
                  )
                ), 
              ],
            ),
          ],
        )
      ),
    )
   );
 }
 
}
