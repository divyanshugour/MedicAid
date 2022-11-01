import 'package:flutter/material.dart';

class MyPatients extends StatefulWidget {
  const MyPatients({Key? key}) : super(key: key);

  @override
  State<MyPatients> createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f3570),
        title: const Text('MedicAid'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: Text('List of patients, lab can upload documents.', textAlign: TextAlign.center,)),
      ),
    );
  }
}
