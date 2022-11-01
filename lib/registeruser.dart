import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
  TextEditingController username = TextEditingController();
  TextEditingController number_controller= TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
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
              const SizedBox(height: 10.0,),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                    labelText: "Name",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    )
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                controller: username,
                decoration: const InputDecoration(
                    labelText: "Username",
                    focusedBorder: UnderlineInputBorder(
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
                decoration: const InputDecoration(
                    labelText: "Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    )
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40.0,),
              TextField(
                controller: confirmpassword,
                decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    )
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40.0,),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    if (confirmpassword.text == password.text){
                      FirebaseFirestore.instance
                          .collection('user_info').doc(username.text).set(
                          {'name': name.text,
                            'username': username.text,
                            'password': password.text,
                            'number': number_controller.text
                          });
                      Fluttertoast.showToast(
                          msg: "User Registered Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.indigo,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginUser()),
                      );
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: "Password Not Matched",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.indigo,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
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
                  const Text(
                    "Already have an account!"),
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
