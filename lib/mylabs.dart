import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyLabs extends StatefulWidget {
  const MyLabs({Key? key}) : super(key: key);

  @override
  State<MyLabs> createState() => _MyLabsState();
}

class _MyLabsState extends State<MyLabs> {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user_info').snapshots();
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  late String username = "User";

  static Future<String?> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserNameKey);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0f3570),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: data['username']==username && data['my_labs']!=null ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: data['my_labs'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: const Icon(Icons.delete),
                        iconColor: const Color(0xff0f3570),
                        leading: const Icon(Icons.home,size: 40,),
                        title: Text(data['my_labs'][index])
                      );
                    },
                  ): Container(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
