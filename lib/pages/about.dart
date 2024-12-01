// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_signup/pages/nav_bar.dart';
import 'package:login_signup/screens/sign_in.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 222, 229),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text('M E D V'),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 139, 253),
        foregroundColor: Colors.white,
        elevation: 0,

        /* leading: IconButton(
          onPressed: () {
            // list for display history
          },
          icon: const Icon(Icons.menu),
        ), */
        /* actions: [
          IconButton(
            onPressed: () {
              // sign up
            },
            icon: const Icon(Icons.help),
          ),
        ], */
        //actions: [
        /* IconButton(
            onPressed: () {
              // sign up
            },
            icon: const Icon(Icons.menu),
          ),*/

        // ],
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Text(
          "The Macaulay education system, initiated by Thomas Babington Macaulay on February 2, 1835, in India, has been a foundational element of Indian education, emphasizing the primacy of English and European science and literature. Over nearly two centuries, this system has endured. However, it has encountered criticism for its limited coverage of moral science and challenges in knowledge dissemination. To rectify these limitations, this project introduces the Macaulay Education Digitalized Video Application. This application aims to transform education by providing students with a dynamic learning experience. It leverages artificial intelligence (AI) to convert text-based educational content into visually engaging video presentations. Users can input text, and the application transforms it into video format. This initiative responds to the evolving pedagogical landscape and strives to democratize education by making high-quality learning resources readily accessible to a broad audience. The project employs the Flutter framework for cross-platform compatibility, uses the Dart programming language for both front-end and back-end development and integrates Firebase for data storage and management, and implements Python-based AI components for text-to-video conversion. ",
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
