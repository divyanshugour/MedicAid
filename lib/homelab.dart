import 'package:flutter/material.dart';
import 'package:medic_aid/documents.dart';
import 'package:medic_aid/loginlab.dart';
import 'package:medic_aid/loginuser.dart';
import 'package:medic_aid/mypatients.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'braintumordetection.dart';
import 'mylabs.dart';

class HomeLab extends StatefulWidget {
  const HomeLab({Key? key}) : super(key: key);

  @override
  State<HomeLab> createState() => _HomeLabState();
}

class _HomeLabState extends State<HomeLab> {


  static String sharedPreferenceUserLoggedInKeyLab = "ISLOGGEDINLAB";
  static String sharedPreferenceUserLabKey = "USERLABKEY";
  late String userlabname = "Lab";

  static Future<String?> getUserLabSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserLabKey);
  }


  static Future<bool> saveUserLoggedInSharedPreferenceLab(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKeyLab, isUserLoggedIn);
  }

  @override
  void initState(){
    super.initState();
    getUserLabSharedPreference().then((value) =>
        setState(() {
          userlabname = value!;
        })
    );
  }


  Widget button(icon, String text, next){
    return Column(
      children: [
        GestureDetector(
          onTap: ()
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => next),
            );
          },
          child: Container(
            child: Row(
              children:[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(icon,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Text(text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),
              ],
            ),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color(0xff0f3570),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2, 4),
                      blurRadius: 1.5,
                      spreadRadius: 0.5)
                ]),
          ),
        ),
        const SizedBox(height: 20,)
      ],
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
        backgroundColor: Colors.redAccent,
        onPressed: () {
          saveUserLoggedInSharedPreferenceLab(false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginUser()),
          );
        },
        child: const Icon(Icons.logout),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey, $userlabname",
                      style: const TextStyle(
                          fontFamily: "Open Sans",
                          // color: themeSwitch ? Colors.black : Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  button(Icons.accessibility, 'My Patients', MyPatients()),
                  button(Icons.text_snippet_outlined, 'Documents', Documents()),
                ],
              ),
            )
            ),
        ],
      ),
    );
  }
}
