import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medic_aid/braintumordetection.dart';
import 'package:medic_aid/homelab.dart';
import 'package:firebase_storage/firebase_storage.dart';



class Patient extends StatefulWidget {

  final String username;

  const Patient(this.username,{Key? key}) : super(key: key);

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  bool _isLoading = true;
  bool isGet = false;
  late File _image;
  String imageUrl = '';

  getImageFromUser() async {
    _image = (await PickImage.getImage())!;
    setState(() {
      isGet = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _image = File('assets/logo.png');
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
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Upload in, " + widget.username + "'s account.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Open Sans",
                    // color: themeSwitch ? Colors.black : Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),

            isGet ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(_image), fit: BoxFit.cover),
                ),
              ),
            ):Image.asset('assets/upload.gif'),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Select an image, you want to upload in patient's account.",
                textAlign: TextAlign.center,
              ),
            ),
            isGet ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages = referenceRoot.child(widget.username + '_docs');
                    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
                    //Handle errors/success
                    try {
                      //Store the file
                      await referenceImageToUpload.putFile(File(_image.path));
                      //Success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                      FirebaseFirestore.instance
                          .collection('user_info').doc(widget.username).update({"lab_docs": FieldValue.arrayUnion([imageUrl])});
                    } catch (error) {
                      print('hiiii');
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text("Upload Image"),
                ),
              ),
            ):Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                child: OutlinedButton.icon(
                  onPressed: () {
                    getImageFromUser();
                  },
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text("Choose Image"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
