import 'package:flutter/material.dart';
import 'package:invoice/custom/customContainer.dart';
import 'package:invoice/custom/customText.dart';
import 'package:invoice/custom/listTile.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
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
          'Menu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                        buildListTile(),
                        const SizedBox(height: 10,),

          /// 🔹 Menu List
          Expanded(
            child: ListView(
              children:  [
                MenuTile(icon: Icons.local_dining_rounded, title: "Items",onTap:null),
                MenuTile(icon: Icons.people, title: "Regular Customers",onTap:null),
                MenuTile(icon: Icons.campaign, title: "Marketing Tools",onTap:null),
                MenuTile(icon: Icons.bar_chart, title: "Reports",onTap:null),
                MenuTile(
                  icon: Icons.print,
                  title: "Printer",
                  subtitle: "Not Connected",
                  onTap:null,
                ),
                MenuTile(icon: Icons.headset_mic, title: "Support",onTap:null),
              ],
            ),
          ),

          /// 🔹 Bottom Button
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Container(
          //     height: 50,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: const [
          //         Icon(Icons.workspace_premium, color: Colors.amber),
          //         SizedBox(width: 8),
          //         Text(
          //           "Buy Zaayka Gold",
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         ),
          //         Spacer(),
          //         Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          //         SizedBox(width: 12),
          //       ],
          //     ),
          //   ),
          // ),
                    ],),
          ),
        ),
      ),
    );
  }
  Widget buildListTile(){
    return Align(
                        alignment:Alignment.center,
                        child: CustomContainer(
                          onTap:null,
                          height:100,
                          width:390,
                          borderColor:const Color.fromARGB(255, 217, 215, 215),
                          child:ListTile(
                            leading:CircleAvatar(
                              radius:40,
                              backgroundColor:const Color.fromARGB(255, 241, 239, 239),
                              child:CustomText(text:'D',fontWeight:FontWeight.w500,fontSize:20)
                            ),
                            title:CustomText(text:'Enter Restaurant Name',fontWeight:FontWeight.w500,fontSize:13),
                            subtitle:CustomText(text:'+91 98980123',fontWeight:FontWeight.w500,fontSize:12,color:const Color.fromARGB(255, 93, 92, 92),textAlign:TextAlign.left),
                            trailing:IconButton(onPressed: (){}, icon:Icon(Icons.arrow_forward_ios,size:13))
                          )
                        ),
                      );
  }
}
