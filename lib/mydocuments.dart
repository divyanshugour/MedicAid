import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyDocuments extends StatefulWidget {
  const MyDocuments({Key? key}) : super(key: key);

  @override
  State<MyDocuments> createState() => _MyDocumentsState();
}

class _MyDocumentsState extends State<MyDocuments> {

  late File _image;

  getImageFromUser() async {
    _image = (await PickImage.getImage())!;
  }

  @override
  void initState() {
    _image = File('assets/logo.png');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f3570),
        title: const Text('MedicAid'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffffffff),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0f3570),
        onPressed: () {
          getImageFromUser();
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Center(
            child: Image.asset('assets/upload.gif'),
        ),
      ),
    );
  }
}


abstract class PickImage {
  static Future<File?> getImage() async {
    var selectedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (selectedImage == null) return null;
    File image = File(selectedImage.path);
    return image;
  }
}