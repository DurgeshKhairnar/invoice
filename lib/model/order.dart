import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invoice/model/add_item_model.dart';

class Order{
  final String id;
  final String status;
  final List<Map<String,dynamic>> items;

  Order({required this.id,required this.status, required this.items});

}

class OrderProvider with ChangeNotifier{

  List<Order> orders = [];
  List<Additem>cartList = [];

   List<Map<String, dynamic>> billSummary() {
    return cartList
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

    void saveAndHold(List<Map<String,dynamic>>? billSummery,{String status = "HOLD"}) {
    if (billSummery!.isEmpty) return;

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      status: status,
      items: billSummery,
    );    
    log('Order Saved: ID=${order.id}, Status=${order.status}, Items=${order.items.length}');
    orders.add(order);
    notifyListeners();
  }

  void updateOrder(String orderId){
    final index = orders.indexWhere((o) => o.id == orderId);
      orders[index] = Order(
        id: orders[index].id,
        status: 'Hold',
        items: billSummary(),
      );
    
      notifyListeners();
  }


   void restoreOrder(String orderId,List<Additem> addItemList) {
    final order = orders.firstWhere((o) => o.id == orderId);
    cartList.clear();
    for (var item in order.items) {
      cartList.add(Additem(
        id:item['id'],
        name: item["name"],
        price: item["price"].toString(),
        img:item["img"] != null ? File(item["img"]) : null,
        qut: item["quantity"],
      ));
    }
    notifyListeners();
  }

    void increment(int index) {
    cartList[index].qut++;
    log('Incremented: Quantity=${cartList[index].qut}, '
        'Total=${cartList[index].total}');
        log('List Length: ${cartList.length}');
    notifyListeners();
  }

  void decrement(int index) {
    if (cartList[index].qut > 0) {
      cartList[index].qut--;
      log('Decremented: Quantity=${cartList[index].qut}, '
          'Total=${cartList[index].total}');
      notifyListeners();
    }
  }

  void claer(dynamic list){
    for(var item in list){
        item.qut = 0;
    }
  }
}



