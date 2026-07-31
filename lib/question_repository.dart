// Italian question data class with translation and audio fields
class Question {
  final int id;
  final String questionText;
  final String questionTranslation;
  final List<String> options;
  final List<String> optionTranslations;
  final int correctAnswerIndex;
  final String questionType;
  final String questionTypeTranslation;
  final String pronunciation;
  final String explanation;
  final String explanationTranslation;
  // Field for Text-to-Speech engine
  final String audioPhrase;

  const Question({
    required this.id,
    required this.questionText,
    this.questionTranslation = "",
    required this.options,
    this.optionTranslations = const [],
    required this.correctAnswerIndex,
    this.questionType = "",
    this.questionTypeTranslation = "",
    this.pronunciation = "",
    this.explanation = "",
    this.explanationTranslation = "",
    this.audioPhrase = "",
  });
}

class QuestionRepository {
  // Private constructor for singleton pattern
  QuestionRepository._();

  // Static instance
  static final QuestionRepository _instance = QuestionRepository._();

  // Factory constructor returns the same instance
  factory QuestionRepository() => _instance;

  List<Question> getItalianQuestions() {
    return [
      // --- University & Enrollment ---
      const Question(
        id: 1,
        questionType: "University - Enrollment",
        questionTypeTranslation: "University - Enrollment",
        questionText: "How do you say 'I am a computer science student'?",
        questionTranslation: "How do you say 'I am a computer science student'?",
        options: ["Sono uno studente di informatica", "Studio legge", "Cerco lavoro", "Vado all'università"],
        optionTranslations: ["I am a computer science student", "I study law", "I am looking for work", "I go to university"],
        correctAnswerIndex: 0,
        pronunciation: "SO-no U-no stu-DEN-te di in-for-MA-ti-ca",
        explanation: "Use this phrase to introduce your field of study.",
        explanationTranslation: "Use this phrase to introduce your field of study.",
        audioPhrase: "Sono uno studente di informatica",
      ),
      const Question(
        id: 2,
        questionType: "University - Office",
        questionTypeTranslation: "University - Office",
        questionText: "What is the 'Segreteria Studenti'?",
        questionTranslation: "What is the 'Segreteria Studenti'?",
        options: ["Student Cafeteria", "Student Office/Registrar", "Library", "Gym"],
        optionTranslations: ["Mensa", "Segreteria Studenti", "Biblioteca", "Palestra"],
        correctAnswerIndex: 1,
        pronunciation: "se-gre-te-RI-a stu-DEN-ti",
        explanation: "The Segreteria is where you handle administrative tasks like enrollment.",
        explanationTranslation: "The Segreteria is where you handle administrative tasks like enrollment.",
        audioPhrase: "la segreteria studenti",
      ),
      const Question(
        id: 3,
        questionType: "University - ID",
        questionTypeTranslation: "University - ID",
        questionText: "What does 'numero di matricola' mean?",
        questionTranslation: "What does 'numero di matricola' mean?",
        options: ["Phone number", "Student ID number", "Course number", "Room number"],
        optionTranslations: ["Numero di telefono", "Numero di matricola", "Numero del corso", "Numero della stanza"],
        correctAnswerIndex: 1,
        pronunciation: "NU-me-ro di ma-TRI-co-la",
        explanation: "This is your unique identification number at the university.",
        explanationTranslation: "This is your unique identification number at the university.",
        audioPhrase: "il numero di matricola",
      ),
      const Question(
        id: 4,
        questionType: "University - Classes",
        questionTypeTranslation: "University - Classes",
        questionText: "How do you ask 'When do classes start?'",
        questionTranslation: "How do you ask 'When do classes start?'",
        options: ["Quando finiscono le lezioni?", "Quando iniziano le lezioni?", "Dove sono le lezioni?", "Chi insegna?"],
        optionTranslations: ["When do classes end?", "When do classes start?", "Where are the classes?", "Who teaches?"],
        correctAnswerIndex: 1,
        pronunciation: "KWAN-do i-NI-zia-no le le-ZIO-ni",
        explanation: "Useful for planning your academic calendar.",
        explanationTranslation: "Useful for planning your academic calendar.",
        audioPhrase: "Quando iniziano le lezioni?",
      ),

      // --- Bureaucracy & Visa ---
      const Question(
        id: 5,
        questionType: "Bureaucracy - Permit",
        questionTypeTranslation: "Bureaucracy - Permit",
        questionText: "What is the 'Permesso di soggiorno'?",
        questionTranslation: "What is the 'Permesso di soggiorno'?",
        options: ["Driving license", "Residence permit", "Library card", "Travel visa"],
        optionTranslations: ["Patente", "Permesso di soggiorno", "Tessera della biblioteca", "Visto turistico"],
        correctAnswerIndex: 1,
        pronunciation: "per-MES-so di sog-GIOR-no",
        explanation: "The essential document for staying in Italy longer than 3 months.",
        explanationTranslation: "The essential document for staying in Italy longer than 3 months.",
        audioPhrase: "il permesso di soggiorno",
      ),
      const Question(
        id: 6,
        questionType: "Bureaucracy - Tax Code",
        questionTypeTranslation: "Bureaucracy - Tax Code",
        questionText: "What is the 'Codice Fiscale'?",
        questionTranslation: "What is the 'Codice Fiscale'?",
        options: ["Tax code", "Zip code", "Student code", "Bank code"],
        optionTranslations: ["Codice Fiscale", "CAP", "Codice studente", "Codice bancario"],
        correctAnswerIndex: 0,
        pronunciation: "CO-di-ce fis-CA-le",
        explanation: "You need this alphanumeric code for everything from renting a flat to opening a bank account.",
        explanationTranslation: "You need this alphanumeric code for everything from renting a flat to opening a bank account.",
        audioPhrase: "il codice fiscale",
      ),
      const Question(
        id: 7,
        questionType: "Bureaucracy - Appointment",
        questionTypeTranslation: "Bureaucracy - Appointment",
        questionText: "How do you say 'I need to make an appointment'?",
        questionTranslation: "How do you say 'I need to make an appointment'?",
        options: ["Devo fare una domanda", "Devo prendere un appuntamento", "Voglio andare via", "Cerco un ufficio"],
        optionTranslations: ["I need to apply", "I need to make an appointment", "I want to leave", "I'm looking for an office"],
        correctAnswerIndex: 1,
        pronunciation: "DE-vo PREN-de-re un ap-pun-ta-MEN-to",
        explanation: "Essential for visiting the Questura or other offices.",
        explanationTranslation: "Essential for visiting the Questura or other offices.",
        audioPhrase: "Devo prendere un appuntamento",
      ),

      // --- Job Search & Work ---
      const Question(
        id: 8,
        questionType: "Work - Job Search",
        questionTypeTranslation: "Work - Job Search",
        questionText: "How do you say 'I am looking for a part-time job'?",
        questionTranslation: "How do you say 'I am looking for a part-time job'?",
        options: ["Cerco un lavoro part-time", "Cerco un lavoro a tempo pieno", "Non voglio lavorare", "Studio solo"],
        optionTranslations: ["I am looking for a part-time job", "I am looking for a full-time job", "I don't want to work", "I only study"],
        correctAnswerIndex: 0,
        pronunciation: "CER-co un la-VO-ro part-time",
        explanation: "Common for students balancing work and study.",
        explanationTranslation: "Common for students balancing work and study.",
        audioPhrase: "Cerco un lavoro part-time",
      ),
      const Question(
        id: 9,
        questionType: "Work - Resume",
        questionTypeTranslation: "Work - Resume",
        questionText: "What is a 'Curriculum Vitae'?",
        questionTranslation: "What is a 'Curriculum Vitae'?",
        options: ["Job contract", "Resume/CV", "Cover letter", "Interview"],
        optionTranslations: ["Contratto", "Curriculum Vitae", "Lettera di presentazione", "Colloquio"],
        correctAnswerIndex: 1,
        pronunciation: "cur-RI-cu-lum VI-tae",
        explanation: "The document outlining your skills and experience.",
        explanationTranslation: "The document outlining your skills and experience.",
        audioPhrase: "il curriculum vitae",
      ),
      const Question(
        id: 10,
        questionType: "Work - Interview",
        questionTypeTranslation: "Work - Interview",
        questionText: "What does 'il colloquio di lavoro' mean?",
        questionTranslation: "What does 'il colloquio di lavoro' mean?",
        options: ["Job offer", "Job interview", "Dismissal", "Promotion"],
        optionTranslations: ["Offerta di lavoro", "Colloquio di lavoro", "Licenziamento", "Promozione"],
        correctAnswerIndex: 1,
        pronunciation: "il col-LO-quio di la-VO-ro",
        explanation: "The meeting where you are evaluated for a job.",
        explanationTranslation: "The meeting where you are evaluated for a job.",
        audioPhrase: "il colloquio di lavoro",
      ),
      const Question(
        id: 11,
        questionType: "Work - Internship",
        questionTypeTranslation: "Work - Internship",
        questionText: "What is a 'tirocinio' or 'stage'?",
        questionTranslation: "What is a 'tirocinio' or 'stage'?",
        options: ["Internship", "Full-time job", "Holiday", "Exam"],
        optionTranslations: ["Tirocinio", "Lavoro a tempo pieno", "Vacanza", "Esame"],
        correctAnswerIndex: 0,
        pronunciation: "ti-ro-CI-nio",
        explanation: "Work experience often required by universities.",
        explanationTranslation: "Work experience often required by universities.",
        audioPhrase: "il tirocinio",
      ),

      // --- Housing & Daily Life ---
      const Question(
        id: 12,
        questionType: "Housing - Room",
        questionTypeTranslation: "Housing - Room",
        questionText: "How do you say 'I am looking for a single room'?",
        questionTranslation: "How do you say 'I am looking for a single room'?",
        options: ["Cerco una camera singola", "Cerco una camera doppia", "Cerco un appartamento", "Cerco un hotel"],
        optionTranslations: ["I am looking for a single room", "I am looking for a double room", "I am looking for an apartment", "I am looking for a hotel"],
        correctAnswerIndex: 0,
        pronunciation: "CER-co U-na CA-me-ra SIN-go-la",
        explanation: "Useful when searching for student accommodation.",
        explanationTranslation: "Useful when searching for student accommodation.",
        audioPhrase: "Cerco una camera singola",
      ),
      const Question(
        id: 13,
        questionType: "Housing - Rent",
        questionTypeTranslation: "Housing - Rent",
        questionText: "What does 'l\u2019affitto' mean?",
        questionTranslation: "What does 'l\u2019affitto' mean?",
        options: ["The sale", "The rent", "The bills", "The deposit"],
        optionTranslations: ["La vendita", "L'affitto", "Le bollette", "La caparra"],
        correctAnswerIndex: 1,
        pronunciation: "laf-FIT-to",
        explanation: "The monthly payment for your accommodation.",
        explanationTranslation: "The monthly payment for your accommodation.",
        audioPhrase: "l'affitto",
      ),
      const Question(
        id: 14,
        questionType: "Life - Bank",
        questionTypeTranslation: "Life - Bank",
        questionText: "How do you say 'I want to open a bank account'?",
        questionTranslation: "How do you say 'I want to open a bank account'?",
        options: ["Voglio chiudere il conto", "Voglio aprire un conto bancario", "Ho bisogno di soldi", "Dov'è la banca?"],
        optionTranslations: ["I want to close the account", "I want to open a bank account", "I need money", "Where is the bank?"],
        correctAnswerIndex: 1,
        pronunciation: "VO-glio a-PRI-re un CON-to ban-CA-rio",
        explanation: "Necessary for receiving your scholarship or salary.",
        explanationTranslation: "Necessary for receiving your scholarship or salary.",
        audioPhrase: "Voglio aprire un conto bancario",
      ),
      const Question(
        id: 15,
        questionType: "Life - SIM Card",
        questionTypeTranslation: "Life - SIM Card",
        questionText: "How do you ask for a SIM card?",
        questionTranslation: "How do you ask for a SIM card?",
        options: ["Vorrei una scheda SIM", "Vorrei un telefono", "Vorrei internet", "Vorrei chiamare"],
        optionTranslations: ["I would like a SIM card", "I would like a phone", "I would like internet", "I would like to call"],
        correctAnswerIndex: 0,
        pronunciation: "vor-REI U-na SKE-da SIM",
        explanation: "Getting a local number is one of the first things to do.",
        explanationTranslation: "Getting a local number is one of the first things to do.",
        audioPhrase: "Vorrei una scheda SIM",
      ),

      // --- Social & Networking ---
      const Question(
        id: 16,
        questionType: "Social - Meeting",
        questionTypeTranslation: "Social - Meeting",
        questionText: "How do you ask 'Are there events for international students?'",
        questionTranslation: "How do you ask 'Are there events for international students?'",
        options: ["Ci sono eventi per studenti internazionali?", "Dove sono gli studenti?", "Quando è la festa?", "Chi è internazionale?"],
        optionTranslations: ["Are there events for international students?", "Where are the students?", "When is the party?", "Who is international?"],
        correctAnswerIndex: 0,
        pronunciation: "ci SO-no e-VEN-ti per stu-DEN-ti in-ter-na-zio-NA-li",
        explanation: "Good for networking and making friends.",
        explanationTranslation: "Good for networking and making friends.",
        audioPhrase: "Ci sono eventi per studenti internazionali?",
      ),
      const Question(
        id: 17,
        questionType: "Social - Language",
        questionTypeTranslation: "Social - Language",
        questionText: "How do you say 'I don\u2019t speak Italian very well'?",
        questionTranslation: "How do you say 'I don\u2019t speak Italian very well'?",
        options: ["Parlo bene italiano", "Non parlo molto bene l'italiano", "Sono italiano", "Capisco tutto"],
        optionTranslations: ["I speak Italian well", "I don't speak Italian very well", "I am Italian", "I understand everything"],
        correctAnswerIndex: 1,
        pronunciation: "non PAR-lo MOL-to BE-ne li-ta-LIA-no",
        explanation: "A useful phrase to manage expectations when learning.",
        explanationTranslation: "A useful phrase to manage expectations when learning.",
        audioPhrase: "Non parlo molto bene l'italiano",
      ),
      const Question(
        id: 18,
        questionType: "University - Scholarship",
        questionTypeTranslation: "University - Scholarship",
        questionText: "What is a 'Borsa di studio'?",
        questionTranslation: "What is a 'Borsa di studio'?",
        options: ["Study bag", "Scholarship", "Tuition fee", "Exam result"],
        optionTranslations: ["Borsa", "Borsa di studio", "Tassa universitaria", "Risultato esame"],
        correctAnswerIndex: 1,
        pronunciation: "BOR-sa di STU-dio",
        explanation: "Financial aid to help with your studies.",
        explanationTranslation: "Financial aid to help with your studies.",
        audioPhrase: "la borsa di studio",
      ),
      const Question(
        id: 19,
        questionType: "Life - Health",
        questionTypeTranslation: "Life - Health",
        questionText: "What is the 'Tessera Sanitaria'?",
        questionTranslation: "What is the 'Tessera Sanitaria'?",
        options: ["Health insurance card", "Travel card", "Identity card", "Credit card"],
        optionTranslations: ["Tessera sanitaria", "Abbonamento mezzi", "Carta d'identità", "Carta di credito"],
        correctAnswerIndex: 0,
        pronunciation: "TES-se-ra sa-ni-TA-ria",
        explanation: "Your national health service card for accessing doctors.",
        explanationTranslation: "Your national health service card for accessing doctors.",
        audioPhrase: "la tessera sanitaria",
      ),
      const Question(
        id: 20,
        questionType: "Work - Contract",
        questionTypeTranslation: "Work - Contract",
        questionText: "How do you ask 'What type of contract is it?'",
        questionTranslation: "How do you ask 'What type of contract is it?'",
        options: ["Quanto mi paghi?", "Che tipo di contratto è?", "Quando inizio?", "Dove firmo?"],
        optionTranslations: ["How much do you pay me?", "What type of contract is it?", "When do I start?", "Where do I sign?"],
        correctAnswerIndex: 1,
        pronunciation: "ke TI-po di con-TRAT-to è",
        explanation: "Important to know if it's temporary, permanent, or an apprenticeship.",
        explanationTranslation: "Important to know if it's temporary, permanent, or an apprenticeship.",
        audioPhrase: "Che tipo di contratto è?",
      ),
    ];
  }

  // Backward compatibility
  List<Question> getQuestions() {
    return getItalianQuestions();
  }
}
