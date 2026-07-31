import 'package:italian_lingo/result_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:italian_lingo/question_repository.dart';

import 'audio_service.dart';

class ExamScreen extends StatefulWidget {
  final String studentName;

  const ExamScreen({
    Key? key,
    required this.studentName,
  }) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late List<Question> questions;
  int currentQuestionIndex = 0;
  int selectedAnswer = -1;
  int score = 0;
  bool showFeedback = false;
  bool isCorrect = false;
  bool showTranslations = true;
  Timer? _feedbackTimer;

  @override
  void initState() {
    super.initState();
    questions = QuestionRepository().getItalianQuestions();
  }

  @override
  void dispose() {
    _feedbackTimer?.cancel();
    super.dispose();
  }

  void _handleFeedback() {
    if (showFeedback) {
      _feedbackTimer = Timer(const Duration(seconds: 4), () {
        if (currentQuestionIndex < questions.length - 1) {
          setState(() {
            currentQuestionIndex++;
            selectedAnswer = -1;
            showFeedback = false;
          });
        } else {
          _navigateToResults();
        }
      });
    }
  }

  void _navigateToResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          studentName: widget.studentName,
          score: score,
          totalQuestions: questions.length,
        ),
      ),
    );
  }

  void _submitAnswer() {
    if (selectedAnswer != -1 && !showFeedback) {
      setState(() {
        isCorrect = selectedAnswer == currentQuestion.correctAnswerIndex;
        if (isCorrect) score++;
        showFeedback = true;
        AudioService.play(questions[currentQuestionIndex].audioPhrase);
      });
      _handleFeedback();
    }
  }

  Question get currentQuestion => questions[currentQuestionIndex];
  double get progress => (currentQuestionIndex + 1) / questions.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                _buildHeaderCard(),
                const SizedBox(height: 16),

                // Progress Bar
                _buildProgressBar(),
                const SizedBox(height: 24),

                // Question Card
                _buildQuestionCard(),
                const SizedBox(height: 16),

                // Feedback Display
                if (showFeedback) ...[
                  _buildFeedbackCard(),
                  const SizedBox(height: 16),
                ],

                // Submit Button
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      color: const Color(0xFF009246), // Italian green
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🇮🇹 Ciao, ${widget.studentName}!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Quiz di Italiano (Italian Quiz)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Domanda ${currentQuestionIndex + 1} di ${questions.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  if (showTranslations)
                    Text(
                      'Question ${currentQuestionIndex + 1} of ${questions.length}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                showTranslations ? Icons.warning : Icons.thumb_up,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  showTranslations = !showTranslations;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFCE2B37)), // Italian red
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Type
            if (currentQuestion.questionType.isNotEmpty) ...[
              Text(
                currentQuestion.questionType,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (showTranslations &&
                  currentQuestion.questionTypeTranslation.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    currentQuestion.questionTypeTranslation,
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else
                const SizedBox(height: 8),
            ],

            // Main Question
            Text(
              currentQuestion.questionText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.44,
              ),
            ),

            // Question Translation
            if (showTranslations &&
                currentQuestion.questionTranslation.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '📝 ${currentQuestion.questionTranslation}',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            // Pronunciation
            if (currentQuestion.pronunciation.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '🔊 ${currentQuestion.pronunciation}',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Answer Options
            ...List.generate(
              currentQuestion.options.length,
              (index) => _buildAnswerOption(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOption(int index) {
    final option = currentQuestion.options[index];
    final isSelected = selectedAnswer == index;
    final isCorrectAnswer = index == currentQuestion.correctAnswerIndex;

    Color backgroundColor;
    if (showFeedback && isCorrectAnswer) {
      backgroundColor = const Color(0xFF4CAF50);
    } else if (showFeedback && isSelected && !isCorrectAnswer) {
      backgroundColor = const Color(0xFFE57373);
    } else if (isSelected) {
      backgroundColor = const Color(0xFF009246).withOpacity(0.2);
    } else {
      backgroundColor = Theme.of(context).colorScheme.surface;
    }

    final textColor = (showFeedback &&
            (isCorrectAnswer || (isSelected && !isCorrectAnswer)))
        ? Colors.white
        : Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        color: backgroundColor,
        elevation: isSelected ? 8 : 2,
        shape: isSelected
            ? RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color(0xFFCE2B37),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
        child: InkWell(
          onTap: () {
            if (!showFeedback) {
              setState(() {
                selectedAnswer = index;
              });
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${String.fromCharCode(65 + index)} $option',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        isSelected ? FontWeight.w500 : FontWeight.normal,
                    color: textColor,
                  ),
                ),
                if (showTranslations &&
                    currentQuestion.optionTranslations.isNotEmpty &&
                    index < currentQuestion.optionTranslations.length &&
                    currentQuestion.optionTranslations[index].isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '→ ${currentQuestion.optionTranslations[index]}',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackCard() {
    return Card(
      color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFE57373),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              isCorrect ? '✓ Corretto! Molto bene!' : '✗ Sbagliato! Non arrenderti!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (showTranslations)
              Text(
                isCorrect ? 'Correct! Very good!' : "Wrong! Don't give up!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                  fontStyle: FontStyle.italic,
                ),
              ),
            if (currentQuestion.explanation.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                currentQuestion.explanation,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              if (showTranslations &&
                  currentQuestion.explanationTranslation.isNotEmpty)
                Text(
                  '📖 ${currentQuestion.explanationTranslation}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.9),
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    final isLastQuestion = currentQuestionIndex == questions.length - 1;

    return ElevatedButton(
      onPressed: (selectedAnswer != -1 && !showFeedback) ? _submitAnswer : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFCE2B37), // Italian red
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isLastQuestion ? 'Termina il Quiz' : 'Conferma Risposta',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          if (showTranslations)
            Text(
              isLastQuestion ? 'Finish Quiz' : 'Confirm Answer',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }
}
