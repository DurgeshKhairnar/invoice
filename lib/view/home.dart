import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice/custom/customContainer.dart';
import 'package:invoice/custom/customText.dart';
import 'package:invoice/custom/customTextFiled.dart';
import 'package:invoice/model/add_item_model.dart';
import 'package:invoice/model/order.dart';
import 'package:invoice/utility/utility_functions.dart';
import 'package:invoice/view/additems.dart';
import 'package:invoice/view/menu/menu.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final providerOrder = Provider.of<OrderProvider>(context);
    final providerAddItem = Provider.of<Additemprovider>(context);
    return Scaffold(
      appBar:AppBar(
        leading:Icon(Icons.food_bank_outlined,size:30),
        title:CustomText(text: 'Enter Restaurant Name',fontSize:16),
        actions:[
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed:(){},
            icon:Icon(Icons.access_time)),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Menu(),));
            },
            icon:Icon(Icons.menu))
        ]
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset('assets/addOrderm.png', height: 400,width: 400,),
              Expanded(
                child: ListView.builder(
                  shrinkWrap:true,
                  itemCount:providerOrder.orders.length,
                  itemBuilder: (context, index) {
                    final orderList = providerOrder.orders[index].items;
                    double total = Utility.Total(orderList);
                    return CustomContainer(
                      margin:5,
                      onTap:null,
                      height:130,
                      width:70,
                      borderColor:Colors.grey,
                      child:Column(children: [
                        Row(children: [
                          CustomContainer(
                            onTap:null,
                            width:50,
                            height:50,
                            borderColor:Colors.grey,
                            child:CustomText(text:"T1",color:Colors.black,fontWeight:FontWeight.w500)
                          ),
                          const SizedBox(width:10),
                          CustomContainer(
                            onTap:null,
                            width:MediaQuery.of(context).size.width * 0.30,
                            height:50,
                            borderColor:Colors.grey,
                            child:CustomText(text:"\u20b9$total",color:Colors.black,fontWeight:FontWeight.w500)
                          ),
                          Spacer(),
                            IconButton(
                              onPressed:(){
                                final orderId = providerOrder.orders[index].id;
                                providerOrder.restoreOrder(orderId,providerAddItem.addItemList);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(cart:true,MyId:orderId)));
                              },
                              icon:const Icon(Icons.edit,color:Colors.black,size:20)
                            )
                        ],),
                        const Divider(),
                        Expanded(child:
                         ListView.builder(
                           scrollDirection:Axis.horizontal,
                          itemCount: orderList.length,
                          itemBuilder: (context,index){
                            return CustomContainer(
                              margin:2,
                              onTap:null,
                              height:70,
                              width:100,
                              borderColor:Colors.grey,
                              child:CustomText(
                                text:"${orderList[index]['name']}",
                                color:Colors.black,
                                fontWeight:FontWeight.w500,
                                textAlign:TextAlign.start
                              )
                            );
                        }),)
                      ],)
                    );
                  })
              ),
              CustomContainer(
                onTap:() =>providerAddItem.addItemList.isEmpty?  _showBottomSheet(context):
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductPage()),
                ),
                height: 50,
                color: const Color.fromARGB(255, 37, 110, 255),
                borderColor: const Color.fromARGB(255, 37, 110, 255),
                child: CustomText(
                  text: providerAddItem.addItemList.isEmpty ? 'Add Item':'Add Order',
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final provider = Provider.of<Additemprovider>(context, listen: false);
        return StatefulBuilder(
          builder: (context, setModalState) {
            Future<void> pickImageInsideModal(ImageSource source) async {
              final XFile? pickedFile = await _picker.pickImage(source: source);
              if (pickedFile != null) {
                final selected = File(pickedFile.path);
                setModalState(() {
                  _imageFile = selected;
                });
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Item Name', color: Colors.black),
                      const SizedBox(height: 10),
                      CustomtextFiled(
                        controller: nameController,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 10),

                      CustomText(text: 'Item Price', color: Colors.black),
                      const SizedBox(height: 10),
                      CustomtextFiled(
                        controller: priceController,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 10),

                      CustomText(text: 'Item Image', color: Colors.black),
                      const SizedBox(height: 10),
                      CustomContainer(
                        height:100,
                        onTap: () => pickImageInsideModal(ImageSource.gallery),
                        borderColor: Colors.black,
                        child: (_imageFile != null)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _imageFile!,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.add_a_photo, size: 40),
                      ),

                      const SizedBox(height: 20),
                      CustomContainer(
                        onTap: () {
                          final String id = DateTime.now().millisecondsSinceEpoch.toString();
                          final String name = nameController.text.trim();
                          final String price = priceController.text.trim();
                          final File? image = _imageFile;
                          final int qut = 0;
                          if (name.isNotEmpty && price.isNotEmpty) {
                            provider.addItem(
                              id:id,
                              name: name,
                              price: price,
                              img: image,
                              qut: qut,
                            );
                            if (provider.addItemList.isNotEmpty) {
                              _clearForm();
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductPage(),
                                ),
                              );
                            }
                          }
                        },
                        height: 50,
                        color: const Color.fromARGB(255, 37, 110, 255),
                        borderColor: const Color.fromARGB(255, 37, 110, 255),
                        child: CustomText(
                          text: 'Add Item',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _clearForm() {
    nameController.clear();
    priceController.clear();
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
}
