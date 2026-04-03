class MultiplayerWords {
  static const List<String> easyWords = [
    'CAT', 'DOG', 'SUN', 'TREE', 'BIRD', 'FISH', 'BOOK', 'ROSE',
    'MOON', 'STAR', 'FIRE', 'WIND', 'SNOW', 'RAIN', 'ROAD', 'DOOR',
    'WALL', 'HAND', 'FOOT', 'BALL', 'BELL', 'CUP', 'HAT', 'TOY',
    'MILK', 'EGG', 'BEE', 'ANT', 'WORM', 'BEAR', 'LION', 'WOLF',
    'DUCK', 'FROG', 'BOAT', 'SHIP', 'CAR', 'BUS', 'BIKE', 'CAKE'
  ]; // <= 4 letters

  static const List<String> mediumWords = [
    'WATER', 'APPLE', 'HOUSE', 'TRAIN', 'PLANE', 'CLOCK', 'SMILE', 'GRASS',
    'RIVER', 'CLOUD', 'BREAD', 'CHAIR', 'TABLE', 'GHOST', 'PARTY', 'WORLD',
    'PEACE', 'HEART', 'MUSIC', 'PIZZA', 'CANDY', 'PLANT', 'LEMON', 'MONEY',
    'WATCH', 'GLASS', 'PAPER', 'PENCIL', 'RABBIT', 'TURTLE', 'MONKEY', 'TIGER',
    'ZEBRA', 'SNAKE', 'SPIDER', 'LIZARD', 'GUITAR', 'DRAGON', 'KNIGHT', 'CASTLE',
    'OCEAN', 'FOREST', 'DESERT', 'ISLAND', 'CANYON', 'PLANET', 'ROCKET', 'METEOR',
    'WINTER', 'SUMMER', 'SPRING', 'AUTUMN', 'FRIEND', 'FAMILY', 'SCHOOL', 'DOCTOR'
  ]; // 4-6 letters

  static const List<String> hardWords = [
    'ELEPHANT', 'COMPUTER', 'MOUNTAIN', 'UNIVERSE', 'UMBRELLA', 'TELEPHONE',
    'ASTRONAUT', 'DINOSAUR', 'VOLCANO', 'CHOCOLATE', 'BUTTERFLY', 'HELICOPTER',
    'SUBMARINE', 'HOSPITAL', 'KANGAROO', 'SANDWICH', 'FESTIVAL', 'PYRAMID',
    'SYMPHONY', 'TORNADO', 'HURRICANE', 'DIAMOND', 'PENGUIN', 'OCTOPUS',
    'DOLPHIN', 'GORILLA', 'LEOPARD', 'CROCODILE', 'FLAMINGO', 'PELICAN',
    'OSTRICH', 'SCORPION', 'CHAMELEON', 'SKELETON', 'VAMPIRE', 'WEREWOLF',
    'ZOMBIE', 'UNICORN', 'MERMAID', 'CENTAUR', 'MINOTAUR', 'CYCLOPS',
    'GRIFFIN', 'PEGASUS', 'PHOENIX', 'KRAKEN', 'LEVIATHAN', 'BEHEMOTH'
  ]; // 7+ letters

  static List<String> getWordsForDifficulty(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return easyWords;
      case 'medium':
        return mediumWords;
      case 'hard':
        return hardWords;
      default:
        return mediumWords;
    }
  }
}
