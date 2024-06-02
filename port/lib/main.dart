import 'package:flutter/material.dart';
import 'package:port/Fragment/Blog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Fragment/personal_info_provider.dart';
import 'Fragment/PersonalProfile.dart';
import 'Fragment/Portfolio.dart';
import 'Fragment/Apps.dart';
import 'Fragment/Skills.dart';
import 'Fragment/Experiences.dart';
import 'Fragment/About.dart';
import 'Fragment/Certificates.dart';
import 'Fragment/Login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PersonalInfoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<PersonalInfoProvider>(
        builder: (context, provider, child) {
          return provider.isLoggedIn ? const HomeActivity() : Login();
        },
      ),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(221, 103, 77, 255),
        hintColor: Colors.black87,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class HomeActivity extends StatelessWidget {
  const HomeActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Portfolio",
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.person, color: Color.fromARGB(255, 0, 24, 18)),
                text: 'About',
              ),
              Tab(
                icon: Icon(Icons.star, color: Colors.tealAccent),
                text: 'Skills',
              ),
              Tab(
                icon: Icon(Icons.work, color: Colors.tealAccent),
                text: 'Experiences',
              ),
              Tab(
                icon:
                    Icon(Icons.apps_outage_outlined, color: Colors.tealAccent),
                text: 'Apps',
              ),
              Tab(
                icon: Icon(Icons.card_membership, color: Colors.tealAccent),
                text: 'Certificates',
              ),
              Tab(
                icon:
                    Icon(Icons.file_upload_outlined, color: Colors.tealAccent),
                text: 'Upload your Info',
              ),
              Tab(
                icon: Icon(Icons.assignment, color: Colors.tealAccent),
                text: 'Portfolio',
              ),
              Tab(
                icon: Icon(Icons.assignment, color: Colors.tealAccent),
                text: 'Blog',
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: const Color.fromARGB(255, 145, 131, 255),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(137, 44, 90, 216),
                  ),
                  child: UserAccountsDrawerHeader(
                    accountName: const Text(
                      "Md. Mehedi Hasan Naim",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    accountEmail: const Text(
                      "mehedi15-14721@diu.edu.bd",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://img.hotimg.com/06455BFF-73DA-453B-93AD-9E7B8B2724CA.jpeg",
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                    ),
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.email,
                  text: 'Gmail',
                  url: 'https://mail.google.com/mail/u/0/#inbox',
                ),
                _buildDrawerItem(
                  icon: Icons.link,
                  text: 'LinkedIn',
                  url:
                      'https://www.linkedin.com/in/md-mehedi-hasan-naim-a592671a7',
                ),
                _buildDrawerItem(
                  icon: Icons.facebook,
                  text: 'Facebook',
                  url: 'https://www.facebook.com/mh.naim.167/',
                ),
                _buildDrawerItem(
                  icon: Icons.camera_enhance_outlined,
                  text: 'Instagram',
                  url: 'https://www.instagram.com/naim6521/',
                ),
                _buildDrawerItem(
                  icon: Icons.account_tree_sharp,
                  text: 'Github',
                  url: 'https://github.com/naim79992',
                ),
                _buildDrawerItem(
                  icon: Icons.note_alt_sharp,
                  text: 'Get CV',
                  url: 'https://github.com/naim79992/My-CV',
                ),
                _buildDrawerItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {
                    Provider.of<PersonalInfoProvider>(context, listen: false)
                        .logout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            const About(),
            const Skills(),
            const Experiences(),
            const Apps(),
            const Certificates(),
            PersonalProfile(),
            const Portfolio(),
            const Blog(),
          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(
      {required IconData icon,
      required String text,
      String? url,
      VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.tealAccent),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      onTap: () async {
        if (url != null) {
          await _launchURL(url);
        } else if (onTap != null) {
          onTap();
        }
      },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
