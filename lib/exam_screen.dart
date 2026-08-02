import 'package:italian_lingo/result_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:italian_lingo/question_repository.dart';

import 'audio_service.dart';

class ExamScreen extends StatefulWidget {
  final String studentName;
  final AppLanguage language;

  const ExamScreen({
    Key? key,
    required this.studentName,
    this.language = AppLanguage.italian,
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

  bool get _isSwahili => widget.language == AppLanguage.swahili;

  // Language-specific colour scheme
  Color get _primaryColor =>
      _isSwahili ? const Color(0xFF006600) : const Color(0xFF009246);
  Color get _accentColor =>
      _isSwahili ? const Color(0xFFCC0000) : const Color(0xFFCE2B37);

  @override
  void initState() {
    super.initState();
    questions = _isSwahili
        ? QuestionRepository().getSwahiliQuestions()
        : QuestionRepository().getItalianQuestions();
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
          language: widget.language,
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
        final locale = _isSwahili ? 'sw-KE' : 'it-IT';
        AudioService.play(
          questions[currentQuestionIndex].audioPhrase,
          locale: locale,
        );
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
    final greeting = _isSwahili
        ? '🇰🇪 Karibu, ${widget.studentName}!'
        : '🇮🇹 Ciao, ${widget.studentName}!';
    final quizTitle = _isSwahili
        ? 'Mazoezi ya Kiswahili (Swahili Quiz)'
        : 'Quiz di Italiano (Italian Quiz)';
    final questionLabel = _isSwahili
        ? 'Swali ${currentQuestionIndex + 1} kati ya ${questions.length}'
        : 'Domanda ${currentQuestionIndex + 1} di ${questions.length}';
    final questionLabelEn =
        'Question ${currentQuestionIndex + 1} of ${questions.length}';

    return Card(
      color: _primaryColor,
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
                    greeting,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    quizTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    questionLabel,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  if (showTranslations)
                    Text(
                      questionLabelEn,
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
        valueColor: AlwaysStoppedAnimation<Color>(_accentColor),
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
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
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
      backgroundColor = _primaryColor.withOpacity(0.2);
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
                side: BorderSide(
                  color: _accentColor,
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
    final correctText = _isSwahili ? '✓ Sahihi! Hongera!' : '✓ Corretto! Molto bene!';
    final incorrectText =
        _isSwahili ? '✗ Kosa! Jaribu tena!' : '✗ Sbagliato! Non arrenderti!';
    final correctTextEn = 'Correct! Very good!';
    final incorrectTextEn = "Wrong! Don't give up!";

    return Card(
      color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFE57373),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              isCorrect ? correctText : incorrectText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (showTranslations)
              Text(
                isCorrect ? correctTextEn : incorrectTextEn,
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
    final finishLabel = _isSwahili ? 'Maliza Mazoezi' : 'Termina il Quiz';
    final confirmLabel = _isSwahili ? 'Thibitisha Jibu' : 'Conferma Risposta';
    final finishLabelEn = 'Finish Quiz';
    final confirmLabelEn = 'Confirm Answer';

    return ElevatedButton(
      onPressed: (selectedAnswer != -1 && !showFeedback) ? _submitAnswer : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _accentColor,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isLastQuestion ? finishLabel : confirmLabel,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          if (showTranslations)
            Text(
              isLastQuestion ? finishLabelEn : confirmLabelEn,
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
