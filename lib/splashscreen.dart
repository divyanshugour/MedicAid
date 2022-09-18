import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medic_aid/home.dart';
import 'package:medic_aid/loginuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  bool isLog = false;

  @override
  void initState(){
    super.initState();
    initialise();
    getUserLoggedInSharedPreference().then((value) =>
        setState(() {
          isLog = value!;
        }),
    );
  }

  static Future<bool?> getUserLoggedInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  Future<void> initialise() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: isLog ? const Home() : const LoginUser(),
      duration: 5000,
      imageSize: 250,
      imageSrc: "assets/logo.png",
      text: "MedicAid",
      textType: TextType.ColorizeAnimationText,
      textStyle: GoogleFonts.dancingScript(fontWeight: FontWeight.bold,fontSize: 40),
      colors: const [
        Color(0xff0f3570),
        Color(0xff0f3570),
        Colors.white,
        Color(0xff0f3570),
      ],
      backgroundColor: Colors.white,
    );
  }
}
