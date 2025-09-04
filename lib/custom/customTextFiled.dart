import 'package:flutter/material.dart';

class CustomtextFiled extends StatelessWidget{
  final bool obscureText;
  final String labelText;
  final Widget? suffixIcon;
  final String hint;
  final String validatortext;
  final Color color;
  final double width;
  final Color textcolor;
  final int maxLines;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  const CustomtextFiled({super.key,
  this.obscureText = false,
   this.suffixIcon,
   this.maxLines = 1,
   this.labelText = '',
   this.hint = '',
   this.validatortext = '',
   this.width = 370,
   this.textcolor = Colors.black,
  required this.color,
  required this.controller,
  this.validator,
  });
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width:width,
      child:TextFormField(
        obscuringCharacter: '*',
        obscureText:obscureText,
        maxLines:maxLines,
        controller:controller,
        style:TextStyle(
          color:textcolor,
        ),
        decoration:InputDecoration(
          suffixIcon:suffixIcon,
          hintText:hint,
          labelText:labelText,
          labelStyle:TextStyle(
            color:Colors.black,
          ),
          floatingLabelStyle:TextStyle(
            color:Colors.black,
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(10),
            borderSide:BorderSide(
              color:const Color.fromARGB(255, 37, 56, 255)
            ),
          ),
            errorStyle: TextStyle( // 👇 Change error message color here
          color: Colors.red,
          fontSize: 14,
        ),
          errorBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(10),
            borderSide:BorderSide(
              color:Colors.red
            ),
          ),
           focusedErrorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color), // Keep border Blue on error + focus
          ),
          enabledBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(10),
            borderSide:BorderSide(
              color:Colors.black
            ),
          ),
        ),
        
         validator: validator ?? (value) {
                  if ( validatortext.isNotEmpty && (value == null || value.trim().isEmpty)) {
                    return validatortext;
                  }
                  return null;
                },
      )
    );
  }
}