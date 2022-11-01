import 'package:flutter/material.dart';
import 'package:medic_aid/labdocuments.dart';
import 'package:medic_aid/mydocuments.dart';
import 'package:medic_aid/mylabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'braintumordetection.dart';
import 'loginuser.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {

  static String sharedPreferenceUserLoggedInKeyUser = "ISLOGGEDINUSER";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  late String username = "User";

  static Future<String?> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<bool> saveUserLoggedInSharedPreferenceUser(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKeyUser, isUserLoggedIn);
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
        title: Text('MedicAid'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          saveUserLoggedInSharedPreferenceUser(false);
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
                      "Hey, $username",
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
                    button(Icons.medical_information_rounded, 'Brain Tumor Detection', BrainTumor()),
                    button(Icons.home, 'My Labs', MyLabs()),
                    button(Icons.newspaper, 'Lab Documents', LabDocuments()),
                    button(Icons.density_small_sharp, 'My Documents', MyDocuments()),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
