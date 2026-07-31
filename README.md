# Italian Lingo

A Flutter mobile app for learning Italian, targeted at students and newcomers to Italy.

## Features

- **Interactive Quiz**: Multiple-choice questions covering essential Italian vocabulary
- **Italian-focused Content**: Vocabulary covering university life, bureaucracy, job search, housing, and social situations
- **Audio Pronunciation**: Text-to-speech (TTS) for Italian phrases using `flutter_tts`
- **Bilingual Support**: Toggle between Italian and English translations
- **Progress Tracking**: Visual progress bar and score results

## Topics Covered

- University & enrollment (`Segreteria Studenti`, `numero di matricola`)
- Bureaucracy & visas (`Permesso di soggiorno`, `Codice Fiscale`)
- Job search & work (`Curriculum Vitae`, `colloquio di lavoro`, `tirocinio`)
- Housing & daily life (`l'affitto`, bank accounts, SIM cards)
- Social & networking (international student events, language basics)

## Getting Started

1. **Clone the repo**
   ```bash
   git clone https://github.com/fadelfffar/italian_lingo.git
   cd italian_lingo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Deployment

- The web app auto-deploys to GitHub Pages on every push to `main` at:
  `https://fadelfffar.github.io/italian_lingo/`
- One-time setup for the repository owner: enable **Settings → Pages → Source: GitHub Actions**.

## Dependencies

- `flutter_tts` — Text-to-speech for Italian audio pronunciation
- `supabase_flutter` — Backend integration
- `rive` — Animations
- `flutter_bloc` — State management
- `equatable` — Value equality
- `webview_flutter` — In-app web views

## Project Structure

```
lib/
  main.dart                    # App entry point
  exam_screen.dart             # Main quiz screen
  result_screen.dart           # Results display
  question_repository.dart     # Italian question data
  audio_service.dart           # TTS audio service
  second_question_screen.dart  # Secondary quiz screen
test/
  widget_test.dart             # Widget tests
```

## Resources

- [Flutter documentation](https://docs.flutter.dev/)
- [Flutter cookbook](https://docs.flutter.dev/cookbook)
- [Dart language tour](https://dart.dev/language)