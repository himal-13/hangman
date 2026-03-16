import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectsData {
  static List<Subject> subjects = [
    Subject(
      id: 'animals',
      name: 'Animals',
      icon: '🐾',
      words: ['ELEPHANT', 'TIGER', 'GIRAFFE', 'DOLPHIN', 'KANGAROO', 'ZEBRA', 'RHINOCEROS', 'CROCODILE'],
      color: Colors.orange,
    ),
    Subject(
      id: 'fruits',
      name: 'Fruits',
      icon: '🍎',
      words: ['APPLE', 'BANANA', 'ORANGE', 'STRAWBERRY', 'MANGO', 'PINEAPPLE', 'WATERMELON', 'GRAPES'],
      color: Colors.red,
    ),
    Subject(
      id: 'countries',
      name: 'Countries',
      icon: '🌍',
      words: ['CANADA', 'BRAZIL', 'JAPAN', 'FRANCE', 'AUSTRALIA', 'INDIA', 'EGYPT', 'MEXICO'],
      color: Colors.blue,
    ),
    Subject(
      id: 'sports',
      name: 'Sports',
      icon: '⚽',
      words: ['FOOTBALL', 'BASKETBALL', 'TENNIS', 'SWIMMING', 'CRICKET', 'VOLLEYBALL', 'HOCKEY', 'GOLF'],
      color: Colors.green,
    ),
    Subject(
      id: 'movies',
      name: 'Movies',
      icon: '🎬',
      words: ['TITANIC', 'AVATAR', 'INCEPTION', 'GLADIATOR', 'FROZEN', 'JUMANJI', 'CASABLANCA', 'ROCKY'],
      color: Colors.purple,
    ),
    Subject(
      id: 'technology',
      name: 'Technology',
      icon: '💻',
      words: ['COMPUTER', 'INTERNET', 'SOFTWARE', 'HARDWARE', 'PROGRAMMING', 'DATABASE', 'NETWORK', 'ALGORITHM'],
      color: Colors.teal,
    ),
  ];

  static Subject getSubjectById(String id) {
    return subjects.firstWhere((subject) => subject.id == id);
  }
}