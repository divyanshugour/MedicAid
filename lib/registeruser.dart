import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:medic_aid/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginuser.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  String n = '';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  TextEditingController name = TextEditingController();
  TextEditingController btname = TextEditingController();
  TextEditingController number_controller= TextEditingController();
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
          padding: const EdgeInsets.only(top: 100,left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('RegisterUser',
                style: GoogleFonts.dancingScript(fontWeight: FontWeight.bold,fontSize: 40),
              ),
              const SizedBox(height: 20.0,),
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
                controller: btname,
                decoration: InputDecoration(
                    labelText: "Bluetooth Name",
                    labelStyle: GoogleFonts.dancingScript(fontWeight: FontWeight.bold,fontSize: 20),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    )
                ),
              ),
              const SizedBox(height: 40.0,),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {},
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                textFieldController: number_controller,
                formatInput: false,
                keyboardType:
                const TextInputType.numberWithOptions(signed: true, decimal: true),
                inputBorder: const OutlineInputBorder(),
                onSaved: (PhoneNumber number) {},
              ),
              const SizedBox(height: 30.0,),
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
                  setState(() {
                    saveUserLoggedInSharedPreference(true);
                    FirebaseFirestore.instance
                        .collection('user_info').doc(name.text).set(
                        {'bluetooth_name': btname.text,
                          'password': password.text,
                          'number': number_controller.text
                        });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text('RegisterUser'),
                ),
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account!",
                    style: GoogleFonts.dancingScript(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginUser
                          ()),
                      );
                    },
                    child: const Text("Login",
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
