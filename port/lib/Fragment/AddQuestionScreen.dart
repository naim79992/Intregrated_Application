import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
  final TextEditingController option3Controller = TextEditingController();
  final TextEditingController option4Controller = TextEditingController();
  final TextEditingController correctAnswerController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<String> categories = ["General Knowledge", "Science", "History"];
  String selectedCategory = "General Knowledge"; // Default category
  String adminUsername = "admin"; // Admin username
  String adminPassword = "admin123"; // Admin password

  void addQuestion() async {
    String category = selectedCategory;
    String question = questionController.text;
    List<String> options = [
      option1Controller.text,
      option2Controller.text,
      option3Controller.text,
      option4Controller.text
    ];
    String correctAnswer = correctAnswerController.text;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> storedQuestions =
        sharedPreferences.getStringList('questions_$category') ?? [];
    List<String> storedOptions =
        sharedPreferences.getStringList('options_$category') ?? [];
    List<String> storedCorrectAnswers =
        sharedPreferences.getStringList('correctAnswers_$category') ?? [];

    storedQuestions.add(question);
    storedOptions.addAll(options);
    storedCorrectAnswers.add(correctAnswer);

    await sharedPreferences.setStringList(
        'questions_$category', storedQuestions);
    await sharedPreferences.setStringList('options_$category', storedOptions);
    await sharedPreferences.setStringList(
        'correctAnswers_$category', storedCorrectAnswers);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Question added successfully')),
    );

    // Clear the text fields
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
    correctAnswerController.clear();
  }

  void addCategory() async {
    String newCategory = categoryController.text;
    if (newCategory.isNotEmpty) {
      setState(() {
        categories.add(newCategory);
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setStringList('categories', categories);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Category "$newCategory" added successfully')),
      );
      categoryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Question'),
        backgroundColor: Colors.teal, // Set app bar background color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Add New Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: addCategory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Set button background color
                ),
                child: const Text('Add Category'),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextField(
                controller: questionController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: option1Controller,
                decoration: const InputDecoration(
                  labelText: 'Option 1',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: option2Controller,
                decoration: const InputDecoration(
                  labelText: 'Option 2',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: option3Controller,
                decoration: const InputDecoration(
                  labelText: 'Option 3',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: option4Controller,
                decoration: const InputDecoration(
                  labelText: 'Option 4',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: correctAnswerController,
                decoration: const InputDecoration(
                  labelText: 'Correct Answer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String enteredUsername = usernameController.text;
                  String enteredPassword = passwordController.text;
                  if (enteredUsername == adminUsername &&
                      enteredPassword == adminPassword) {
                    addQuestion();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid Credentials')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Set button background color
                ),
                child: const Text('Add Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
