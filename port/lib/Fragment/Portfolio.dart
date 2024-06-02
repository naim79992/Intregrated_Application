// Portfolio.dart

import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color.fromARGB(255, 100, 90, 249), Colors.grey[900]!],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Project list",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const PortfolioItem(
              projectName: "FoodMate",
              projectLink: "https://github.com/naim79992/Food-Mate",
              projectDescription:
                  "In this project I have made a food delivary website",
            ),
            const SizedBox(height: 16),
            const PortfolioItem(
              projectName: "Student Management System",
              projectLink:
                  "https://github.com/naim79992/Student-management-system",
              projectDescription: "This is a Java based project.",
            ),
            const SizedBox(height: 16),
            const PortfolioItem(
              projectName: "Weather App",
              projectLink: "https://github.com/naim79992/Weather-app",
              projectDescription: "This is a Flutter based project.",
            ),
            const SizedBox(height: 16),
            const PortfolioItem(
              projectName: "Scientific Calculator",
              projectLink:
                  "https://github.com/naim79992/Scientific-Calculator_",
              projectDescription: "This is a fully functional calculator app.",
            ),
            // Add more PortfolioItem widgets as needed
          ],
        ),
      ),
    );
  }
}

class PortfolioItem extends StatelessWidget {
  final String projectName;
  final String projectLink;
  final String projectDescription;

  const PortfolioItem({
    super.key,
    required this.projectName,
    required this.projectLink,
    required this.projectDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color.fromARGB(255, 255, 23, 23),
      child: ListTile(
        title: Text(
          projectName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              projectDescription,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              projectLink,
              style: const TextStyle(
                color: Colors.teal,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        onTap: () {
          // Add actions for when the portfolio item is tapped
        },
      ),
    );
  }
}
