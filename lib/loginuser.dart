import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medic_aid/home.dart';
import 'package:medic_aid/loginlab.dart';
import 'package:medic_aid/registeruser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";

  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
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
              Image.asset('assets/user.gif',height: 330,),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: GoogleFonts.dancingScript(fontWeight: FontWeight.bold,fontSize: 20),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    )
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                controller: password,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: GoogleFonts.dancingScript(fontWeight: FontWeight.bold,fontSize: 20),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    )
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40.0,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                  // FirebaseFirestore.instance
                  //     .collection('user_info').where("password", isEqualTo: password.text).get().then((snapshot){
                  //   if (snapshot.docs.isEmpty){
                  //     Fluttertoast.showToast(
                  //         msg: "Credentials are not correct !",
                  //         toastLength: Toast.LENGTH_SHORT,
                  //         gravity: ToastGravity.CENTER,
                  //         timeInSecForIosWeb: 1,
                  //         backgroundColor: Colors.indigo,
                  //         textColor: Colors.white,
                  //         fontSize: 16.0
                  //     );
                  //   }else{
                  //     saveUserLoggedInSharedPreference(true);
                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => const Home()),
                  //     );
                  //   }
                  // });

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
                    "Don't have an account?",
                    style: GoogleFonts.dancingScript(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterUser()),
                      );
                    },
                    child: const Text("Register",
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


