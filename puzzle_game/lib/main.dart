import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(LogicalPuzzleGame());
}

class LogicalPuzzleGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: PuzzleScreen(),
    );
  }
}

class PuzzleScreen extends StatefulWidget {
  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> puzzles = [
    {"question": "What comes next in the sequence? 2, 6, 12, 20, 30, ?", "options": ["36", "42", "56", "50"], "answer": "42"},
    {"question": "A train 150m long is running at a speed of 90km/h. How long will it take to pass a pole?", "options": ["6 seconds", "8 seconds", "5 seconds", "7 seconds"], "answer": "6 seconds"},
    {"question": "If 2 cats can catch 2 mice in 2 minutes, how many cats are needed to catch 100 mice in 100 minutes?", "options": ["2", "50", "100", "1"], "answer": "2"},
    {"question": "What comes next in the series? 1, 1, 2, 3, 5, 8, 13, ?", "options": ["20", "21", "18", "22"], "answer": "21"},
    {"question": "Divide 30 by 1/2 and add 10. What is the result?", "options": ["25", "50", "70", "40"], "answer": "70"},
    {"question": "A clock shows the time as 3:15. What is the angle between the hour and minute hands?", "options": ["7.5°", "15°", "22.5°", "30°"], "answer": "7.5°"},
    {"question": "A man spends 1/3 of his salary on rent, 1/4 on food, and 1/5 on travel. If he saves \$300, what is his salary?", "options": ["\$900", "\$1200", "\$1800", "\$1500"], "answer": "\$1800"},
    {"question": "What is the next number in the sequence? 128, 64, 32, 16, ?", "options": ["4", "6", "8", "10"], "answer": "8"},
    {"question": "If 7 is added to half a number, the result is 20. What is the number?", "options": ["26", "30", "18", "20"], "answer": "26"},
    {"question": "A car travels 60 miles in 1.5 hours. What is its average speed in miles per hour?", "options": ["30 mph", "40 mph", "45 mph", "50 mph"], "answer": "40 mph"},
  ];

  int currentPuzzleIndex = 0;
  int score = 0;
  String selectedOption = '';
  String feedbackMessage = '';

  @override
  Widget build(BuildContext context) {
    final currentPuzzle = puzzles[currentPuzzleIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Logical Puzzle Game", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.deepPurple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Puzzle ${currentPuzzleIndex + 1}/${puzzles.length}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: Offset(4, 4)),
                    ],
                  ),
                  child: Text(
                    currentPuzzle["question"],
                    style: TextStyle(fontSize: 22, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                ...currentPuzzle["options"].map<Widget>((option) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = option;
                        feedbackMessage = (selectedOption == currentPuzzle["answer"])
                            ? "Correct! 🎉"
                            : "Wrong! The correct answer is ${currentPuzzle["answer"]}.";
                        score += (selectedOption == currentPuzzle["answer"]) ? 1 : 0;

                        Future.delayed(Duration(seconds: 1), () {
                          if (currentPuzzleIndex < puzzles.length - 1) {
                            setState(() {
                              currentPuzzleIndex++;
                              selectedOption = '';
                              feedbackMessage = '';
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Game Over"),
                                  content: Text("Your final score is $score/${puzzles.length}"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          currentPuzzleIndex = 0;
                                          score = 0;
                                          selectedOption = '';
                                          feedbackMessage = '';
                                        });
                                      },
                                      child: Text("Restart"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        });
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: selectedOption == option ? Colors.orangeAccent : Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 12, offset: Offset(5, 5)),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      child: Text(
                        option,
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(height: 30),
                if (feedbackMessage.isNotEmpty)
                  Text(
                    feedbackMessage,
                    style: TextStyle(fontSize: 20, color: feedbackMessage.contains("Correct") ? Colors.green : Colors.red),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}