import 'package:flutter/material.dart';
import 'package:port/Fragment/AddQuestionScreen.dart';
import 'package:port/Fragment/CalculatorScreen.dart';
import 'package:port/Fragment/home_page.dart';
import 'package:port/Fragment/RankingPage.dart';
//import 'package:port/home_page.dart';
import 'QuizScreen.dart';

class Apps extends StatelessWidget {
  const Apps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Apps"),
        backgroundColor:
            const Color.fromARGB(255, 141, 179, 223), // Set the app bar color
      ),
      body: Container(
        color: const Color.fromARGB(255, 168, 168,
            215), // Change this to your preferred background color
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(
                  10), // Add margin for spacing around the box
              padding: const EdgeInsets.all(10), // Add padding inside the box
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 66, 66, 66), // Black box color
                borderRadius: BorderRadius.circular(10), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5), // Shadow color
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ExpansionTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.quiz,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "Complete Quiz App",
                  style: TextStyle(
                      color: Colors.white), // Customize the text color
                ),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                children: [
                  AppListItem(
                    appName: "Quiz App",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizScreen()),
                      );
                    },
                    icon: Icons.question_answer,
                    iconColor: Colors.blue, // Customize the icon color
                  ),
                  AppListItem(
                    appName: "Add Question",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddQuestionScreen()),
                      );
                    },
                    icon: Icons.question_mark,
                    iconColor: Colors.blue, // Customize the icon color
                  ),
                  AppListItem(
                    appName: "Rank",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RankingPage()),
                      );
                    },
                    icon: Icons.square_rounded,
                    iconColor: Colors.blue, // Customize the icon color
                  ),
                ],
              ),
            ),
            AppListItem(
              appName: "Weather App",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: Icons.cloud,
              iconColor: Colors.orange, // Customize the icon color
            ),
            AppListItem(
              appName: "Calculator App",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculatorScreen()),
                );
              },
              icon: Icons.calculate,
              iconColor: Colors.green, // Customize the icon color
            ),
            // Add more AppListItems as needed
          ],
        ),
      ),
    );
  }
}

class AppListItem extends StatelessWidget {
  final String appName;
  final Function onTap;
  final IconData icon;
  final Color iconColor;

  const AppListItem({
    required this.appName,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(
          255, 66, 66, 66), // Customize the card background color
      elevation: 4, // Add elevation for a subtle shadow
      margin: const EdgeInsets.all(10), // Add margin for spacing
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor,
          child: Icon(
            icon,
            color: Colors.white, // Customize the icon color
          ),
        ),
        title: Text(
          appName,
          style:
              const TextStyle(color: Colors.white), // Customize the text color
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
