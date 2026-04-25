class WordleLevel {
  final int levelNumber;
  final String theme;
  final List<String> words;

  const WordleLevel({
    required this.levelNumber,
    required this.theme,
    required this.words,
  });

  int get wordCount => words.length;
}

class WordleLevelData {
  static const List<WordleLevel> levels = [
    // ── Levels 1–3: 3 words (3-letter, 4-5 letter, 6-7 letter) ──────────
    WordleLevel(levelNumber: 1, theme: 'Animals', words: ['CAT', 'LION', 'GIRAFFE']),
    WordleLevel(levelNumber: 2, theme: 'Space', words: ['SUN', 'MOON', 'NEPTUNE']),
    WordleLevel(levelNumber: 3, theme: 'Colors', words: ['RED', 'BLUE', 'YELLOW']),

    // ── Levels 4–6: 4 words (3, 4-5, 4-5, 6-7) ─────────────────────────
    WordleLevel(levelNumber: 4, theme: 'Food', words: ['EGG', 'CAKE', 'BREAD', 'PEPPER']),
    WordleLevel(levelNumber: 5, theme: 'Body Parts', words: ['EAR', 'KNEE', 'ELBOW', 'FINGER']),
    WordleLevel(levelNumber: 6, theme: 'Transport', words: ['CAR', 'TRAIN', 'ROCKET', 'BUS']),

    // ── Levels 7–9: 4 words (3, 4-5, 6-7, 6-7) ─────────────────────────
    WordleLevel(levelNumber: 7, theme: 'Fruits', words: ['FIG', 'GRAPE', 'CHERRY', 'BANANA']),
    WordleLevel(levelNumber: 8, theme: 'School', words: ['PEN', 'DESK', 'ERASER', 'PENCIL']),
    WordleLevel(levelNumber: 9, theme: 'Elements', words: ['AIR', 'FIRE', 'OXYGEN', 'HELIUM']),

    // ── Levels 10–12: 5 words ────────────────────────────────────────────
    WordleLevel(levelNumber: 10, theme: 'Wild Animals', words: ['FOX', 'BEAR', 'TIGER', 'MONKEY', 'CHEETAH']),
    WordleLevel(levelNumber: 11, theme: 'Flowers', words: ['ROSE', 'LILY', 'TULIP', 'ORCHID', 'DAD']),
    WordleLevel(levelNumber: 12, theme: 'Music', words: ['SAX', 'DRUM', 'FLUTE', 'GUITAR', 'VIOLIN']),

    // ── Levels 13–15: 5 words ────────────────────────────────────────────
    WordleLevel(levelNumber: 13, theme: 'Weather', words: ['FOG', 'HAIL', 'STORM', 'THUNDER', 'ICE']),
    WordleLevel(levelNumber: 14, theme: 'Tools', words: ['SAW', 'NAIL', 'DRILL', 'HAMMER', 'WRENCH']),
    WordleLevel(levelNumber: 15, theme: 'Ocean', words: ['SEA', 'WAVE', 'CORAL', 'ISLAND', 'DOLPHIN']),

    // ── Levels 16–18: 5 words ────────────────────────────────────────────
    WordleLevel(levelNumber: 16, theme: 'Planets', words: ['MARS', 'EARTH', 'VENUS', 'SATURN', 'JUPITER']),
    WordleLevel(levelNumber: 17, theme: 'Sports', words: ['SKI', 'GOLF', 'RUGBY', 'TENNIS', 'CRICKET']),
    WordleLevel(levelNumber: 18, theme: 'Jobs', words: ['VET', 'CHEF', 'PILOT', 'DOCTOR', 'TEACHER']),

    // ── Levels 19–21: 6 words ────────────────────────────────────────────
    WordleLevel(levelNumber: 19, theme: 'Landscapes', words: ['BAY', 'CAVE', 'CLIFF', 'VALLEY', 'GLACIER', 'HILL']),
    WordleLevel(levelNumber: 20, theme: 'Science', words: ['ION', 'ATOM', 'CELLS', 'PROTON', 'NEUTRON', 'GAS']),
    WordleLevel(levelNumber: 21, theme: 'Insects', words: ['BEE', 'ANT', 'MOTH', 'BEETLE', 'CRICKET', 'WASP']),

    // ── Levels 22–25: 6 words ────────────────────────────────────────────
    WordleLevel(levelNumber: 22, theme: 'Kitchen', words: ['PAN', 'FORK', 'PLATE', 'BLENDER', 'SPATULA', 'POT']),
    WordleLevel(levelNumber: 23, theme: 'Birds', words: ['OWL', 'CROW', 'EAGLE', 'PARROT', 'PENGUIN', 'EMU']),
    WordleLevel(levelNumber: 24, theme: 'Clothing', words: ['HAT', 'COAT', 'SHIRT', 'JACKET', 'SWEATER', 'TIE']),
    WordleLevel(levelNumber: 25, theme: 'Gems', words: ['RUBY', 'OPAL', 'PEARL', 'TOPAZ', 'DIAMOND', 'JET']),
  ];
}
