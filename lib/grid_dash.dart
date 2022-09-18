import "package:flutter/material.dart";

import 'home.dart';


// ignore: must_be_immutable
class GridDashboard extends StatefulWidget {
  const GridDashboard({Key? key}) : super(key: key);


  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  bool tappedYes = false;

  Items item1 = Items(
      no: "1", title: "Face\nAnalysis", img: "assets/images/facial-1.png");

  Items item2 = Items(
      no: "2", title: "Twitter\nAnalysis", img: "assets/images/twitter.png");

  Items item3 = Items(
      no: "3", title: "Thoughts", img: "assets/images/thoughts-3.png");

  Items item4 = Items(no: "4", title: "PHQ - 9", img: "assets/icons/phq9.png");

  Items item5 = Items(no: "5", title: "Daily\nFacts", img: "assets/images/facts-5.png");

  Items item6 = Items(no: "6", title: "Reports", img: "assets/images/Reports-4.png");

  Items item7 = Items(no: "7", title: "Profile", img: "assets/icons/profile.png");

  Items item8 = Items(no: "8", title: "Logout", img: "assets/icons/logout.png");

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8
    ];

    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
                // color: widget.change(),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      // color: widget.shadowchange(),
                      offset: Offset(10, 15),
                      blurRadius: 1.5,
                      spreadRadius: 0.5)
                ]),
            child: ElevatedButton(
              onPressed: () async {
                if (data.no == '1') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                } else if (data.no == '2') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Home()));
                } else if (data.no == '3') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                } else if (data.no == '4') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                } else if (data.no == '5') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                } else if (data.no == '6') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                } else if (data.no == '7') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                } else if (data.no == '8') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                }
                //print("Clicked  ${data.no} ");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    data.img,
                    width: 56,
                    height: 56,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "Muli",
                        // color: widget.txtchange(),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Items {
  String title;
  String img;
  String no;

  Items({required this.title, required this.img, required this.no});
}