import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unifynd/api.dart';
import 'package:unifynd/constants.dart';
import 'package:unifynd/screens/dashboard_screens/clubs.dart';
import 'package:unifynd/screens/dashboard_screens/restaurants.dart';
import 'package:unifynd/screens/dashboard_screens/services.dart';
import 'package:unifynd/screens/dashboard_screens/home.dart';
import 'package:unifynd/screens/login.dart';

import '../classes.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 2;
  Widget screenToShow = HomeScreen();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        screenToShow = ServiceScreen();
      } else if (index == 1) {
        screenToShow = RestaurantsScreen();
      } else if (index == 2) {
        screenToShow = HomeScreen();
      } else if (index == 3) {
        screenToShow = ClubsScreen();
      } else if (index == 4) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Sign out"),
                content: Text("Are you sure you want to sign out?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () async {
                        FirebaseAuth.instance.signOut();
                        //navigate to login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: Text("Sign out")),
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        Container(
          alignment: Alignment(-0.1, 0.9),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
              child: LogoWhite(29)),
          height: size.height * 0.15,
          width: size.width,
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              //make a list with 20 elements
              child: screenToShow),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Dining',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Sign out',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
