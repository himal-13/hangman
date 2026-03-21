import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectsData {
  // Easy Mode Subjects - Simple, common words (6 subjects)
  static List<Subject> easySubjects = [
    Subject(
      id: 'animals',
      name: 'Animals',
      icon: '🐾',
      words: ['CAT', 'DOG', 'FISH', 'BIRD', 'FROG', 'DUCK', 'BEAR', 'LION'],
      color: Colors.green,
    ),
    Subject(
      id: 'fruits',
      name: 'Fruits',
      icon: '🍎',
      words: ['APPLE', 'BANANA', 'ORANGE', 'MANGO', 'GRAPE', 'LEMON', 'PEAR', 'KIWI'],
      color: Colors.lightGreen,
    ),
    Subject(
      id: 'colors',
      name: 'Colors',
      icon: '🎨',
      words: ['RED', 'BLUE', 'GREEN', 'YELLOW', 'PURPLE', 'PINK', 'BROWN', 'BLACK'],
      color: Colors.teal,
    ),
    Subject(
      id: 'numbers',
      name: 'Numbers',
      icon: '🔢',
      words: ['ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT'],
      color: Colors.cyan,
    ),
    Subject(
      id: 'toys',
      name: 'Toys',
      icon: '🧸',
      words: ['BALL', 'DOLL', 'CAR', 'TRAIN', 'BLOCK', 'PUZZLE', 'KITE', 'ROBOT'],
      color: Colors.lime,
    ),
    Subject(
      id: 'weather',
      name: 'Weather',
      icon: '☀️',
      words: ['SUN', 'RAIN', 'SNOW', 'WIND', 'CLOUD', 'STORM', 'FOG', 'HAIL'],
      color: Colors.blue,
    ),
  ];

  // Medium Mode Subjects - Longer words, common categories (6 subjects)
  static List<Subject> mediumSubjects = [
    Subject(
      id: 'countries',
      name: 'Countries',
      icon: '🌍',
      words: ['CANADA', 'BRAZIL', 'JAPAN', 'FRANCE', 'INDIA', 'EGYPT', 'MEXICO', 'CHINA'],
      color: Colors.orange,
    ),
    Subject(
      id: 'sports',
      name: 'Sports',
      icon: '⚽',
      words: ['SOCCER', 'TENNIS', 'HOCKEY', 'CRICKET', 'GOLF', 'RUGBY', 'BOXING', 'RACING'],
      color: Colors.deepOrange,
    ),
    Subject(
      id: 'professions',
      name: 'Jobs',
      icon: '👨‍💼',
      words: ['DOCTOR', 'TEACHER', 'PILOT', 'CHEF', 'ARTIST', 'JUDGE', 'ACTOR', 'NURSE'],
      color: Colors.amber,
    ),
    Subject(
      id: 'transport',
      name: 'Vehicles',
      icon: '🚗',
      words: ['CAR', 'BUS', 'TRAIN', 'SHIP', 'BIKE', 'PLANE', 'TRUCK', 'BOAT'],
      color: Colors.brown,
    ),
    Subject(
      id: 'instruments',
      name: 'Music',
      icon: '🎵',
      words: ['GUITAR', 'PIANO', 'DRUMS', 'VIOLIN', 'FLUTE', 'TRUMPET', 'HARP', 'CELLO'],
      color: Colors.pink,
    ),
    Subject(
      id: 'food',
      name: 'Food',
      icon: '🍕',
      words: ['PIZZA', 'BURGER', 'PASTA', 'SUSHI', 'SALAD', 'STEAK', 'SOUP', 'BREAD'],
      color: Colors.redAccent,
    ),
  ];

  // Hard Mode Subjects - Complex words, specific categories (6 subjects)
  static List<Subject> hardSubjects = [
    Subject(
      id: 'movies',
      name: 'Movies',
      icon: '🎬',
      words: ['TITANIC', 'AVATAR', 'INCEPTION', 'GLADIATOR', 'FROZEN', 'JUMANJI', 'CASABLANCA', 'ROCKY'],
      color: Colors.red,
    ),
    Subject(
      id: 'technology',
      name: 'Tech',
      icon: '💻',
      words: ['COMPUTER', 'INTERNET', 'SOFTWARE', 'HARDWARE', 'PROGRAMMING', 'DATABASE', 'NETWORK', 'ALGORITHM'],
      color: Colors.purple,
    ),
    Subject(
      id: 'science',
      name: 'Science',
      icon: '🔬',
      words: ['PHYSICS', 'CHEMISTRY', 'BIOLOGY', 'ASTRONOMY', 'MOLECULE', 'ATOM', 'GRAVITY', 'ENERGY'],
      color: Colors.indigo,
    ),
    Subject(
      id: 'ancient',
      name: 'Ancient',
      icon: '🏛️',
      words: ['PYRAMID', 'PHARAOH', 'GLADIATOR', 'COLOSSEUM', 'MUMMY', 'TEMPLE', 'SCROLL', 'EMPIRE'],
      color: Colors.brown.shade700,
    ),
    Subject(
      id: 'space',
      name: 'Space',
      icon: '🚀',
      words: ['PLANET', 'STAR', 'GALAXY', 'COMET', 'ASTEROID', 'TELESCOPE', 'SATELLITE', 'ORBIT'],
      color: Colors.deepPurple,
    ),
    Subject(
      id: 'mythology',
      name: 'Mythology',
      icon: '⚡',
      words: ['ZEUS', 'THOR', 'ATHENA', 'ODIN', 'HERA', 'APOLLO', 'ARES', 'LOKI'],
      color: Colors.amber.shade800,
    ),
  ];

  // Sentence Mode Data
  static List<Subject> sentenceSubjects = [
    Subject(
      id: 'proverbs',
      name: 'Proverbs',
      icon: '📖',
      words: ['PRACTICE MAKES PERFECT', 'KNOWLEDGE IS POWER', 'TIME IS MONEY', 'HONESTY IS THE BEST POLICY'],
      color: Colors.indigo,
    ),
    Subject(
      id: 'quotes',
      name: 'Famous Quotes',
      icon: '💬',
      words: ['BE THE CHANGE', 'STAY HUNGRY STAY FOOLISH', 'I THINK THEREFORE I AM', 'TO BE OR NOT TO BE'],
      color: Colors.deepPurple,
    ),
    Subject(
      id: 'common_phrases',
      name: 'Common Phrases',
      icon: '🗣️',
      words: ['PIECE OF CAKE', 'BREAK A LEG', 'BETTER LATE THAN NEVER', 'ONCE IN A BLUE MOON'],
      color: Colors.blueGrey,
    ),
  ];

  // Helper method to get all subjects (if needed)
  static List<Subject> getAllSubjects() {
    return [...easySubjects, ...mediumSubjects, ...hardSubjects, ...sentenceSubjects];
  }

  static Subject getSubjectById(String id) {
    try {
      return getAllSubjects().firstWhere((subject) => subject.id == id);
    } catch (e) {
      return easySubjects.first;
    }
  }

  // Helper to get difficulty level of a subject
  static String getDifficultyLevel(String subjectId) {
    if (easySubjects.any((s) => s.id == subjectId)) return 'Easy';
    if (mediumSubjects.any((s) => s.id == subjectId)) return 'Medium';
    if (hardSubjects.any((s) => s.id == subjectId)) return 'Hard';
    return 'Unknown';
  }

  // Helper to get color for difficulty
  static Color getDifficultyColor(String subjectId) {
    if (easySubjects.any((s) => s.id == subjectId)) return Colors.green;
    if (mediumSubjects.any((s) => s.id == subjectId)) return Colors.orange;
    if (hardSubjects.any((s) => s.id == subjectId)) return Colors.red;
    return Colors.grey;
  }
}