import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectsData {
  // Easy Mode Subjects - Simple, common words (4 subjects)
  static List<Subject> easySubjects = [
    Subject(
      id: 'animals',
      name: 'Animals',
      icon: '🐾',
      words: [
        'CAT', 'DOG', 'FISH', 'BIRD', 'FROG', 'DUCK', 'BEAR', 'LION',
        'TIGER', 'ZEBRA', 'CAMEL', 'GOAT', 'SHEEP', 'HORSE', 'MOUSE', 'RABBIT',
        'SNAKE', 'SHARK', 'WHALE', 'CHICK', 'PANDA', 'KOALA', 'OTTER', 'WOLF'
      ],
      wordHints: {
        'CAT': 'Meow', 'DOG': 'Bark', 'FISH': 'Swims', 'BIRD': 'Flies in sky', 'FROG': 'Jumping amphibian', 'DUCK': 'Quack', 'BEAR': 'Big furry animal', 'LION': 'King of the jungle',
        'TIGER': 'Striped big cat', 'ZEBRA': 'Striped horse', 'CAMEL': 'Desert animal with humps', 'GOAT': 'Horns and beard', 'SHEEP': 'Wooly animal', 'HORSE': 'Riding animal / Neigh', 'MOUSE': 'Squeaky rodent', 'RABBIT': 'Hops / Eats carrots',
        'SNAKE': 'Slithering reptile', 'SHARK': 'Toothy sea predator', 'WHALE': 'Huge ocean mammal', 'CHICK': 'Baby chicken', 'PANDA': 'Black and white bear', 'KOALA': 'Eucalyptus eater', 'OTTER': 'Playful river mammal', 'WOLF': 'Howls at moon'
      },
      color: Colors.green,
    ),
    Subject(
      id: 'foods',
      name: 'Foods',
      icon: '🍕',
      words: [
        'APPLE', 'BANANA', 'PIZZA', 'BURGER', 'PASTA', 'SUSHI', 'SALAD', 'STEAK',
        'SOUP', 'BREAD', 'TACO', 'CURRY', 'RICE', 'CAKE', 'PIE', 'JELLY',
        'HONEY', 'SYRUP', 'MEAT', 'FISH', 'EGG', 'MILK', 'TEA', 'COFFEE'
      ],
      wordHints: {
        'APPLE': 'Red or green fruit', 'BANANA': 'Yellow fruit, monkeys love it', 'PIZZA': 'Round dough with cheese & toppings', 'BURGER': 'Ground meat patty in a bun', 'PASTA': 'Italian noodles', 'SUSHI': 'Japanese rice and raw fish', 'SALAD': 'Mixed vegetables', 'STEAK': 'Thick slice of beef',
        'SOUP': 'Liquid food dish', 'BREAD': 'Baked dough staple', 'TACO': 'Mexican folded tortilla', 'CURRY': 'Spicy Indian/Asian dish', 'RICE': 'Staple grain of Asia', 'CAKE': 'Sweet baked dessert', 'PIE': 'Baked pastry with filling', 'JELLY': 'Wobbly fruit dessert',
        'HONEY': 'Sweet liquid made by bees', 'SYRUP': 'Sweet sticky liquid', 'MEAT': 'Animal flesh as food', 'FISH': 'Aquatic animal eaten as food', 'EGG': 'Laid by chickens', 'MILK': 'White dairy liquid', 'TEA': 'Hot infused beverage', 'COFFEE': 'Caffeinated morning drink'
      },
      color: Colors.redAccent,
    ),
    Subject(
      id: 'body',
      name: 'Body Parts',
      icon: '👤',
      words: [
        'HEAD', 'HAIR', 'EYE', 'EAR', 'NOSE', 'MOUTH', 'TEETH', 'TONGUE',
        'NECK', 'SHOULDER', 'ARM', 'HAND', 'FINGER', 'CHEST', 'BACK', 'STOMACH',
        'LEG', 'KNEE', 'FOOT', 'TOE', 'SKIN', 'BONE', 'HEART', 'BRAIN'
      ],
      wordHints: {
        'HEAD': 'Top part of body', 'HAIR': 'Grows on scalp', 'EYE': 'Organ for seeing', 'EAR': 'Organ for hearing', 'NOSE': 'Organ for smelling', 'MOUTH': 'Opening for eating and speaking', 'TEETH': 'White structures for chewing', 'TONGUE': 'Muscle for tasting',
        'NECK': 'Connects head to body', 'SHOULDER': 'Joint connecting arm to body', 'ARM': 'Upper limb', 'HAND': 'End of arm with fingers', 'FINGER': 'Digits on hand', 'CHEST': 'Front part of torso', 'BACK': 'Rear part of torso', 'STOMACH': 'Organ for digesting food',
        'LEG': 'Lower limb', 'KNEE': 'Joint in middle of leg', 'FOOT': 'End of leg', 'TOE': 'Digits on foot', 'SKIN': 'Outer covering of body', 'BONE': 'Hard structural part of skeleton', 'HEART': 'Organ that pumps blood', 'BRAIN': 'Organ that controls thinking'
      },
      color: Colors.pink,
    ),
    Subject(
      id: 'school',
      name: 'School Items',
      icon: '📚',
      words: [
        'BOOK', 'PEN', 'PENCIL', 'ERASER', 'RULER', 'NOTEBOOK', 'BACKPACK', 'LUNCHBOX',
        'DESK', 'CHAIR', 'BOARD', 'CHALK', 'MARKER', 'SCISSORS', 'GLUE', 'PAPER',
        'CRAYON', 'PAINT', 'BRUSH', 'CALCULATOR', 'DICTIONARY', 'ATLAS', 'GLOBE', 'LOCKER'
      ],
      wordHints: {
        'BOOK': 'Pages with writing', 'PEN': 'Writes with ink', 'PENCIL': 'Writes with graphite', 'ERASER': 'Removes pencil marks', 'RULER': 'Measures length', 'NOTEBOOK': 'Paper for writing notes', 'BACKPACK': 'Bag carried on back', 'LUNCHBOX': 'Container for food',
        'DESK': 'Table for studying', 'CHAIR': 'Seat for sitting', 'BOARD': 'Surface for writing', 'CHALK': 'Writes on blackboard', 'MARKER': 'Colorful writing tool', 'SCISSORS': 'Cuts paper', 'GLUE': 'Sticks things together', 'PAPER': 'Material for writing/drawing',
        'CRAYON': 'Wax coloring tool', 'PAINT': 'Colored liquid for art', 'BRUSH': 'Tool for applying paint', 'CALCULATOR': 'Does math calculations', 'DICTIONARY': 'Book of word meanings', 'ATLAS': 'Book of maps', 'GLOBE': 'Spherical model of Earth', 'LOCKER': 'Storage compartment'
      },
      color: Colors.blue,
    ),
  ];

  // Medium Mode Subjects - More complex words (4 subjects)
  static List<Subject> mediumSubjects = [
    Subject(
      id: 'cities',
      name: 'Cities',
      icon: '🏙️',
      words: [
        'NEW YORK', 'LONDON', 'TOKYO', 'PARIS', 'DUBAI', 'SINGAPORE', 'ROME', 'BERLIN',
        'BARCELONA', 'AMSTERDAM', 'VENICE', 'PRAGUE', 'VIENNA', 'BUDAPEST', 'LISBON', 'ATHENS',
        'CAIRO', 'MUMBAI', 'SHANGHAI', 'SYDNEY', 'TORONTO', 'MEXICO CITY', 'RIO', 'CAPE TOWN'
      ],
      wordHints: {
        'NEW YORK': 'The Big Apple, USA', 'LONDON': 'Capital of UK, Big Ben', 'TOKYO': 'Capital of Japan', 'PARIS': 'City of Love, Eiffel Tower', 'DUBAI': 'City in UAE, Burj Khalifa', 'SINGAPORE': 'Garden City, Marina Bay', 'ROME': 'Eternal City, Colosseum', 'BERLIN': 'German capital, Brandenburg Gate',
        'BARCELONA': 'Spanish city, Sagrada Familia', 'AMSTERDAM': 'Dutch city, canals', 'VENICE': 'City of Canals, Italy', 'PRAGUE': 'City of a Hundred Spires', 'VIENNA': 'Austrian city, music capital', 'BUDAPEST': 'Hungarian capital, Danube River', 'LISBON': 'Portuguese capital, hills', 'ATHENS': 'Greek capital, Acropolis',
        'CAIRO': 'Egyptian capital, pyramids nearby', 'MUMBAI': 'Indian city, Bollywood', 'SHANGHAI': 'Chinese megacity, skyscrapers', 'SYDNEY': 'Australian city, Opera House', 'TORONTO': 'Canadian city, CN Tower', 'MEXICO CITY': 'Mexican capital, Aztec history', 'RIO': 'Brazilian city, Christ the Redeemer', 'CAPE TOWN': 'South African city, Table Mountain'
      },
      color: Colors.orange,
    ),
    Subject(
      id: 'tech',
      name: 'Technology',
      icon: '💻',
      words: [
        'COMPUTER', 'INTERNET', 'SOFTWARE', 'HARDWARE', 'PROGRAMMING', 'DATABASE', 'NETWORK', 'ALGORITHM',
        'WIFI', 'MOBILE', 'LAPTOP', 'TABLET', 'SERVER', 'CLOUD', 'ROBOT', 'VIRTUAL',
        'BINARY', 'PIXEL', 'DATA', 'CODE', 'TECH', 'CHIP', 'RAM', 'ROM'
      ],
      wordHints: {
        'COMPUTER': 'Electronic calculating machine', 'INTERNET': 'Global network of computers', 'SOFTWARE': 'Programs and apps', 'HARDWARE': 'Physical parts of a computer', 'PROGRAMMING': 'Writing code', 'DATABASE': 'Organized collection of data', 'NETWORK': 'Connected devices', 'ALGORITHM': 'Set of rules for calculation',
        'WIFI': 'Wireless network technology', 'MOBILE': 'Cell phone', 'LAPTOP': 'Portable folding computer', 'TABLET': 'Touchscreen device larger than a phone', 'SERVER': 'Computer that provides services', 'CLOUD': 'Internet-based storage', 'ROBOT': 'Automated machine', 'VIRTUAL': 'Not physical, simulated by computer',
        'BINARY': 'System of 0s and 1s', 'PIXEL': 'Smallest dot on a screen', 'DATA': 'Information', 'CODE': 'Instructions for a computer', 'TECH': 'Short for technology', 'CHIP': 'Integrated circuit', 'RAM': 'Temporary short-term memory', 'ROM': 'Read-Only Memory'
      },
      color: Colors.purple,
    ),
    Subject(
      id: 'sports',
      name: 'Sports',
      icon: '⚽',
      words: [
        'SOCCER', 'BASKETBALL', 'TENNIS', 'BASEBALL', 'HOCKEY', 'CRICKET', 'GOLF', 'RUGBY',
        'BOXING', 'VOLLEYBALL', 'SWIMMING', 'SKIING', 'SURFING', 'SKATING', 'GYMNASTICS', 'KARATE',
        'JUDO', 'ARCHERY', 'FENCING', 'ROWING', 'CYCLING', 'MARATHON', 'TRIATHLON', 'PARKOUR'
      ],
      wordHints: {
        'SOCCER': 'Kick ball into net', 'BASKETBALL': 'Shoot ball through hoop', 'TENNIS': 'Racket sport over net', 'BASEBALL': 'Bat and ball, home run', 'HOCKEY': 'Ice or field with stick', 'CRICKET': 'Bat and ball, wickets', 'GOLF': 'Hit ball into holes', 'RUGBY': 'Oval ball, physical contact',
        'BOXING': 'Punching sport in ring', 'VOLLEYBALL': 'Hit ball over net', 'SWIMMING': 'Moving through water', 'SKIING': 'Glide on snow', 'SURFING': 'Ride ocean waves', 'SKATING': 'Ice or roller skating', 'GYMNASTICS': 'Acrobatic routines', 'KARATE': 'Martial art with striking',
        'JUDO': 'Martial art with throwing', 'ARCHERY': 'Shoot arrows at target', 'FENCING': 'Sword fighting sport', 'ROWING': 'Propel boat with oars', 'CYCLING': 'Riding bicycles', 'MARATHON': 'Long distance running', 'TRIATHLON': 'Swim, bike, run', 'PARKOUR': 'Obstacle course movement'
      },
      color: Colors.deepOrange,
    ),
    Subject(
      id: 'movies',
      name: 'Movies',
      icon: '🎬',
      words: [
        'TITANIC', 'AVATAR', 'INCEPTION', 'GLADIATOR', 'FROZEN', 'JUMANJI', 'CASABLANCA', 'ROCKY',
        'BATMAN', 'MATRIX', 'ALIEN', 'PSYCHO', 'SCREAM', 'SHREK', 'VERTIGO', 'PULP FICTION',
        'FIGHT CLUB', 'FORREST GUMP', 'THE GODFATHER', 'STAR WARS', 'LORD OF RINGS', 'HARRY POTTER', 'JURASSIC PARK', 'BACK TO FUTURE'
      ],
      wordHints: {
        'TITANIC': 'Ship sinking romance', 'AVATAR': 'Blue aliens on Pandora', 'INCEPTION': 'Dream within a dream', 'GLADIATOR': 'Roman empire fighter', 'FROZEN': 'Disney ice princess', 'JUMANJI': 'Magical board game', 'CASABLANCA': 'Classic romance wartime', 'ROCKY': 'Boxer underdog story',
        'BATMAN': 'Dark Knight superhero', 'MATRIX': 'Red pill or blue pill', 'ALIEN': 'Space horror creature', 'PSYCHO': 'Hitchcock shower scene', 'SCREAM': 'Ghostface horror', 'SHREK': 'Green ogre fairy tale', 'VERTIGO': 'Hitchcock fear of heights', 'PULP FICTION': 'Tarantino crime stories',
        'FIGHT CLUB': 'Underground fighting movie', 'FORREST GUMP': 'Life is like a box of chocolates', 'THE GODFATHER': 'Mafia family saga', 'STAR WARS': 'Space opera with lightsabers', 'LORD OF RINGS': 'Fantasy ring quest', 'HARRY POTTER': 'Wizard boy at Hogwarts', 'JURASSIC PARK': 'Dinosaurs brought back', 'BACK TO FUTURE': 'Time traveling DeLorean'
      },
      color: Colors.red,
    ),
  ];

  // Hard Mode Subjects - Complex, specialized terms (4 subjects)
  static List<Subject> hardSubjects = [
    Subject(
      id: 'science',
      name: 'Science Terms',
      icon: '🔬',
      words: [
        'PHOTOSYNTHESIS', 'MITOCHONDRIA', 'CHLOROPHYLL', 'ECOSYSTEM', 'BIODIVERSITY', 'HOMEOSTASIS', 'METABOLISM', 'OSMOSIS',
        'NEURON', 'SYNAPSE', 'DOPAMINE', 'ENZYME', 'ANTIBODY', 'VACCINE', 'MICROSCOPE', 'CENTRIFUGE',
        'QUANTUM', 'PARTICLE', 'MOLECULE', 'COMPOUND', 'CATALYST', 'POLYMER', 'ISOTOPE', 'RADIOACTIVE'
      ],
      wordHints: {
        'PHOTOSYNTHESIS': 'Light to energy', 'MITOCHONDRIA': 'Powerhouse', 'CHLOROPHYLL': 'Green pigment', 'ECOSYSTEM': 'Living organisms', 'BIODIVERSITY': 'Life forms', 'HOMEOSTASIS': 'Stable internal balance', 'METABOLISM': 'Chemical processes in body', 'OSMOSIS': 'Movement of water across membrane',
        'NEURON': 'Nerve cell', 'SYNAPSE': 'Gap between neurons', 'DOPAMINE': 'Brain chemical for pleasure', 'ENZYME': 'Biological catalyst', 'ANTIBODY': 'Fights infections', 'VACCINE': 'Prevents diseases', 'MICROSCOPE': 'Magnifies tiny objects', 'CENTRIFUGE': 'Spins to separate substances',
        'QUANTUM': 'Smallest discrete unit of energy', 'PARTICLE': 'Tiny piece of matter', 'MOLECULE': 'Group of bonded atoms', 'COMPOUND': 'Substance with multiple elements', 'CATALYST': 'Speeds up reactions', 'POLYMER': 'Large chain molecule', 'ISOTOPE': 'Variant of an element', 'RADIOACTIVE': 'Emits radiation'
      },
      color: Colors.indigo,
    ),
    Subject(
      id: 'philosophy',
      name: 'Philosophy',
      icon: '🧠',
      words: [
        'ETHICS', 'METAPHYSICS', 'EPISTEMOLOGY', 'LOGIC', 'AESTHETICS', 'ONTOLOGY', 'EXISTENTIALISM', 'NIHILISM',
        'STOICISM', 'HEDONISM', 'UTILITARIANISM', 'IDEALISM', 'EMPIRICISM', 'RATIONALISM', 'SKEPTICISM', 'PRAGMATISM',
        'VIRTUE', 'JUSTICE', 'TRUTH', 'KNOWLEDGE', 'WISDOM', 'CONSCIOUSNESS', 'FREE WILL', 'DETERMINISM'
      ],
      wordHints: {
        'ETHICS': 'Study of right and wrong', 'METAPHYSICS': 'Study of reality and existence', 'EPISTEMOLOGY': 'Study of knowledge', 'LOGIC': 'Study of reasoning', 'AESTHETICS': 'Study of beauty', 'ONTOLOGY': 'Study of being', 'EXISTENTIALISM': 'Focus on individual existence', 'NIHILISM': 'Belief in no meaning',
        'STOICISM': 'Endure hardship without complaint', 'HEDONISM': 'Pursuit of pleasure', 'UTILITARIANISM': 'Greatest good for most people', 'IDEALISM': 'Reality is mentally constructed', 'EMPIRICISM': 'Knowledge from experience', 'RATIONALISM': 'Knowledge from reason', 'SKEPTICISM': 'Questioning certainty', 'PRAGMATISM': 'Truth is practical',
        'VIRTUE': 'Moral excellence', 'JUSTICE': 'Fairness', 'TRUTH': 'Correspondence with reality', 'KNOWLEDGE': 'Justified true belief', 'WISDOM': 'Deep understanding', 'CONSCIOUSNESS': 'Awareness of self', 'FREE WILL': 'Ability to choose', 'DETERMINISM': 'Events are predetermined'
      },
      color: Colors.deepPurple,
    ),
    Subject(
      id: 'academic',
      name: 'Academic Studies',
      icon: '🎓',
      words: [
        'PSYCHOLOGY', 'SOCIOLOGY', 'ANTHROPOLOGY', 'LINGUISTICS', 'ECONOMICS', 'POLITICAL SCIENCE', 'HISTORIOGRAPHY', 'ARCHAEOLOGY',
        'NEUROSCIENCE', 'EPIDEMIOLOGY', 'PALEONTOLOGY', 'SEMIOTICS', 'HERMENEUTICS', 'PHENOMENOLOGY', 'DIALECTICS', 'TAXONOMY',
        'COGNITION', 'PARADIGM', 'HYPOTHESIS', 'METHODOLOGY', 'EMPIRICAL', 'THEORETICAL', 'QUALITATIVE', 'QUANTITATIVE'
      ],
      wordHints: {
        'PSYCHOLOGY': 'Study of mind and behavior', 'SOCIOLOGY': 'Study of society', 'ANTHROPOLOGY': 'Study of human cultures', 'LINGUISTICS': 'Study of language', 'ECONOMICS': 'Study of resources', 'POLITICAL SCIENCE': 'Study of government', 'HISTORIOGRAPHY': 'Study of historical writing', 'ARCHAEOLOGY': 'Study of ancient remains',
        'NEUROSCIENCE': 'Study of nervous system', 'EPIDEMIOLOGY': 'Study of disease patterns', 'PALEONTOLOGY': 'Study of fossils', 'SEMIOTICS': 'Study of signs and symbols', 'HERMENEUTICS': 'Theory of interpretation', 'PHENOMENOLOGY': 'Study of experience', 'DIALECTICS': 'Reasoning through contradiction', 'TAXONOMY': 'Science of classification',
        'COGNITION': 'Mental processes', 'PARADIGM': 'Framework of thinking', 'HYPOTHESIS': 'Testable prediction', 'METHODOLOGY': 'System of methods', 'EMPIRICAL': 'Based on observation', 'THEORETICAL': 'Based on theory', 'QUALITATIVE': 'Non-numerical research', 'QUANTITATIVE': 'Numerical research'
      },
      color: Colors.teal,
    ),
    Subject(
      id: 'rare',
      name: 'Rare Words',
      icon: '📖',
      words: [
        'SERENDIPITY', 'MELANCHOLY', 'EPHEMERAL', 'LUMINESCENT', 'ETEREAL', 'QUINTESSENTIAL', 'SYZYGY', 'PETRICHOR',
        'DEFENESTRATION', 'SESQUIPEDALIAN', 'FLIBBERTIGIBBET', 'CODDIWOMPLE', 'CATAWAMPUS', 'KERFUFFLE', 'BUMFUZZLE', 'SNOOLYGOSTER',
        'NYCTOPHOBIA', 'APHANTASIA', 'ANEMOI', 'NEBULOUS', 'INEFFABLE', 'PENUMBRA', 'LIMERENCE', 'SUSURRUS'
      ],
      wordHints: {
        'SERENDIPITY': 'Fortunate accident', 'MELANCHOLY': 'Deep sadness', 'EPHEMERAL': 'Lasting a short time', 'LUMINESCENT': 'Glowing without heat', 'ETEREAL': 'Extremely delicate', 'QUINTESSENTIAL': 'Perfect example', 'SYZYGY': 'Celestial bodies in line', 'PETRICHOR': 'Smell after rain',
        'DEFENESTRATION': 'Throwing out a window', 'SESQUIPEDALIAN': 'Long word or using long words', 'FLIBBERTIGIBBET': 'Nonsense talker', 'CODDIWOMPLE': 'To defeat thoroughly', 'CATAWAMPUS': 'Askew or diagonal', 'KERFUFFLE': 'Disturbance or fuss', 'BUMFUZZLE': 'To confuse', 'SNOOLYGOSTER': 'Hypocritical person',
        'NYCTOPHOBIA': 'Fear of darkness', 'APHANTASIA': 'Inability to visualize', 'ANEMOI': 'Wind spirits', 'NEBULOUS': 'Vague or unclear', 'INEFFABLE': 'Too great for words', 'PENUMBRA': 'Partial shadow', 'LIMERENCE': 'Romantic obsession', 'SUSURRUS': 'Whispering sound'
      },
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