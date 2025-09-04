import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:invoice/custom/customContainer.dart';
import 'package:invoice/custom/customText.dart';
import 'package:invoice/model/add_item_model.dart';
import 'package:invoice/model/order.dart';
import 'package:invoice/utility/utility_functions.dart';
import 'package:invoice/view/home.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final bool cart;
  final String MyId;
  @override
  const ProductPage({super.key, this.cart = false , this.MyId = ''});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool? isTab;
  int selectedIndex = 0;
  List<String> paymentMethods = [
    'Cash',
    'Card',
    'UPI',
    'Google Pay',
    'PhonePe',
  ];
  String selectedPaymentMethod = 'Cash';
  @override
  Widget build(BuildContext context) {
    bool cart = widget.cart;
    String MyId = widget.MyId;
    final provider = Provider.of<Additemprovider>(context);
    final providerOrder = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 18), // Custom back icon
          onPressed: () {
            Navigator.pop(context); // Back navigation
          },
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Add order',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed:(){

            },
            icon:Icon(Icons.settings_outlined)),
          CustomContainer(
            margin:5.0,
            height:50,
            width:100,
            onTap:(){},
            child:CustomText(text: 'Add Details',fontWeight:FontWeight.w500)
          )
        ],
      ),
      body: provider.addItemList.isEmpty
          ? Center(child: Text('no Item Added'))
          : SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 160,
                          ),
                      itemCount: cart
                          ? providerOrder.cartList.length
                          : provider.addItemList.length,
                      itemBuilder: (context, index) {
                        final orderList = cart
                            ? providerOrder.cartList[index]
                            : provider.addItemList[index];
                           
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    child: orderList.img == null
                                        ? SizedBox(
                                            height: 100,
                                            width: double.infinity,
                                            child: const Icon(
                                              Icons.image,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image.file(
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: double.infinity,
                                              orderList.img!,
                                            ),
                                          ),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    right: 2,
                                    child: buildCounter(index),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Flexible(
                                child: CustomText(
                                  text: orderList.name,
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: 5),
                              CustomText(
                                text: '\u20b9${orderList.price}',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  _payMethodWidget(),
                  const SizedBox(height: 10),
                  _buildBillSummery(),
                  _buildSaveandHold(MyId),
                ],
              ),
            ),
    );
  }

  Widget _payMethodWidget() {
    return Consumer<Additemprovider>(
      builder: (context, provider, child) {
        // check if at least one item is added
        bool hasItems = provider.addItemList.any((item) => item.qut > 0);

        if (!hasItems) {
          return const SizedBox();
        }
        return Positioned(
          left: 10,
          right: 10,
          bottom: 170,
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                isTab = selectedIndex == index;
                Color containerColor = isTab!
                    ? const Color.fromARGB(255, 37, 110, 255)
                    : Colors.white;
                Color textColor = isTab!
                    ? const Color.fromARGB(255, 37, 110, 255)
                    : Colors.black;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedPaymentMethod = paymentMethods[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: containerColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 7.0,
                      ),
                      child: Center(
                        child: CustomText(
                          text: paymentMethods[index],
                          fontSize: 14,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _customBottomSheet(BuildContext context) {
   bool cart = widget.cart;
    final providerOrder = Provider.of<OrderProvider>(context,listen:false);
    final provider = Provider.of<Additemprovider>(context,listen:false);
    final orderList = cart ? providerOrder.cartList : provider.addItemList;
    final billSummery = cart ? providerOrder.billSummary() : provider.billSummary();
    final items = billSummery;
     double total = Utility.Total(orderList.map((item) => {
       'name': item.name,
       'price': item.price,
       'quantity': item.qut,
     }).toList());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return  Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomText(
                          text: 'Bill Summary',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1, color: Colors.grey),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item['name']),
                        subtitle: Text(
                          "Qty: ${item['quantity']} × ₹${item['price']}",
                        ),
                        trailing: Text("₹${item['total']}"),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomText(
                          text: 'Payment Method: $selectedPaymentMethod',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomText(
                          text: 'Total: $total',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
        });
  }

  Widget _buildBillSummery() {
    bool cart = widget.cart;
    final providerOrder = Provider.of<OrderProvider>(context);
    final provider = Provider.of<Additemprovider>(context);
    final orderList = cart ? providerOrder.cartList : provider.addItemList;
    bool hasItems = orderList.any((i) =>  i.qut > 0 );
    if (!hasItems) {
          return const SizedBox();
        }
    double total = Utility.Total(orderList.map((item) => {
      'name': item.name,
      'price': item.price,
      'quantity': item.qut,
    }).toList());
        
    return  Positioned(
          left: 10,
          right: 10,
          bottom:80,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Bill Summary',
                      fontSize: 13,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {
                        _customBottomSheet(context);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                // total row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Total Amount',
                      fontSize: 13,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                    CustomText(
                      text: '\u20b9${total.toStringAsFixed(2)}',
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
           )
        );
  
  }

  Widget buildCounter(int index) {
    bool cart = widget.cart;
    final providerOrder = Provider.of<OrderProvider>(context);
    final provider = Provider.of<Additemprovider>(context);
    final orderList = cart
        ? providerOrder.cartList[index]
        : provider.addItemList[index];
         
    return orderList.qut < 1
        ? InkWell(
            onTap: () => setState(() {
              orderList.qut = 1;
            }),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 37, 110, 255),
                border: Border.all(
                  color: const Color.fromARGB(255, 37, 110, 255),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.add, size: 15, color: Colors.white),
            ),
          )
        : Container(
            width: 110,
            height: 30,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 37, 110, 255),
              border: Border.all(
                color: const Color.fromARGB(255, 37, 110, 255),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => cart ? providerOrder.increment(index) :provider.increment(index),
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                ),
                CustomText(
                  text: '${orderList.qut}',
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  onPressed: () => cart ? providerOrder.decrement(index) :provider.decrement(index),
                  icon: const Icon(Icons.remove, size: 15, color: Colors.white),
                ),
              ],
            ),
          );
  }

  Widget _buildSaveandHold(String myId) {
    final cart = widget.cart;
    final providerOrder = Provider.of<OrderProvider>(context);
    final provider = Provider.of<Additemprovider>(context);
    return Positioned(
      left: 10,
      right: 10,
      bottom: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomContainer(
            onTap: () {
              if(!cart){
                providerOrder.saveAndHold(provider.billSummary());
              }else{
                log('2nd $myId');
               providerOrder.updateOrder(myId);
              }
              
              //  providerOrder.updateOrder();
              for (var item in provider.addItemList) {
                item.qut = 0;
              }
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => const Home()));
            },
            height: 50,
            width: 170,
            child: CustomText(
              text:cart ? 'Update & Save' :'Save & Hold',
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomContainer(
            onTap: () {
              Navigator.pop(context);
            },
            height: 50,
            width: 170,
            color: const Color.fromARGB(255, 37, 110, 255),
            borderColor: const Color.fromARGB(255, 37, 110, 255),
            child: CustomText(
              text: 'Save & Bill',
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

