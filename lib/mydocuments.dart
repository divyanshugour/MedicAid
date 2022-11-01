import 'package:flutter/material.dart';

class MyDocuments extends StatefulWidget {
  const MyDocuments({Key? key}) : super(key: key);

  @override
  State<MyDocuments> createState() => _MyDocumentsState();
}

class _MyDocumentsState extends State<MyDocuments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f3570),
        title: const Text('MedicAid'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: Text('Here User can upload documents from the gallery which they want to store on our apps cloud database.', textAlign: TextAlign.center,)),
      ),
    );
  }
}
