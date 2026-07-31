import 'package:flutter/material.dart';
import 'package:italian_lingo/exam_screen.dart';

class ResultScreen extends StatelessWidget {
  final String studentName;
  final String? studentClass;
  final String? studentId;
  final int score;
  final int totalQuestions;

  const ResultScreen({
    Key? key,
    required this.studentName,
    this.studentClass,
    this.studentId,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = ((score / totalQuestions) * 100).toInt();
    final grade = _calculateGrade(percentage);
    final gradeColor = _getGradeColor(grade);
    final message = _getGradeMessage(grade);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // Results Header
              Text(
                'Risultati del Quiz',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 32),

              // Student Info Card
              _buildStudentInfoCard(context),

              const SizedBox(height: 16),

              // Score Card
              _buildScoreCard(context, grade, gradeColor, percentage),

              const SizedBox(height: 16),

              // Message Card
              _buildMessageCard(context, message),

              const Spacer(),

              // Action Buttons
              _buildRetakeButton(context),

              const SizedBox(height: 12),

              _buildBackToHomeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentInfoCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informazioni Studente',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            _buildResultRow('Nome', studentName),
            if (studentClass != null && studentClass!.isNotEmpty)
              _buildResultRow('Classe', studentClass!),
            if (studentId != null && studentId!.isNotEmpty)
              _buildResultRow('Matricola', studentId!),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(
      BuildContext context, String grade, Color gradeColor, int percentage) {
    return Card(
      elevation: 4,
      color: gradeColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Il Tuo Voto',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              grade,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: gradeColor,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: gradeColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$score su $totalQuestions corrette',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageCard(BuildContext context, String message) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetakeButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ExamScreen(studentName: studentName),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Text(
        'Ripeti il Quiz',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Text(
        'Torna alla Home',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  String _calculateGrade(int percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    return 'F';
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return const Color(0xFF4CAF50);
      case 'B':
        return const Color(0xFF2196F3);
      case 'C':
        return const Color(0xFFFF9800);
      case 'D':
        return const Color(0xFFFF5722);
      default:
        return const Color(0xFFF44336);
    }
  }

  String _getGradeMessage(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return '🎉 Eccellente! Ottima prestazione!';
      case 'B':
        return '👏 Bravo! Ottimo lavoro!';
      case 'C':
        return '👍 Discreto. Continua a esercitarti!';
      case 'D':
        return '📚 Hai passato, ma c\'è spazio per migliorare.';
      default:
        return '💪 Non arrenderti! Studia di più e riprova.';
    }
  }
}
