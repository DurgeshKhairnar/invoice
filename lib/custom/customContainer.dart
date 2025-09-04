import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final  Function()? onTap;
  final Widget child;
  final double height;
  final double width;
  final Color color;
  final Color borderColor;
  final double margin;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  const CustomContainer({
    super.key,
    required this.onTap,
    required this.child,
    this.height = 50.0,
    this.width = double.infinity,
    this.color = Colors.white,
    this.margin = 0.0,
    this.borderColor = const Color.fromARGB(255, 228, 227, 227),
    this.padding = const EdgeInsets.all(8.0),
    this.alignment =  Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.all(margin),
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          border:Border.all(
              color:borderColor
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment:alignment,
        child:child
      ),
    );
  }
}