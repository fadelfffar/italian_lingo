# 🇮🇹 Italian Lingo

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)
[![Deploy](https://github.com/fadelfffar/italian_lingo/actions/workflows/deploy-web.yml/badge.svg)](https://github.com/fadelfffar/italian_lingo/actions)
[![Live Demo](https://img.shields.io/badge/demo-live-brightgreen)](https://fadelfffar.github.io/italian_lingo/)

A Flutter app for learning practical Italian — built for students and newcomers to Italy.

**👉 [Try it live](https://fadelfffar.github.io/italian_lingo/)**

<!-- Add a screenshot or GIF here -->
<!-- <img src="docs/screenshot.png" width="300" alt="Quiz screen" /> -->

## ✨ Features

- 📝 **Interactive Quiz** — Multiple-choice questions on essential Italian vocabulary
- 🏛️ **Real-life Content** — University, bureaucracy, jobs, housing, and social life
- 🔊 **Audio Pronunciation** — Text-to-speech for Italian phrases
- 🌐 **Bilingual** — Toggle between Italian and English
- 📊 **Progress Tracking** — Visual progress bar and score results

## 📚 Topics Covered

| Topic | Examples |
|---|---|
| University & enrollment | `Segreteria Studenti`, `numero di matricola` |
| Bureaucracy & visas | `Permesso di soggiorno`, `Codice Fiscale` |
| Jobs & work | `Curriculum Vitae`, `colloquio di lavoro`, `tirocinio` |
| Housing & daily life | `l'affitto`, bank accounts, SIM cards |
| Social & networking | Student events, language basics |

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.x or later
- A device, emulator, or Chrome (for web)

### Setup

```bash
git clone https://github.com/fadelfffar/italian_lingo.git
cd italian_lingo
flutter pub get
flutter run
```

## 🌍 Deployment

The web app auto-deploys to [GitHub Pages](https://fadelfffar.github.io/italian_lingo/) on every push to `main`.

> One-time setup: enable **Settings → Pages → Source: GitHub Actions**.

## 🧩 Tech Stack

| Package | Purpose |
|---|---|
| `flutter_bloc` | State management |
| `supabase_flutter` | Backend integration |
| `flutter_tts` | Italian audio pronunciation |
| `rive` | Animations |
| `webview_flutter` | In-app web views |

## 📁 Project Structure

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

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.