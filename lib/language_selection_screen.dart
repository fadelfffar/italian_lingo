import 'package:flutter/material.dart';

import 'exam_screen.dart';
import 'question_repository.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Lingo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose a language to practise',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 48),
              _LanguageCard(
                flag: '🇮🇹',
                languageName: 'Italian',
                subtitle: 'University · Bureaucracy · Work · Housing',
                color: const Color(0xFF009246),
                onTap: () => _startQuiz(context, AppLanguage.italian),
              ),
              const SizedBox(height: 20),
              _LanguageCard(
                flag: '🇰🇪',
                languageName: 'Swahili',
                subtitle: 'Greetings · Market · Food · Transport · Health',
                color: const Color(0xFF006600),
                onTap: () => _startQuiz(context, AppLanguage.swahili),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startQuiz(BuildContext context, AppLanguage language) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExamScreen(
          studentName: 'Student',
          language: language,
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String flag;
  final String languageName;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.flag,
    required this.languageName,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: color, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
