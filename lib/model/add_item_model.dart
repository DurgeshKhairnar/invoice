import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class Additem{
   String id;
   String name;
   String price;
   int qut;
   File? img;

  Additem({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
    this.qut = 0,
  });

    Map<String,dynamic> toMap(){
      return {
        'id':id,'name': name, 'price': price, 'qut': qut, 'total': total, 'img': img?.path,
      };
    }
  
   int get total => (int.tryParse(price) ?? 0) * qut;
}

class Additemprovider extends ChangeNotifier{
  
  List<Additem> addItemList = [];
  List<List<Map<String, dynamic>>> saveAndHoldOrder = [];

  void addItem({required id,required name, required price, required img,required qut}){
      addItemList.add(Additem(id:id,name:name ,price:price,img:img,qut:qut));
      notifyListeners();
  }
  
   void increment(int index) {
    addItemList[index].qut++;
    log('Incremented: Quantity=${addItemList[index].qut}, '
        'Total=${addItemList[index].total}');
        log('List Length: ${addItemList.length}');
    notifyListeners();
  }

  void decrement(int index) {
    if (addItemList[index].qut > 0) {
      addItemList[index].qut--;
      log('Decremented: Quantity=${addItemList[index].qut}, '
          'Total=${addItemList[index].total}');
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> billSummary() {
    return addItemList
        .where((item) => item.qut > 0)
        .map((item) => {
              'id':item.id,
              'name': item.name,
              'price': item.price,
              'quantity': item.qut,
              'total': item.total,
            })
        .toList();
  }
    List<Map<String, dynamic>> clear(){
      return addItemList
        .where((item) => item.qut > 0)
        .map((item) => {
              'quantity': item.qut = 0,
            })
        .toList();
    }
  
}