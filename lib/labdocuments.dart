import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_images/carousel_images.dart';


class LabDocuments extends StatefulWidget {
  const LabDocuments({Key? key}) : super(key: key);

  @override
  State<LabDocuments> createState() => _LabDocumentsState();
}

class _LabDocumentsState extends State<LabDocuments> {
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  late String username = "User";
  CollectionReference users = FirebaseFirestore.instance.collection('user_info');
  late List<String> listImages = ['https://img.freepik.com/free-vector/no-data-concept-illustration_114360-536.jpg'];

  static Future<String?> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserNameKey);
  }

  @override
  void initState() {
    getUserNameSharedPreference().then((value) =>
        setState(() {
          username = value!;
        })
    );
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
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(username).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Center(
              child: CarouselImages(
                scaleFactor: 0.6,
                listImages: listImages,
                height: 500.0,
                borderRadius: 30.0,
                cachedNetworkImage: true,
                verticalAlignment: Alignment.topCenter,
                onTap: (index){
                  print('Tapped on page $index');
                },
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            listImages = List<String>.from(data['lab_docs']);
            return Center(
              child: CarouselImages(
                scaleFactor: 0.6,
                listImages: listImages,
                height: 500.0,
                borderRadius: 30.0,
                cachedNetworkImage: true,
                verticalAlignment: Alignment.topCenter,
                onTap: (index){
                  print('Tapped on page $index');
                },
              ),
            );
          }
          return Text("loading");
        },
      ),
    );
  }
}


