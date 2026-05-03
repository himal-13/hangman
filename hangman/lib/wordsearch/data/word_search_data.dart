import 'package:flutter/material.dart';
import '../models/word_search_level.dart';
import '../models/word_search_subject.dart';

class WordSearchData {
  // GENERAL MODE - Daily life words (Easy)
  static final List<WordSearchSubject> easySubjects = [
    const WordSearchSubject(
      id: 'ws_general',
      name: 'General Mode',
      icon: '📖',
      color: Colors.green,
      levels: [
        WordSearchLevel(id: 1, name: 'Level 1', description: 'Basic objects', gridSize: 6, wordCount: 4, words: ['BOOK', 'PEN', 'TABLE', 'CHAIR']),
        WordSearchLevel(id: 2, name: 'Level 2', description: 'Food items', gridSize: 6, wordCount: 4, words: ['BREAD', 'MILK', 'EGG', 'RICE']),
        WordSearchLevel(id: 3, name: 'Level 3', description: 'Family members', gridSize: 7, wordCount: 4, words: ['MOTHER', 'FATHER', 'SISTER', 'BROTHER']),
        WordSearchLevel(id: 4, name: 'Level 4', description: 'Home appliances', gridSize: 7, wordCount: 4, words: ['TV', 'FRIDGE', 'FAN', 'LAMP']),
        WordSearchLevel(id: 5, name: 'Level 5', description: 'Clothing', gridSize: 7, wordCount: 4, words: ['SHIRT', 'PANTS', 'SOCKS', 'HAT']),
        WordSearchLevel(id: 6, name: 'Level 6', description: 'School items', gridSize: 8, wordCount: 4, words: ['NOTEBOOK', 'RULER', 'ERASER', 'BAG']), // Fixed: 7 -> 8
        WordSearchLevel(id: 7, name: 'Level 7', description: 'Body parts', gridSize: 7, wordCount: 4, words: ['HAND', 'FOOT', 'EYE', 'NOSE']),
        WordSearchLevel(id: 8, name: 'Level 8', description: 'Daily actions', gridSize: 7, wordCount: 4, words: ['EAT', 'SLEEP', 'WALK', 'READ']),
        WordSearchLevel(id: 9, name: 'Level 9', description: 'Places', gridSize: 8, wordCount: 4, words: ['SCHOOL', 'HOSPITAL', 'PARK', 'BANK']),
        WordSearchLevel(id: 10, name: 'Level 10', description: 'Feelings', gridSize: 8, wordCount: 4, words: ['HAPPY', 'SAD', 'ANGRY', 'TIRED']),
        WordSearchLevel(id: 11, name: 'Level 11', description: 'Nature', gridSize: 8, wordCount: 4, words: ['TREE', 'FLOWER', 'GRASS', 'RIVER']),
        WordSearchLevel(id: 12, name: 'Level 12', description: 'Time words', gridSize: 8, wordCount: 4, words: ['DAY', 'NIGHT', 'WEEK', 'MONTH']),
        WordSearchLevel(id: 13, name: 'Level 13', description: 'Kitchen items', gridSize: 8, wordCount: 4, words: ['CUP', 'PLATE', 'FORK', 'KNIFE']),
        WordSearchLevel(id: 14, name: 'Level 14', description: 'Workplace', gridSize: 8, wordCount: 4, words: ['OFFICE', 'COMPUTER', 'DESK', 'PHONE']),
        WordSearchLevel(id: 15, name: 'Level 15', description: 'Transport', gridSize: 9, wordCount: 4, words: ['CAR', 'BUS', 'BIKE', 'TRAIN']),
      ],
    ),
    const WordSearchSubject(
      id: 'ws_advanced_easy',
      name: 'Advanced Mode',
      icon: '🧠',
      color: Colors.blue,
      levels: [
        WordSearchLevel(id: 1, name: 'Level 1', description: 'Complex objects', gridSize: 8, wordCount: 4, words: ['UMBRELLA', 'BACKPACK', 'MIRROR', 'CALENDAR']), // Fixed: 7 -> 8
        WordSearchLevel(id: 2, name: 'Level 2', description: 'Specific foods', gridSize: 9, wordCount: 4, words: ['SPAGHETTI', 'BROCCOLI', 'PANCAKE', 'SANDWICH']), // Fixed: 7 -> 9
        WordSearchLevel(id: 3, name: 'Level 3', description: 'Nature details', gridSize: 9, wordCount: 4, words: ['MOUNTAIN', 'WATERFALL', 'VOLCANO', 'FOREST']), // Fixed: 8 -> 9
        WordSearchLevel(id: 4, name: 'Level 4', description: 'Abstract nouns', gridSize: 8, wordCount: 4, words: ['FREEDOM', 'JUSTICE', 'SILENCE', 'WISDOM']),
        WordSearchLevel(id: 5, name: 'Level 5', description: 'Science basics', gridSize: 8, wordCount: 4, words: ['GRAVITY', 'ENERGY', 'PLANT', 'ANIMAL']),
        WordSearchLevel(id: 6, name: 'Level 6', description: 'Instruments', gridSize: 9, wordCount: 4, words: ['TRUMPET', 'VIOLIN', 'GUITAR', 'PIANO']),
        WordSearchLevel(id: 7, name: 'Level 7', description: 'Space', gridSize: 9, wordCount: 4, words: ['GALAXY', 'PLANET', 'COMET', 'NEBULA']),
        WordSearchLevel(id: 8, name: 'Level 8', description: 'Architecture', gridSize: 9, wordCount: 4, words: ['COLUMN', 'BRIDGE', 'TOWER', 'PALACE']),
        WordSearchLevel(id: 9, name: 'Level 9', description: 'Technology', gridSize: 10, wordCount: 4, words: ['SOFTWARE', 'HARDWARE', 'NETWORK', 'INTERNET']),
        WordSearchLevel(id: 10, name: 'Level 10', description: 'Environment', gridSize: 10, wordCount: 4, words: ['CLIMATE', 'ECOLOGY', 'RECYCLE', 'POLLUTE']),
      ],
    ),
  ];

  // CITY MODE - Find city names for given countries (Medium)
  static final List<WordSearchSubject> mediumSubjects = [
    const WordSearchSubject(
      id: 'ws_cities',
      name: 'City Mode',
      icon: '🏙️',
      color: Colors.purple,
      levels: [
        WordSearchLevel(
          id: 1, 
          name: 'Level 1', 
          description: 'Famous cities - Find the city name', 
          gridSize: 8, 
          wordCount: 4, 
          words: ['LONDON', 'PARIS', 'TOKYO', 'ROME'],
          clues: {'ENGLAND': 'LONDON', 'FRANCE': 'PARIS', 'JAPAN': 'TOKYO', 'ITALY': 'ROME'},
        ),
        WordSearchLevel(
          id: 2, 
          name: 'Level 2', 
          description: 'Famous cities - Find the city name', 
          gridSize: 8, 
          wordCount: 4, 
          words: ['NEWYORK', 'DUBAI', 'SYDNEY', 'BERLIN'],
          clues: {'USA': 'NEWYORK', 'UAE': 'DUBAI', 'AUSTRALIA': 'SYDNEY', 'GERMANY': 'BERLIN'},
        ),
        WordSearchLevel(
          id: 3, 
          name: 'Level 3', 
          description: 'European cities', 
          gridSize: 9, 
          wordCount: 4, 
          words: ['MADRID', 'VIENNA', 'ATHENS', 'LISBON'],
          clues: {'SPAIN': 'MADRID', 'AUSTRIA': 'VIENNA', 'GREECE': 'ATHENS', 'PORTUGAL': 'LISBON'},
        ),
        WordSearchLevel(
          id: 4, 
          name: 'Level 4', 
          description: 'Asian cities', 
          gridSize: 9, 
          wordCount: 4, 
          words: ['BEIJING', 'DELHI', 'SEOUL', 'BANGKOK'],
          clues: {'CHINA': 'BEIJING', 'INDIA': 'DELHI', 'SOUTHKOREA': 'SEOUL', 'THAILAND': 'BANGKOK'},
        ),
        WordSearchLevel(
          id: 5, 
          name: 'Level 5', 
          description: ' American cities', 
          gridSize: 10, // Fixed: 9 -> 10 (MEXICOCITY has 10 letters)
          wordCount: 4, 
          words: ['TORONTO', 'MEXICOCITY', 'CHICAGO', 'SAOPAULO'],
          clues: {'CANADA': 'TORONTO', 'MEXICO': 'MEXICOCITY', 'USA': 'CHICAGO', 'BRAZIL': 'SAOPAULO'},
        ),
        WordSearchLevel(
          id: 6, 
          name: 'Level 6', 
          description: 'South American cities', 
          gridSize: 11, // Fixed: 10 -> 11 (BUENOSAIRES has 11 letters)
          wordCount: 4, 
          words: ['SAOPAULO', 'BUENOSAIRES', 'LIMA', 'BOGOTA'],
          clues: {'BRAZIL': 'SAOPAULO', 'ARGENTINA': 'BUENOSAIRES', 'PERU': 'LIMA', 'COLOMBIA': 'BOGOTA'},
        ),
        WordSearchLevel(
          id: 7, 
          name: 'Level 7', 
          description: 'African cities', 
          gridSize: 12, // Fixed: 10 -> 12 (JOHANNESBURG has 12 letters)
          wordCount: 4, 
          words: ['CAIRO', 'JOHANNESBURG', 'NAIROBI', 'LAGOS'],
          clues: {'EGYPT': 'CAIRO', 'SOUTHAFRICA': 'JOHANNESBURG', 'KENYA': 'NAIROBI', 'NIGERIA': 'LAGOS'},
        ),
        WordSearchLevel(
          id: 8, 
          name: 'Level 8', 
          description: 'Middle Eastern cities', 
          gridSize: 10, 
          wordCount: 4, 
          words: ['RIYADH', 'TEHRAN', 'ISTANBUL', 'DOHA'],
          clues: {'SAUDIARABIA': 'RIYADH', 'IRAN': 'TEHRAN', 'TURKEY': 'ISTANBUL', 'QATAR': 'DOHA'},
        ),
        WordSearchLevel(
          id: 9, 
          name: 'Level 9', 
          description: 'Coastal cities', 
          gridSize: 10, 
          wordCount: 4, 
          words: ['BARCELONA', 'VENICE', 'MIAMI', 'VANCOUVER'],
          clues: {'SPAIN': 'BARCELONA', 'ITALY': 'VENICE', 'USA': 'MIAMI', 'CANADA': 'VANCOUVER'},
        ),
        WordSearchLevel(
          id: 10, 
          name: 'Level 10', 
          description: 'Historical cities', 
          gridSize: 11,
          wordCount: 4, 
          words: ['JERUSALEM', 'BABYLON', 'LIMA', 'POMPEII'],
          clues: {'ISRAEL': 'JERUSALEM', 'IRAQ': 'BABYLON', 'PERU': 'LIMA', 'ITALY': 'POMPEII'},
        ),
        WordSearchLevel(
          id: 11, 
          name: 'Level 11', 
          description: 'Modern metropolises', 
          gridSize: 11, 
          wordCount: 4, 
          words: ['SINGAPORE', 'SHANGHAI', "TOKYO", 'MUMBAI'],
          clues: {'SINGAPORE': 'SINGAPORE', 'CHINA': 'SHANGHAI', 'JAPAN': 'TOKYO', 'INDIA': 'MUMBAI'},
        ),
        WordSearchLevel(
          id: 12, 
          name: 'Level 12', 
          description: 'Scandinavian cities', 
          gridSize: 11, 
          wordCount: 4, 
          words: ['STOCKHOLM', 'OSLO', 'COPENHAGEN', 'HELSINKI'],
          clues: {'SWEDEN': 'STOCKHOLM', 'NORWAY': 'OSLO', 'DENMARK': 'COPENHAGEN', 'FINLAND': 'HELSINKI'},
        ),
        WordSearchLevel(
          id: 13, 
          name: 'Level 13', 
          description: 'Eastern European cities', 
          gridSize: 11, 
          wordCount: 4, 
          words: ['MOSCOW', 'PRAGUE', 'BUDAPEST', 'WARSAW'],
          clues: {'RUSSIA': 'MOSCOW', 'CZECHIA': 'PRAGUE', 'HUNGARY': 'BUDAPEST', 'POLAND': 'WARSAW'},
        ),
        WordSearchLevel(
          id: 14, 
          name: 'Level 14', 
          description: 'Island cities', 
          gridSize: 11, 
          wordCount: 4, 
          words: ['MANILA', 'JAKARTA', 'COLOMBO', 'PORTLOUIS'],
          clues: {'PHILIPPINES': 'MANILA', 'INDONESIA': 'JAKARTA', 'SRILANKA': 'COLOMBO', 'MAURITIUS': 'PORTLOUIS'},
        ),
        WordSearchLevel(
          id: 15, 
          name: 'Level 15', 
          description: 'Capital cities', 
          gridSize: 12, 
          wordCount: 4, 
          words: ['WASHINGTONDC', 'BRASILIA', 'CANBERRA', 'NEWDELHI'],
          clues: {'USA': 'WASHINGTONDC', 'BRAZIL': 'BRASILIA', 'AUSTRALIA': 'CANBERRA', 'INDIA': 'NEWDELHI'},
        ),
      ],
    ),
    const WordSearchSubject(
      id: 'ws_antonyms',
      name: 'Antonym Mode',
      icon: '🌓',
      color: Colors.orange,
      levels: [
        WordSearchLevel(id: 1, name: 'Level 1', description: 'Find the Antonym', gridSize: 8, wordCount: 4, words: ['COLD', 'SMALL', 'SLOW', 'DOWN'], clues: {'HOT': 'COLD', 'BIG': 'SMALL', 'FAST': 'SLOW', 'UP': 'DOWN'}),
        WordSearchLevel(id: 2, name: 'Level 2', description: 'Find the Antonym', gridSize: 8, wordCount: 4, words: ['SAD', 'POOR', 'NEW', 'BAD'], clues: {'HAPPY': 'SAD', 'RICH': 'POOR', 'OLD': 'NEW', 'GOOD': 'BAD'}),
        WordSearchLevel(id: 3, name: 'Level 3', description: 'Find the Antonym', gridSize: 9, wordCount: 4, words: ['NIGHT', 'EMPTY', 'SOFT', 'WEAK'], clues: {'DAY': 'NIGHT', 'FULL': 'EMPTY', 'HARD': 'SOFT', 'STRONG': 'WEAK'}),
        WordSearchLevel(id: 4, name: 'Level 4', description: 'Find the Antonym', gridSize: 9, wordCount: 4, words: ['OUT', 'DARK', 'WRONG', 'LOW'], clues: {'IN': 'OUT', 'LIGHT': 'DARK', 'RIGHT': 'WRONG', 'HIGH': 'LOW'}),
        WordSearchLevel(id: 5, name: 'Level 5', description: 'Find the Antonym', gridSize: 10, wordCount: 4, words: ['CRUEL', 'FEW', 'AWAKE', 'TIGHT'], clues: {'KIND': 'CRUEL', 'MANY': 'FEW', 'ASLEEP': 'AWAKE', 'LOOSE': 'TIGHT'}),
      ],
    ),
    const WordSearchSubject(
      id: 'ws_synonyms',
      name: 'Synonym Mode',
      icon: '🔗',
      color: Colors.indigo,
      levels: [
        WordSearchLevel(id: 1, name: 'Level 1', description: 'Find the Synonym', gridSize: 8, wordCount: 4, words: ['LARGE', 'TINY', 'QUICK', 'GLAD'], clues: {'BIG': 'LARGE', 'SMALL': 'TINY', 'FAST': 'QUICK', 'HAPPY': 'GLAD'}),
        WordSearchLevel(id: 2, name: 'Level 2', description: 'Find the Synonym', gridSize: 8, wordCount: 4, words: ['UNHAPPY', 'ANGRY', 'START', 'HALT'], clues: {'SAD': 'UNHAPPY', 'MAD': 'ANGRY', 'BEGIN': 'START', 'STOP': 'HALT'}),
        WordSearchLevel(id: 3, name: 'Level 3', description: 'Find the Synonym', gridSize: 9, wordCount: 4, words: ['PRETTY', 'HARD', 'SMART', 'GIFT'], clues: {'LOVELY': 'PRETTY', 'TOUGH': 'HARD', 'CLEVER': 'SMART', 'PRESENT': 'GIFT'}),
        WordSearchLevel(id: 4, name: 'Level 4', description: 'Find the Synonym', gridSize: 9, wordCount: 4, words: ['QUIET', 'SIMPLE', 'RICH', 'COLD'], clues: {'SILENT': 'QUIET', 'EASY': 'SIMPLE', 'WEALTHY': 'RICH', 'CHILLY': 'COLD'}),
        WordSearchLevel(id: 5, name: 'Level 5', description: 'Find the Synonym', gridSize: 10, wordCount: 4, words: ['BRAVE', 'FAMOUS', 'FRAGILE', 'HONEST'], clues: {'COURAGEOUS': 'BRAVE', 'WELLKNOWN': 'FAMOUS', 'DELICATE': 'FRAGILE', 'SINCERE': 'HONEST'}),
      ],
    ),
  ];

}