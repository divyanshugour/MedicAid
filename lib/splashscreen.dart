import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medic_aid/homeuser.dart';
import 'package:medic_aid/loginuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'homelab.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  static String sharedPreferenceUserLoggedInKeyUser = "ISLOGGEDINUSER";
  static String sharedPreferenceUserLoggedInKeyLab = "ISLOGGEDINLAB";
  bool isLogUser = false;
  bool isLogLab = false;

  @override
  void initState(){
    super.initState();
    initialise();
    getUserLoggedInSharedPreferenceUser().then((value) =>
        setState(() {
          isLogUser = value!;
        }),
    );
    getUserLoggedInSharedPreferenceLab().then((value) =>
        setState(() {
          isLogLab = value!;
        }),
    );
  }

  static Future<bool?> getUserLoggedInSharedPreferenceUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceUserLoggedInKeyUser);
  }

  static Future<bool?> getUserLoggedInSharedPreferenceLab() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceUserLoggedInKeyLab);
  }

  Future<void> initialise() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: isLogUser || isLogLab ? isLogUser ? const HomeUser() : const HomeLab() : const LoginUser(),
      duration: 5000,
      imageSize: 250,
      imageSrc: "assets/logo.png",
      backgroundColor: Colors.white,
    );
  }
}
