// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:login_signup/pages/about.dart';
import 'package:login_signup/pages/chatbot_search.dart';
import 'package:login_signup/pages/search_box.dart';
import 'package:login_signup/screens/sign_in.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const Padding(
      padding: EdgeInsets.all(16.0),
      child: ChatGPTTextField(),
    ),
    const Padding(
      padding: EdgeInsets.all(16.0),
      child: ChatBotSearch(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 207, 222, 229),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text('M E D V'),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 139, 253),
        foregroundColor: Colors.white,
        elevation: 0,

      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 101, 170, 226),
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "M E D V",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: const Color.fromARGB(255, 236, 218, 218),
                ),
                title: Text(
                  "Home",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return NavBar();
                    }),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: const Color.fromARGB(255, 236, 218, 218),
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AppSignInScreen();
                    }),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help_rounded,
                  color: const Color.fromARGB(255, 236, 218, 218),
                ),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AboutApp();
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 139, 253),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        selectedItemColor: const Color.fromARGB(255, 207, 222,
            229), // Change the color of the selected item icon and label
        selectedLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 207, 222,
                229)), // Change the color of the selected item label
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.ondemand_video_rounded,
              color: Colors.white,
            ),
            label: "Video",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Colors.white,
            ),
            label: "Chat Bot",
          ),
        ],
      ),
    );
  }
}
