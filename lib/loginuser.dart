import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_aid/loginlab.dart';
import 'package:medic_aid/registeruser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homeuser.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  static String sharedPreferenceUserLoggedInKeyUser = "ISLOGGEDINUSER";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";


  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }


  static Future<bool> saveUserLoggedInSharedPreferenceUser(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKeyUser, isUserLoggedIn);
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
              Image.asset('assets/user.gif',height: 300,),
              TextField(
                controller: username,
                decoration: const InputDecoration(
                    labelText: "Username",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0f3570),),
                    )
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                controller: password,
                decoration: const InputDecoration(
                    labelText: "Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0f3570),),
                    )
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40.0,),
              ElevatedButton(
                onPressed: (){
                  FirebaseFirestore.instance
                      .collection('user_info').where("username", isEqualTo: username.text).where("password", isEqualTo: password.text).get().then((snapshot){
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
                      saveUserLoggedInSharedPreferenceUser(true);
                      saveUserNameSharedPreference(username.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeUser()),
                      );
                    }
                  });

                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Login as User'),
                ),
              ),
              const SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginLab()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Login as Lab '),
                ),
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an user account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterUser()),
                      );
                    },
                    child: const Text("Register",
                      style: TextStyle(
                        color: Color(0xff0f3570),
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


