import 'package:flutter/material.dart';
import 'package:invoice/model/add_item_model.dart';
import 'package:invoice/model/order.dart';
import 'package:invoice/view/home.dart';
import 'package:invoice/view/menu/addItems.dart' show AddMenuItemPage;
import 'package:invoice/view/menu/menu.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => Additemprovider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:ThemeData(
          scaffoldBackgroundColor:Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor:Colors.white,
          )
      ),
      home:AddMenuItemPage(),
    );
  }
}
