import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medic_aid/mypatients.dart';
import 'package:medic_aid/patient.dart';
import 'package:popup_card/popup_card.dart';
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
      floatingActionButton: PopupItemLauncher(
        tag: 'test',
        child: Material(
          color: const Color(0xff0f3570),
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: const Icon(
            Icons.add_rounded,
            size: 56,
            color: Colors.white
          ),
        ),
        popUp: PopUpItem(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          elevation: 2,
          tag: 'test',
          child: PopUpItemBody(),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading..."));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: data['username']==username ? data['my_labs']!=null  ? ListView.builder(
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
                  ): const Center(child: Text("No Lab Added")) : const SizedBox(height: 0,),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


class PopUpItemBody extends StatelessWidget {
  const PopUpItemBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'New Lab',
              border: InputBorder.none,
            ),
            cursorColor: Colors.white,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
