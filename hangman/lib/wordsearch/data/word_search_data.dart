import 'package:flutter/material.dart';
import '../models/word_search_level.dart';
import '../models/word_search_subject.dart';

class WordSearchData {
  static final List<WordSearchSubject> easySubjects = [
    WordSearchSubject(
      id: 'ws_animals',
      name: 'Animals',
      icon: '🐾',
      color: Colors.green,
      levels: [
        WordSearchLevel(id: 1, name: 'Animals 1', description: 'Common pets', gridSize: 6, wordCount: 4, words: ['CAT', 'DOG', 'FISH', 'BIRD']),
        WordSearchLevel(id: 2, name: 'Animals 2', description: 'Wild animals', gridSize: 7, wordCount: 4, words: ['LION', 'TIGER', 'BEAR', 'WOLF']),
        WordSearchLevel(id: 3, name: 'Animals 3', description: 'Farm animals', gridSize: 7, wordCount: 4, words: ['HORSE', 'SHEEP', 'GOAT', 'CAMEL']),
        WordSearchLevel(id: 4, name: 'Animals 4', description: 'Sea creatures', gridSize: 8, wordCount: 4, words: ['SHARK', 'WHALE', 'OTTER', 'SEAL']),
        WordSearchLevel(id: 5, name: 'Animals 5', description: 'Exotic animals', gridSize: 8, wordCount: 4, words: ['PANDA', 'KOALA', 'MONKEY', 'RABBIT']),
      ],
    ),
    WordSearchSubject(
      id: 'ws_colors',
      name: 'Colors',
      icon: '🌈',
      color: Colors.blue,
      levels: [
        WordSearchLevel(id: 1, name: 'Colors 1', description: 'Basic colors', gridSize: 6, wordCount: 4, words: ['RED', 'BLUE', 'GREEN', 'YELLOW']),
        WordSearchLevel(id: 2, name: 'Colors 2', description: 'More colors', gridSize: 7, wordCount: 4, words: ['PURPLE', 'ORANGE', 'PINK', 'BLACK']),
        WordSearchLevel(id: 3, name: 'Colors 3', description: 'Soft colors', gridSize: 7, wordCount: 4, words: ['WHITE', 'BROWN', 'GREY', 'SILVER']),
        WordSearchLevel(id: 4, name: 'Colors 4', description: 'Bright colors', gridSize: 8, wordCount: 4, words: ['GOLD', 'CYAN', 'LIME', 'NAVY']),
        WordSearchLevel(id: 5, name: 'Colors 5', description: 'Dark colors', gridSize: 8, wordCount: 4, words: ['MAROON', 'OLIVE', 'TEAL', 'VIOLET']),
      ],
    ),
    WordSearchSubject(
      id: 'ws_fruits',
      name: 'Fruits',
      icon: '🍎',
      color: Colors.redAccent,
      levels: [
        WordSearchLevel(id: 1, name: 'Fruits 1', description: 'Common fruits', gridSize: 6, wordCount: 4, words: ['APPLE', 'BANANA', 'MANGO', 'GRAPE']),
        WordSearchLevel(id: 2, name: 'Fruits 2', description: 'Sweet fruits', gridSize: 7, wordCount: 4, words: ['PEACH', 'BERRY', 'LEMON', 'ORANGE']),
        WordSearchLevel(id: 3, name: 'Fruits 3', description: 'Juicy fruits', gridSize: 7, wordCount: 4, words: ['MELON', 'CHERRY', 'PLUM', 'KIWI']),
        WordSearchLevel(id: 4, name: 'Fruits 4', description: 'Small fruits', gridSize: 8, wordCount: 4, words: ['FIG', 'DATE', 'LIME', 'PEAR']),
        WordSearchLevel(id: 5, name: 'Fruits 5', description: 'Tropical fruits', gridSize: 8, wordCount: 4, words: ['GUAVA', 'PAPAYA', 'COCONUT', 'APRICOT']),
      ],
    ),
    WordSearchSubject(
      id: 'ws_vehicles',
      name: 'Vehicles',
      icon: '🚗',
      color: Colors.orange,
      levels: [
        WordSearchLevel(id: 1, name: 'Vehicles 1', description: 'On the road', gridSize: 6, wordCount: 4, words: ['CAR', 'BUS', 'TRAIN', 'PLANE']),
        WordSearchLevel(id: 2, name: 'Vehicles 2', description: 'On the water', gridSize: 7, wordCount: 4, words: ['BOAT', 'BIKE', 'TRUCK', 'SHIP']),
        WordSearchLevel(id: 3, name: 'Vehicles 3', description: 'Around town', gridSize: 7, wordCount: 4, words: ['TAXI', 'JEEP', 'VAN', 'SUBWAY']),
        WordSearchLevel(id: 4, name: 'Vehicles 4', description: 'Fast travel', gridSize: 8, wordCount: 4, words: ['ROCKET', 'SCOOTER', 'TRAM', 'GLIDER']),
        WordSearchLevel(id: 5, name: 'Vehicles 5', description: 'Heavy vehicles', gridSize: 9, wordCount: 4, words: ['AMBULANCE', 'TRACTOR', 'BICYCLE', 'HELICOPTER']),
      ],
    ),
    WordSearchSubject(
      id: 'ws_weather',
      name: 'Weather',
      icon: '☁️',
      color: Colors.cyan,
      levels: [
        WordSearchLevel(id: 1, name: 'Weather 1', description: 'Sky conditions', gridSize: 6, wordCount: 4, words: ['SUN', 'RAIN', 'SNOW', 'WIND']),
        WordSearchLevel(id: 2, name: 'Weather 2', description: 'Stormy weather', gridSize: 7, wordCount: 4, words: ['CLOUD', 'STORM', 'FOG', 'HAIL']),
        WordSearchLevel(id: 3, name: 'Weather 3', description: 'Air quality', gridSize: 7, wordCount: 4, words: ['HEAT', 'COLD', 'MIST', 'DEW']),
        WordSearchLevel(id: 4, name: 'Weather 4', description: 'Sky events', gridSize: 8, wordCount: 4, words: ['THUNDER', 'LIGHTNING', 'BREEZE', 'GALE']),
        WordSearchLevel(id: 5, name: 'Weather 5', description: 'Extreme weather', gridSize: 9, wordCount: 4, words: ['TORNADO', 'HURRICANE', 'RAINBOW', 'CYCLONE']),
      ],
    ),
  ];

  static final List<WordSearchSubject> mediumSubjects = [
    WordSearchSubject(
      id: 'ws_antonyms',
      name: 'Antonyms',
      icon: '↔️',
      color: Colors.purple,
      levels: [
        WordSearchLevel(id: 1, name: 'Antonyms 1', description: 'Opposite words', gridSize: 8, wordCount: 6, words: ['HOT', 'COLD', 'BIG', 'SMALL', 'FAST', 'SLOW']),
        WordSearchLevel(id: 2, name: 'Antonyms 2', description: 'Directions', gridSize: 9, wordCount: 6, words: ['UP', 'DOWN', 'LEFT', 'RIGHT', 'GOOD', 'BAD']),
        WordSearchLevel(id: 3, name: 'Antonyms 3', description: 'Emotions', gridSize: 10, wordCount: 6, words: ['HAPPY', 'SAD', 'RICH', 'POOR', 'NEW', 'OLD']),
        WordSearchLevel(id: 4, name: 'Antonyms 4', description: 'Qualities', gridSize: 10, wordCount: 6, words: ['DARK', 'LIGHT', 'HARD', 'SOFT', 'TRUE', 'FALSE']),
        WordSearchLevel(id: 5, name: 'Antonyms 5', description: 'Advanced', gridSize: 11, wordCount: 6, words: ['ALWAYS', 'NEVER', 'FIRST', 'LAST', 'SMART', 'DUMB']),
      ],
    ),
    WordSearchSubject(
      id: 'ws_synonyms',
      name: 'Synonyms',
      icon: '🔄',
      color: Colors.teal,
      levels: [
        WordSearchLevel(id: 1, name: 'Synonyms 1', description: 'Similar words', gridSize: 8, wordCount: 6, words: ['BIG', 'LARGE', 'SMALL', 'TINY', 'FAST', 'QUICK']),
        WordSearchLevel(id: 2, name: 'Synonyms 2', description: 'Feelings', gridSize: 9, wordCount: 6, words: ['GLAD', 'HAPPY', 'SAD', 'UNHAPPY', 'MAD', 'ANGRY']),
        WordSearchLevel(id: 3, name: 'Synonyms 3', description: 'Actions', gridSize: 10, wordCount: 6, words: ['START', 'BEGIN', 'END', 'FINISH', 'HARD', 'DIFFICULT']),
        WordSearchLevel(id: 4, name: 'Synonyms 4', description: 'Traits', gridSize: 10, wordCount: 6, words: ['SMART', 'CLEVER', 'BRAVE', 'BOLD', 'KIND', 'NICE']),
        WordSearchLevel(id: 5, name: 'Synonyms 5', description: 'States', gridSize: 11, wordCount: 6, words: ['RICH', 'WEALTHY', 'POOR', 'NEEDY', 'LOUD', 'NOISY']),
      ],
    ),
    WordSearchSubject(
      id: 'ws_inventions',
      name: 'Inventions',
      icon: '💡',
      color: Colors.deepOrange,
      levels: [
        WordSearchLevel(id: 1, name: 'Inventions 1', description: 'Early tools', gridSize: 8, wordCount: 4, words: ['WHEEL', 'LIGHT', 'PHONE', 'STEAM']),
        WordSearchLevel(id: 2, name: 'Inventions 2', description: 'Media', gridSize: 9, wordCount: 4, words: ['RADIO', 'PLANE', 'MOTOR', 'PRINT']),
        WordSearchLevel(id: 3, name: 'Inventions 3', description: 'Optical', gridSize: 10, wordCount: 4, words: ['CAMERA', 'WATCH', 'GLASS', 'PAPER']),
        WordSearchLevel(id: 4, name: 'Inventions 4', description: 'Engineering', gridSize: 10, wordCount: 4, words: ['ENGINE', 'COMPASS', 'LASER', 'RADAR']),
        WordSearchLevel(id: 5, name: 'Inventions 5', description: 'Modern era', gridSize: 11, wordCount: 4, words: ['INTERNET', 'COMPUTER', 'PLASTIC', 'ROCKET']),
      ],
    ),
  ];

  static List<WordSearchSubject> getAllSubjects() {
    return [...easySubjects, ...mediumSubjects];
  }
}
