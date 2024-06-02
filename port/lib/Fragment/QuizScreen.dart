import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  SharedPreferences? sharedPreferences;
  int highestScore = 0;
  int quizNumber = 1;
  int questionIndex = 0;
  int score = 0;
  bool isAnswered = false;

  String selectedCategory = "General Knowledge"; // Default category
  String userRole = 'student'; // Default role

  double quizTimeInSeconds = 0.25 * 60; // 15 minutes in seconds
  double timeRemaining = 0.25 * 60; // Initially set to quiz time

  List<String> categories = ["General Knowledge", "Science", "History"];
  Map<String, List<String>> categoryQuestions = {
    "General Knowledge": [
      'What is the capital of France?',
      'Who painted the Mona Lisa?',
      'What is the largest planet in our solar system?',
      'How many continents are there in the world?',
      'What is the largest mammal?',
    ],
    "Science": [
      'What is the largest planet in our solar system?',
      'Which gas do plants absorb from the atmosphere?',
      'What is the powerhouse of the cell?',
      'Who developed the theory of relativity?',
      'What is the chemical symbol for water?',
    ],
    "History": [
      'In which year did Christopher Columbus discover America?',
      'Who is known as the "Father of Modern Physics"?',
      'Who was the first President of the United States?',
      'When did World War II end?',
      'Who wrote "Romeo and Juliet"?',
    ],
  };

  Map<String, List<List<String>>> categoryOptions = {
    "General Knowledge": [
      ['Paris', 'London', 'Madrid', 'Rome'],
      [
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Vincent van Gogh',
        'Claude Monet'
      ],
      ['Saturn', 'Mars', 'Earth', 'Jupiter'],
      ['5', '6', '7', '8'],
      ['Elephant', 'Giraffe', 'Blue Whale', 'Hippopotamus'],
    ],
    "Science": [
      ['Jupiter', 'Mars', 'Earth', 'Saturn'],
      ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
      ['Mitochondria', 'Nucleus', 'Ribosome', 'Endoplasmic Reticulum'],
      ['Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Niels Bohr'],
      ['H2O', 'CO2', 'O2', 'N2'],
    ],
    "History": [
      ['1492', '1607', '1776', '1789'],
      ['Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Niels Bohr'],
      ['George Washington', 'John Adams', 'Thomas Jefferson', 'James Madison'],
      ['1945', '1940', '1949', '1939'],
      ['William Shakespeare', 'Jane Austen', 'Charles Dickens', 'Mark Twain'],
    ],
  };

  Map<String, List<String>> categoryCorrectAnswers = {
    "General Knowledge": [
      'Paris',
      'Leonardo da Vinci',
      'Jupiter',
      '7',
      'Blue Whale',
    ],
    "Science": [
      'Jupiter',
      'Carbon Dioxide',
      'Mitochondria',
      'Albert Einstein',
      'H2O',
    ],
    "History": [
      '1492',
      'Albert Einstein',
      'George Washington',
      '1945',
      'William Shakespeare',
    ],
  };

  List<String> questions = [];
  List<List<String>> options = [];
  List<String> correctAnswers = [];
  List<String> selectedAnswers = [];

  void shuffleQuestionsAndOptions() {
    final random = Random();
    for (var i = questions.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);

      // Swap questions
      final tempQuestion = questions[i];
      questions[i] = questions[j];
      questions[j] = tempQuestion;

      // Swap options
      final tempOptions = options[i];
      options[i] = options[j];
      options[j] = tempOptions;

      // Swap correct answers
      final tempAnswer = correctAnswers[i];
      correctAnswers[i] = correctAnswers[j];
      correctAnswers[j] = tempAnswer;
    }
  }

  void initializeQuestions() {
    questions = categoryQuestions[selectedCategory]!;
    options = categoryOptions[selectedCategory]!;
    correctAnswers = categoryCorrectAnswers[selectedCategory]!;
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
    initializeQuestions();
    shuffleQuestionsAndOptions();
    startQuizTimer();
  }

  void initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      highestScore = sharedPreferences?.getInt('highestScore') ?? 0;
      userRole = sharedPreferences?.getString('role') ?? 'student';
    });
  }

  void updateHighestScore() async {
    final currentScore = sharedPreferences?.getInt('highestScore');
    if (currentScore != null) {
      if (score > currentScore) {
        await sharedPreferences?.setInt('highestScore', score);
        setState(() {
          highestScore = score;
        });
      }
    } else {
      await sharedPreferences?.setInt('highestScore', score);
      setState(() {
        highestScore = score;
      });
    }
  }

  void checkAnswer(String selectedOption) {
    if (isAnswered) {
      return; // Prevent multiple answer selections
    }

    String correctAnswer = correctAnswers[questionIndex];
    bool isCorrect = selectedOption == correctAnswer;

    setState(() {
      selectedAnswers.add(selectedOption);
      isAnswered = true;

      if (isCorrect) {
        score++;
        sharedPreferences?.setInt('highestScore', score);
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (questionIndex < questions.length - 1) {
          questionIndex++;
          isAnswered = false;
          timeRemaining =
              quizTimeInSeconds; // Reset timer for the next question
        } else {
          // Quiz completed, perform any desired actions
          timeRemaining = quizTimeInSeconds; // Reset timer for the next quiz
          shuffleQuestionsAndOptions(); // Shuffle questions and options for the next quiz
        }
      });
    });
  }

  void startQuizTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
          startQuizTimer(); // Recursively call to update the timer
        } else {
          // Time's up, perform any desired actions here
          timeRemaining =
              quizTimeInSeconds; // Reset the timer for the next quiz
          shuffleQuestionsAndOptions(); // Shuffle questions and options for the next quiz
          // You can add actions to proceed to the next question or end the quiz
          // based on your requirements when the time is up.
        }
      });
    });
  }

  void shareScore() {
    String message =
        'I scored $score out of ${questions.length} in the quiz app!';
    Share.share(message);
  }

  void resetQuiz() {
    setState(() {
      selectedAnswers.clear();
      questionIndex = 0;
      quizNumber++;
      score = 0;
      isAnswered = false;
      timeRemaining = quizTimeInSeconds; // Reset timer for the next quiz
      shuffleQuestionsAndOptions(); // Shuffle questions and options for the next quiz
    });
  }

  void updateHighScore() {
    if (score > highestScore) {
      setState(() {
        highestScore = score;
      });
    }
  }

  String getQuizResult() {
    if (score >= 3) {
      return "Pass";
    } else {
      return "Fail";
    }
  }

  Color getResultColor() {
    if (score >= 3) {
      return const Color.fromARGB(255, 3, 112, 7);
    } else {
      return const Color.fromARGB(255, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    String result = getQuizResult();
    Color resultColor = getResultColor();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 134, 105, 251), // Change the app bar color to black
        title: const Text('Quiz App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('role');
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(
            255, 108, 87, 194), // Change the background color to black
        child: userRole == 'admin'
            ? AdminScreen()
            : Column(
                children: [
                  const SizedBox(height: 30),
                  DropdownButton<String>(
                    value: selectedCategory,
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white, // Change text color
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                        initializeQuestions(); // Reload questions for the selected category
                        shuffleQuestionsAndOptions(); // Shuffle questions and options
                        questionIndex = 0; // Reset question index
                        score = 0; // Reset score
                        isAnswered = false; // Reset answer status
                        timeRemaining = quizTimeInSeconds; // Reset timer
                      });
                    },
                    style: const TextStyle(
                      color: Colors.white, // Change button text color
                    ),
                    elevation: 0, // Remove the shadow
                    dropdownColor:
                        Colors.black, // Change the dropdown box color
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Time Remaining: ${(timeRemaining ~/ 60)}:${(timeRemaining % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 17, 2, 64)),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Question ${questionIndex + 1}: ${questions[questionIndex]}',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options[questionIndex].length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedAnswers
                            .contains(options[questionIndex][index]);
                        bool isCorrect = options[questionIndex][index] ==
                            correctAnswers[questionIndex];
                        bool showCorrectAnswer = isAnswered && isCorrect;

                        Color backgroundColor = Colors.transparent;
                        if (isSelected) {
                          backgroundColor =
                              isCorrect ? Colors.green : Colors.red;
                        } else if (showCorrectAnswer) {
                          backgroundColor = Colors.green;
                        }

                        return GestureDetector(
                          onTap: () {
                            if (!isSelected) {
                              checkAnswer(options[questionIndex][index]);
                            }
                          },
                          child: Container(
                            color: backgroundColor,
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text(
                                  '${String.fromCharCode(65 + index)}.',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255,
                                          255) // Increase the font size
                                      ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  options[questionIndex][index],
                                  style: TextStyle(
                                    color: isSelected || showCorrectAnswer
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 254, 254, 254),
                                    fontSize: 20, // Increase the font size
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Score: $score / ${questions.length}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 3, 0, 54)),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.tealAccent),
                    onPressed: shareScore,
                  ),
                  const SizedBox(height: 0),
                  if (selectedAnswers.contains(correctAnswers[questionIndex]))
                    Text(
                      'Correct Answer: ${correctAnswers[questionIndex]}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 47, 107, 49),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Text(
                    'Highest Score: $highestScore',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  // Display result and color signal
                  Text(
                    'Result: $result',
                    style: TextStyle(
                      color: resultColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          updateHighScore();
          resetQuiz();
        },
        child: const Text('Next Quiz'),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quiz $quizNumber',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'High Score: $highestScore',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminScreen extends StatelessWidget {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _option4Controller = TextEditingController();
  final TextEditingController _correctAnswerController =
      TextEditingController();

  void addQuestion() {
    // Add your logic to add a new question
    print('Question added');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _questionController,
          decoration: const InputDecoration(labelText: 'Question'),
        ),
        TextField(
          controller: _option1Controller,
          decoration: const InputDecoration(labelText: 'Option 1'),
        ),
        TextField(
          controller: _option2Controller,
          decoration: const InputDecoration(labelText: 'Option 2'),
        ),
        TextField(
          controller: _option3Controller,
          decoration: const InputDecoration(labelText: 'Option 3'),
        ),
        TextField(
          controller: _option4Controller,
          decoration: const InputDecoration(labelText: 'Option 4'),
        ),
        TextField(
          controller: _correctAnswerController,
          decoration: const InputDecoration(labelText: 'Correct Answer'),
        ),
        ElevatedButton(
          onPressed: addQuestion,
          child: const Text('Add Question'),
        ),
      ],
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isAdmin = false;

  void _login() async {
    String password = _passwordController.text;

    if (_isAdmin) {
      if (password == 'admin_password') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('role', 'admin');
        Navigator.pushReplacementNamed(context, '/quiz');
      } else {
        // Show an error message or handle incorrect password
      }
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('role', 'student');
      Navigator.pushReplacementNamed(context, '/quiz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Login as Admin'),
              value: _isAdmin,
              onChanged: (bool value) {
                setState(() {
                  _isAdmin = value;
                });
              },
            ),
            if (_isAdmin)
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Admin Password'),
                obscureText: true,
              ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/quiz': (context) => const QuizScreen(),
      },
    );
  }
}
