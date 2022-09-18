import 'package:flutter/material.dart';
import 'package:medic_aid/grid_dash.dart';

class HomeLab extends StatefulWidget {
  const HomeLab({Key? key}) : super(key: key);

  @override
  State<HomeLab> createState() => _HomeLabState();
}

class _HomeLabState extends State<HomeLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 110),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hey, Divyanshu",
                      style: TextStyle(
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
          SizedBox(
            height: 40,
          ),
          GridDashboard(),
        ],
      ),
    );
  }
}
