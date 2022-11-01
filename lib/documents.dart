import 'package:flutter/material.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f3570),
        title: const Text('MedicAid'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: Text('Documents of all patients that the lab have tested are stored here.', textAlign: TextAlign.center,)),
      ),
    );
  }
}
