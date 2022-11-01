import 'package:flutter/material.dart';

class LabDocuments extends StatefulWidget {
  const LabDocuments({Key? key}) : super(key: key);

  @override
  State<LabDocuments> createState() => _LabDocumentsState();
}

class _LabDocumentsState extends State<LabDocuments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f3570),
        title: const Text('MedicAid'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: Text('Here the documents uploaded by labs will be visible.', textAlign: TextAlign.center,)),
      ),
    );
  }
}
