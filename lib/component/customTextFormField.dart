import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final  TextEditingController myController;
  final  String? Function(String?)? validatorInfo;
  

  CustomTextForm({
    Key? key,
    required this.hinttext,
    required this.myController,
    required this.validatorInfo,
  });


  @override
  Widget build(BuildContext context) {
    return  
      TextFormField(
                  validator: 
                    validatorInfo,
                  controller: 
                    myController,
                  decoration: InputDecoration(
                    labelText: hinttext,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )              
      );
  }
}