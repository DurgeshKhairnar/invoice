import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice/custom/customContainer.dart';
import 'package:invoice/custom/customText.dart';
import 'package:invoice/custom/customTextFiled.dart';
import 'package:invoice/custom/textSpan.dart';

class AddMenuItemPage extends StatefulWidget {
  const AddMenuItemPage({super.key});

  @override
  State<AddMenuItemPage> createState() => _AddMenuItemPageState();
}

class _AddMenuItemPageState extends State<AddMenuItemPage> {
   File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? selectedCategory;
  String? selectedTax;

  bool defaultTax = true;
  bool favourite = false;

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();

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
          'Add Menu Item',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width:double.infinity,
          height:double.infinity,
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
                  CustomTextSpane(
                    text:'Item Name'
                  ),
                  const SizedBox(height: 10,),
                  CustomtextFiled(
                    controller:itemNameController,
                    color:Colors.grey
                  ),
                  const SizedBox(height: 10,),
                  CustomText(
                    text:'Item Image'
                  ),
                  const SizedBox(height: 10,),
                  // CustomContainer(
                  //       height:100,
                  //       onTap: () => pickImageInsideModal(ImageSource.gallery),
                  //       borderColor: Colors.black,
                  //       child: (_imageFile != null)
                  //           ? ClipRRect(
                  //               borderRadius: BorderRadius.circular(12),
                  //               child: Image.file(
                  //                 _imageFile!,
                  //                 width: double.infinity,
                  //                 height: 200,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             )
                  //           : const Icon(Icons.add_a_photo, size: 40),
                  //     ),
            ],
          ),
        ),
      ),
    );
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

