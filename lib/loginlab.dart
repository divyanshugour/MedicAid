import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_aid/homelab.dart';
import 'package:medic_aid/registeruser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginuser.dart';

class LoginLab extends StatefulWidget {
  const LoginLab({Key? key}) : super(key: key);

  @override
  State<LoginLab> createState() => _LoginLabState();
}

class _LoginLabState extends State<LoginLab> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  static String sharedPreferenceUserLoggedInKeyLab = "ISLOGGEDINLAB";
  static String sharedPreferenceUserLabKey = "USERLABKEY";


  static Future<bool> saveUserLabSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserLabKey, userName);
  }

  static Future<bool> saveUserLoggedInSharedPreferenceLab(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKeyLab, isUserLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0,),
              Image.asset('assets/lab.gif',height: 300,),
              const SizedBox(height: 20.0,),
              const SizedBox(height: 20.0,),
              TextField(
                controller: username,
                decoration: const InputDecoration(
                    labelText: "Name",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    )
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                controller: password,
                decoration: InputDecoration(
                    labelText: "Password",
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    )
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40.0,),
              ElevatedButton(
                onPressed: (){
                  FirebaseFirestore.instance
                      .collection('lab_info').where("username", isEqualTo: username.text).where("password", isEqualTo: password.text,).get().then((snapshot){
                    if (snapshot.docs.isEmpty){
                      Fluttertoast.showToast(
                          msg: "Credentials are not correct !",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.indigo,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }else{
                      saveUserLabSharedPreference(username.text);
                      saveUserLoggedInSharedPreferenceLab(true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeLab()),
                      );
                    }
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Login as Lab '),
                ),
              ),
              const SizedBox(height: 20.0,),
              const SizedBox(height: 20.0,),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an lab account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterUser()),
                      );
                    },
                    child: const Text("Contact Us",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),),

                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}
