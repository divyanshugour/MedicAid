import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medic_aid/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPatients extends StatefulWidget {
  const MyPatients({Key? key}) : super(key: key);

  @override
  State<MyPatients> createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user_info').snapshots();
  static String sharedPreferenceUserLabKey = "USERLABKEY";
  late String username = "User";

  static Future<String?> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserLabKey);
  }

  @override
  void initState(){
    super.initState();
    getUserNameSharedPreference().then((value) =>
        setState(() {
          username = value!;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f3570),
        title: const Text('MedicAid'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading..."));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: data['my_labs']!=null ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: data['my_labs'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return data['my_labs'][index]==username ? ListTile(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Patient(data['username'])),
                            );
                          },
                          iconColor: const Color(0xff0f3570),
                          leading: const Icon(Icons.accessibility,size: 40,),
                          title: Text(data['username'])
                      ): const SizedBox(height: 0,);
                    },
                  ):const SizedBox(height: 0,),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
