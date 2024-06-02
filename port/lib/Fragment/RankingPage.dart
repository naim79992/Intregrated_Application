import 'package:flutter/material.dart';

void main() {
  runApp(RankingApp());
}

class RankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ranking Page',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 94, 63, 236),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          titleMedium:
              TextStyle(fontSize: 16, color: Color.fromARGB(255, 18, 15, 205)),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.grey[300],
          elevation: 3,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          titleTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Color.fromARGB(255, 47, 0, 255),
          iconColor: Colors.blue,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: const Color.fromARGB(255, 92, 92, 255)),
      ),
      home: RankingPage(),
    );
  }
}

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<Map<String, dynamic>> students = [
    {'name': 'Naim', 'score': 5},
    {'name': 'Hasan', 'score': 4},
    {'name': 'Khaled', 'score': 3},
    {'name': 'user1', 'score': 2},
    {'name': 'user2', 'score': 0},
  ];

  @override
  Widget build(BuildContext context) {
    // Sort the students list based on score in descending order
    students.sort((a, b) => b['score'].compareTo(a['score']));

    // Update the rank for each student
    for (int i = 0; i < students.length; i++) {
      students[i]['rank'] = i + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 255, 7, 7),
              shadowColor: Colors.grey[400],
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15.0),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    '${students[index]['rank']}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                title: Text(
                  students[index]['name'],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  'Score: ${students[index]['score']}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
