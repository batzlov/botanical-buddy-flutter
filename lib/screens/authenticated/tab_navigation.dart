import 'package:flutter/material.dart';
import 'package:botanicalbuddy/screens/authenticated/create_plant.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';

import '../../components/header.dart';

import './home.dart';
import './plants.dart';
import './settings.dart';
import './test.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({ Key? key }) : super(key: key);

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  final AuthService auth = AuthService();

  late User user;
  String userName = "Nutzer";

  @override
  void initState() {
    auth.getUserFromLocalStorage().then((localUser) {
      setState(() {
        user = localUser;
        userName = user.firstName;
      });
    });

    super.initState();
  }
  
  int tabIndex = 0;
  static List<Widget> tabs = [
    const Home(),
    const Plants(),
    const VSettings(),
    const Test()
  ];

  void onItemTapped(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> headers = [
      Header(
        headline: "Hallo liebe/r $userName",
        subHeadline: "Hast du dir heute schon angesehen wie es deinen Pflanzen geht?",
        headerHeight: 140,
      ),
      Header(
        headline: "Amigos",
        subHeadline: "Verwalte deine Pflanzen",
        headerHeight: 140,
        childWidget: GestureDetector(
          onTap: () {},
          child: GestureDetector(
            onTap:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePlant())
              );
            },
            child: const Text(
              "Möchtest du einen neuen Amigo hizufügen?",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                decoration: TextDecoration.underline
              ),
            ),
          ),
        )
      ),
      const Header(
        headline: "Einstellungen",
        subHeadline: "",
        headerHeight: 100,
      ),
      const Header(
        headline: "Test & co",
        subHeadline: "",
        headerHeight: 100,
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: headers.elementAt(tabIndex)
      ),
      body: Container(
        color: Colors.grey[200],
        child: tabs.elementAt(tabIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Übersicht',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Amigos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Einstellungen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: 'Test'
          ),
        ],
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
        backgroundColor: const Color(0xff50665a),
      ),
    );
  }
}