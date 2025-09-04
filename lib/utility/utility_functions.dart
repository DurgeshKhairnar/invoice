class Utility{
 static  double Total(List<Map<String, dynamic>> list){
      double total = 0;
       for(var item in list){
                                  double price = double.tryParse(item['price']) ?? 0.0;
                                  int quantity = item['quantity'];
                               return    total += price * quantity;                  
                    }
                    return total;
  }
}