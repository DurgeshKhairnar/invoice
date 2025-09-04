import 'package:flutter/material.dart';

class CustomTextSpane extends StatelessWidget{
    final String text;

  const CustomTextSpane({
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context){
      return Text.rich(
        textAlign:TextAlign.left,
                                TextSpan(
                                  text: text,
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: " *",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              );
  }
}