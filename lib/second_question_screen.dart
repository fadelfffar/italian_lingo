import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// Question model class
class Question {
  final String questionText;
  final List<Answer> answers;

  Question({required this.questionText, required this.answers});
}

// Answer model class
class Answer {
  final String text;
  final bool isCorrect;

  Answer({required this.text, required this.isCorrect});
}

// Second Quiz Screen with Italian language question
class SecondQuestionScreen extends StatefulWidget {
  const SecondQuestionScreen({super.key});

  @override
  SecondQuestionScreenState createState() => SecondQuestionScreenState();
}

class SecondQuestionScreenState extends State<SecondQuestionScreen> {
  int? selectedAnswerIndex;
  bool hasAnswered = false;
  final fileLoader =
      RiveFile.network("https://cdn.rive.app/animations/vehicles.riv");

  // Second question data
  final Question currentQuestion = Question(
    questionText: "What is Italy's national language?",
    answers: [
      Answer(text: "English", isCorrect: false),
      Answer(text: "French", isCorrect: false),
      Answer(text: "Italian", isCorrect: true),
      Answer(text: "Spanish", isCorrect: false),
    ],
  );

  void handleAnswerTap(int index) {
    if (hasAnswered) return;

    setState(() {
      selectedAnswerIndex = index;
      hasAnswered = true;
    });

    final isCorrect = currentQuestion.answers[index].isCorrect;

    if (isCorrect) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompletionScreen(),
            ),
          );
        }
      });
    }
  }

  Color getAnswerColor(int index) {
    if (!hasAnswered) return Colors.green.shade50;

    if (currentQuestion.answers[index].isCorrect) {
      return Colors.green.shade100;
    } else if (selectedAnswerIndex == index) {
      return Colors.red.shade100;
    }
    return Colors.grey.shade100;
  }

  Color getBorderColor(int index) {
    if (!hasAnswered) return Colors.green;

    if (currentQuestion.answers[index].isCorrect) {
      return Colors.green;
    } else if (selectedAnswerIndex == index) {
      return Colors.red;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question 2 of 2'),
        backgroundColor: const Color(0xFF009246),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Rive Animation Container
            Container(
              height: 120,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF009246), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: RiveAnimation.asset(
                  fileLoader as String,
                  fit: BoxFit.contain,
                  onInit: (artboard) {
                    debugPrint('Rive animation loaded successfully');
                  },
                ),
              ),
            ),

            // Question Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF009246), width: 2),
              ),
              child: Text(
                currentQuestion.questionText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Seleziona una risposta:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.answers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => handleAnswerTap(index),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: getAnswerColor(index),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: getBorderColor(index),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getBorderColor(index),
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + index),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                currentQuestion.answers[index].text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (hasAnswered &&
                                currentQuestion.answers[index].isCorrect)
                              const Icon(Icons.check_circle,
                                  color: Colors.green, size: 24),
                            if (hasAnswered &&
                                selectedAnswerIndex == index &&
                                !currentQuestion.answers[index].isCorrect)
                              const Icon(Icons.cancel,
                                  color: Colors.red, size: 24),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            if (hasAnswered)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color:
                      currentQuestion.answers[selectedAnswerIndex!].isCorrect
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        currentQuestion.answers[selectedAnswerIndex!].isCorrect
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
                child: Text(
                  currentQuestion.answers[selectedAnswerIndex!].isCorrect
                      ? '🎉 Eccellente! Quiz completato con successo!'
                      : '❌ Sbagliato. La risposta corretta è Italian.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        currentQuestion.answers[selectedAnswerIndex!].isCorrect
                            ? Colors.green.shade800
                            : Colors.red.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// First Quiz Screen
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  bool hasAnswered = false;

  final Question currentQuestion = Question(
    questionText: "What is the capital of Italy?",
    answers: [
      Answer(text: "London", isCorrect: false),
      Answer(text: "Berlin", isCorrect: false),
      Answer(text: "Rome", isCorrect: true),
      Answer(text: "Madrid", isCorrect: false),
    ],
  );

  void handleAnswerTap(int index) {
    if (hasAnswered) return;

    setState(() {
      selectedAnswerIndex = index;
      hasAnswered = true;
    });

    final isCorrect = currentQuestion.answers[index].isCorrect;

    if (isCorrect) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SecondQuestionScreen(),
            ),
          );
        }
      });
    }
  }

  Color getAnswerColor(int index) {
    if (!hasAnswered) return Colors.green.shade50;

    if (currentQuestion.answers[index].isCorrect) {
      return Colors.green.shade100;
    } else if (selectedAnswerIndex == index) {
      return Colors.red.shade100;
    }
    return Colors.grey.shade100;
  }

  Color getBorderColor(int index) {
    if (!hasAnswered) return Colors.green;

    if (currentQuestion.answers[index].isCorrect) {
      return Colors.green;
    } else if (selectedAnswerIndex == index) {
      return Colors.red;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question 1 of 2'),
        backgroundColor: const Color(0xFF009246),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Rive Animation Container placeholder
            Container(
              height: 120,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF009246), width: 2),
              ),
            ),

            // Question Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF009246), width: 2),
              ),
              child: Text(
                currentQuestion.questionText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Seleziona una risposta:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.answers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => handleAnswerTap(index),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: getAnswerColor(index),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: getBorderColor(index),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getBorderColor(index),
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + index),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                currentQuestion.answers[index].text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (hasAnswered &&
                                currentQuestion.answers[index].isCorrect)
                              const Icon(Icons.check_circle,
                                  color: Colors.green, size: 24),
                            if (hasAnswered &&
                                selectedAnswerIndex == index &&
                                !currentQuestion.answers[index].isCorrect)
                              const Icon(Icons.cancel,
                                  color: Colors.red, size: 24),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            if (hasAnswered)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color:
                      currentQuestion.answers[selectedAnswerIndex!].isCorrect
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        currentQuestion.answers[selectedAnswerIndex!].isCorrect
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
                child: Text(
                  currentQuestion.answers[selectedAnswerIndex!].isCorrect
                      ? '🎉 Corretto! Passando alla domanda successiva...'
                      : '❌ Sbagliato. Riprova!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        currentQuestion.answers[selectedAnswerIndex!].isCorrect
                            ? Colors.green.shade800
                            : Colors.red.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Completion Screen shown after finishing the quiz
class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Completato!'),
        backgroundColor: const Color(0xFF009246),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events,
                  size: 80, color: Color(0xFF009246)),
              const SizedBox(height: 24),
              const Text(
                '🎉 Bravissimo!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF009246),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Hai completato il quiz con successo!\nContinua a studiare l\'italiano!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009246),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Torna alla Home',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
