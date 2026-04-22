import 'dart:math';

class WordleWords {
  static const List<String> level1Words = [
    'CAT', 'DOG', 'SUN', 'BAT', 'RED', 'CAR', 'HAT', 'CUP', 'PEN', 'BOX',
    'FOX', 'COW', 'PIG', 'ANT', 'BEE', 'OWL', 'RAT', 'HEN', 'ICE', 'SKY'
  ];

  static const List<String> level2Words = [
    'BIRD', 'TREE', 'FISH', 'STAR', 'MOON', 'DOOR', 'BOOK', 'DESK', 'LAMP', 'SHOE',
    'BOAT', 'CAKE', 'FIRE', 'SNOW', 'RAIN', 'WIND', 'ROAD', 'MILK', 'COLD', 'WARM'
  ];

  static const List<String> level3Words = [
    'APPLE', 'WATER', 'HOUSE', 'CHAIR', 'TABLE', 'TRAIN', 'PLANE', 'CLOCK', 'MOUSE', 'PLANT',
    'PHONE', 'PENCIL', 'ORANGE', 'BANANA', 'GUITAR', 'CAMERA', 'PLANET', 'FLOWER', 'WINTER', 'SUMMER'
  ];

  static String getRandomWord(int level) {
    final random = Random();
    List<String> pool;
    switch (level) {
      case 1:
        pool = level1Words;
        break;
      case 2:
        pool = level2Words;
        break;
      case 3:
      default:
        pool = level3Words;
        break;
    }
    return pool[random.nextInt(pool.length)];
  }
}
