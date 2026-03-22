import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectsData {
  // Easy Mode Subjects - Simple, common words (6 subjects)
  static List<Subject> easySubjects = [
    Subject(
      id: 'animals',
      name: 'Animals',
      icon: '🐾',
      words: [
        'CAT', 'DOG', 'FISH', 'BIRD', 'FROG', 'DUCK', 'BEAR', 'LION',
        'TIGER', 'ZREBA', 'CAMEL', 'GOAT', 'SHEEP', 'HORSE', 'MOUSE', 'RABBIT',
        'SNAKE', 'SHARK', 'WHALE', 'CHICK', 'PANDA', 'KOALA', 'OTTER', 'WOLF'
      ],
      color: Colors.green,
    ),
    Subject(
      id: 'fruits',
      name: 'Fruits',
      icon: '🍎',
      words: [
        'APPLE', 'BANANA', 'ORANGE', 'MANGO', 'GRAPE', 'LEMON', 'PEAR', 'KIWI',
        'MELON', 'BERRY', 'PEACH', 'PLUM', 'CHERRY', 'FIGS', 'GUAVA', 'PAPAYA',
        'DATES', 'OLIVE', 'COCOA', 'LIME', 'APRICOT', 'NECTAR', 'QUINCE', 'CITRUS'
      ],
      color: Colors.lightGreen,
    ),
    Subject(
      id: 'colors',
      name: 'Colors',
      icon: '🎨',
      words: [
        'RED', 'BLUE', 'GREEN', 'YELLOW', 'PURPLE', 'PINK', 'BROWN', 'BLACK',
        'WHITE', 'ORANGE', 'SILVER', 'GOLD', 'GRAY', 'CYAN', 'MAGENTA', 'LIME',
        'OLIVE', 'MAROON', 'NAVY', 'AQUA', 'TEAL', 'CORAL', 'IVORY', 'AZURE'
      ],
      color: Colors.teal,
    ),
    Subject(
      id: 'numbers',
      name: 'Numbers',
      icon: '🔢',
      words: [
        'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT',
        'NINE', 'TEN', 'ZERO', 'FIRST', 'SECOND', 'THIRD', 'DOZEN', 'SCORE',
        'MANY', 'FEW', 'HALF', 'UNIT', 'DIGIT', 'SUM', 'TOTAL', 'COUNT'
      ],
      color: Colors.cyan,
    ),
    Subject(
      id: 'toys',
      name: 'Toys',
      icon: '🧸',
      words: [
        'BALL', 'DOLL', 'CAR', 'TRAIN', 'BLOCK', 'PUZZLE', 'KITE', 'ROBOT',
        'BEAR', 'DRUM', 'SLIDE', 'SWING', 'BIKE', 'TRIKE', 'YO YO', 'PLANE',
        'CHESS', 'DICE', 'HOOP', 'TOP', 'TRUCK', 'SHIP', 'TENT', 'DOLLS'
      ],
      color: Colors.lime,
    ),
    Subject(
      id: 'weather',
      name: 'Weather',
      icon: '☀️',
      words: [
        'SUN', 'RAIN', 'SNOW', 'WIND', 'CLOUD', 'STORM', 'FOG', 'HAIL',
        'HEAT', 'COLD', 'MIST', 'GALE', 'DEW', 'FROST', 'GUST', 'CALM',
        'SKY', 'AIR', 'DAMP', 'DRY', 'HUMID', 'WARM', 'COOL', 'BREEZE'
      ],
      color: Colors.blue,
    ),
  ];

  // Medium Mode Subjects - Longer words, common categories (6 subjects)
  static List<Subject> mediumSubjects = [
    Subject(
      id: 'countries',
      name: 'Countries',
      icon: '🌍',
      words: [
        'CANADA', 'BRAZIL', 'JAPAN', 'FRANCE', 'INDIA', 'EGYPT', 'MEXICO', 'CHINA',
        'RUSSIA', 'ITALY', 'SPAIN', 'GREECE', 'NORWAY', 'SWEDEN', 'TURKEY', 'VIETNAM',
        'GERMANY', 'POLAND', 'CANADA', 'AUSTRIA', 'BELGIUM', 'DENMARK', 'FINLAND', 'IRELAND'
      ],
      color: Colors.orange,
    ),
    Subject(
      id: 'sports',
      name: 'Sports',
      icon: '⚽',
      words: [
        'SOCCER', 'TENNIS', 'HOCKEY', 'CRICKET', 'GOLF', 'RUGBY', 'BOXING', 'RACING',
        'CHESS', 'SKATING', 'DIVING', 'SURFING', 'KARATE', 'JUDO', 'BALLET', 'ROWING',
        'ARCHERY', 'FENCING', 'SQUASH', 'BOWLING', 'DARTS', 'CARDS', 'HIKING', 'SKIING'
      ],
      color: Colors.deepOrange,
    ),
    Subject(
      id: 'professions',
      name: 'Jobs',
      icon: '👨‍💼',
      words: [
        'DOCTOR', 'TEACHER', 'PILOT', 'CHEF', 'ARTIST', 'JUDGE', 'ACTOR', 'NURSE',
        'POLICE', 'WRITER', 'DENTIST', 'COACH', 'FARMER', 'BAKER', 'MINER', 'DRIVER',
        'SAILOR', 'BUTLER', 'TAILOR', 'BARBER', 'WAITER', 'SERVER', 'GUARD', 'WARDEN'
      ],
      color: Colors.amber,
    ),
    Subject(
      id: 'transport',
      name: 'Vehicles',
      icon: '🚗',
      words: [
        'CAR', 'BUS', 'TRAIN', 'SHIP', 'BIKE', 'PLANE', 'TRUCK', 'BOAT',
        'BICYCLE', 'SUBWAY', 'ROCKET', 'TRAM', 'VAN', 'JEEP', 'SLED', 'GLIDER',
        'YACHT', 'CANOE', 'RAFT', 'JET', 'HELCO', 'DRONE', 'SCOOT', 'KART'
      ],
      color: Colors.brown,
    ),
    Subject(
      id: 'instruments',
      name: 'Music',
      icon: '🎵',
      words: [
        'GUITAR', 'PIANO', 'DRUMS', 'VIOLIN', 'FLUTE', 'TRUMPET', 'HARP', 'CELLO',
        'BANJO', 'ORGAN', 'TUBA', 'BUGLE', 'OBOE', 'LYRE', 'SITAR', 'LUTE',
        'PIANO', 'BASS', 'DRUM', 'KEY', 'NOTE', 'SONG', 'BEAT', 'ROCK'
      ],
      color: Colors.pink,
    ),
    Subject(
      id: 'food',
      name: 'Food',
      icon: '🍕',
      words: [
        'PIZZA', 'BURGER', 'PASTA', 'SUSHI', 'SALAD', 'STEAK', 'SOUP', 'BREAD',
        'TACO', 'CURRY', 'RICE', 'CAKE', 'PIE', 'JELLY', 'HONEY', 'SYRUP',
        'MEAT', 'FISH', 'EGG', 'MILK', 'TEA', 'WINE', 'BEER', 'SODA'
      ],
      color: Colors.redAccent,
    ),
  ];

  // Hard Mode Subjects - Complex words, specific categories (6 subjects)
  static List<Subject> hardSubjects = [
    Subject(
      id: 'movies',
      name: 'Movies',
      icon: '🎬',
      words: [
        'TITANIC', 'AVATAR', 'INCEPTION', 'GLADIATOR', 'FROZEN', 'JUMANJI', 'CASABLANCA', 'ROCKY',
        'BATMAN', 'THRILLER', 'WIZARD', 'MATRIX', 'ALIEN', 'PSYCHO', 'SCREAM', 'SHREK',
        'VERTIGO', 'GHOSTS', 'ZOMBIE', 'ACTION', 'COMEDY', 'DRAMA', 'HORROR', 'SCIFI'
      ],
      color: Colors.red,
    ),
    Subject(
      id: 'technology',
      name: 'Tech',
      icon: '💻',
      words: [
        'COMPUTER', 'INTERNET', 'SOFTWARE', 'HARDWARE', 'PROGRAMMING', 'DATABASE', 'NETWORK', 'ALGORITHM',
        'WIFI', 'MOBILE', 'LAPTOP', 'TABLET', 'SERVER', 'CLOUD', 'ROBOT', 'VIRTUAL',
        'BINARY', 'PIXEL', 'DATA', 'CODE', 'TECH', 'CHIP', 'RAM', 'ROM'
      ],
      color: Colors.purple,
    ),
    Subject(
      id: 'science',
      name: 'Science',
      icon: '🔬',
      words: [
        'PHYSICS', 'CHEMISTRY', 'BIOLOGY', 'ASTRONOMY', 'MOLECULE', 'ATOM', 'GRAVITY', 'ENERGY',
        'OXYGEN', 'CARBON', 'GENETIC', 'FOSSIL', 'PLASMA', 'VACUUM', 'STATIC', 'LASER',
        'SPACE', 'TIME', 'HEAT', 'LIGHT', 'FORCE', 'MASS', 'CELL', 'DNA'
      ],
      color: Colors.indigo,
    ),
    Subject(
      id: 'ancient',
      name: 'Ancient',
      icon: '🏛️',
      words: [
        'PYRAMID', 'PHARAOH', 'GLADIATOR', 'COLOSSEUM', 'MUMMY', 'TEMPLE', 'SCROLL', 'EMPIRE',
        'GREECE', 'ROMAN', 'AZTEC', 'MAYA', 'DYNASTY', 'LEGEND', 'MYTH', 'RUINS',
        'KING', 'GOD', 'WAR', 'HERO', 'GOLD', 'IRON', 'STONE', 'CLAY'
      ],
      color: Colors.brown.shade700,
    ),
    Subject(
      id: 'space',
      name: 'Space',
      icon: '🚀',
      words: [
        'PLANET', 'STAR', 'GALAXY', 'COMET', 'ASTEROID', 'TELESCOPE', 'SATELLITE', 'ORBIT',
        'MARS', 'VENUS', 'MOON', 'COSMOS', 'NEBULA', 'CRATER', 'SOLAR', 'LUNAR',
        'ROCKET', 'VOID', 'DARK', 'LIGHT', 'SUN', 'EARTH', 'SPHERE', 'ALIEN'
      ],
      color: Colors.deepPurple,
    ),
    Subject(
      id: 'mythology',
      name: 'Mythology',
      icon: '⚡',
      words: [
        'ZEUS', 'THOR', 'ATHENA', 'ODIN', 'HERA', 'APOLLO', 'ARES', 'LOKI',
        'HADES', 'TITAN', 'DRAGON', 'GIANT', 'SIREN', 'SPHINX', 'HYDRA', 'MEDUSA',
        'HERO', 'RELIC', 'SPELL', 'CURSE', 'MAGIC', 'SOUL', 'FATE', 'DOOM'
      ],
      color: Colors.amber.shade800,
    ),
  ];

  // Helper method to get all subjects (if needed)
  static List<Subject> getAllSubjects() {
    return [...easySubjects, ...mediumSubjects, ...hardSubjects];
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