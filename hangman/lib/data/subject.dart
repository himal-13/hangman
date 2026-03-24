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
        'TIGER', 'ZEBRA', 'CAMEL', 'GOAT', 'SHEEP', 'HORSE', 'MOUSE', 'RABBIT',
        'SNAKE', 'SHARK', 'WHALE', 'CHICK', 'PANDA', 'KOALA', 'OTTER', 'WOLF'
      ],
      wordHints: {
        'CAT': 'Meow / Feline', 'DOG': 'Bark / Canine', 'FISH': 'Swims in water', 'BIRD': 'Flies in sky', 'FROG': 'Jumping amphibian', 'DUCK': 'Quack bird', 'BEAR': 'Big furry forest animal', 'LION': 'King of the jungle',
        'TIGER': 'Striped big cat', 'ZEBRA': 'Striped horse', 'CAMEL': 'Desert animal with humps', 'GOAT': 'Horns and beard', 'SHEEP': 'Wooly animal', 'HORSE': 'Riding animal / Neigh', 'MOUSE': 'Squeaky rodent', 'RABBIT': 'Hops / Eats carrots',
        'SNAKE': 'Slithering reptile', 'SHARK': 'Toothy sea predator', 'WHALE': 'Huge ocean mammal', 'CHICK': 'Baby chicken', 'PANDA': 'Black and white bear', 'KOALA': 'Eucalyptus eater', 'OTTER': 'Playful river mammal', 'WOLF': 'Howls at moon'
      },
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
      wordHints: {
        'APPLE': 'Red or green, keeps doctor away', 'BANANA': 'Yellow, monkeys love it', 'ORANGE': 'Citrus, same as its color', 'MANGO': 'Sweet tropical fruit', 'GRAPE': 'Comes in bunches, makes wine', 'LEMON': 'Yellow and very sour', 'PEAR': 'Bell-shaped fruit', 'KIWI': 'Brown fuzzy skin, green inside',
        'MELON': 'Large juicy fruit', 'BERRY': 'Small juicy fruit (straw-, blue-)', 'PEACH': 'Fuzzy skin, sweet inside', 'PLUM': 'Purple or red stone fruit', 'CHERRY': 'Small red fruit with a pit', 'FIGS': 'Chewy fruit with tiny seeds', 'GUAVA': 'Tropical fruit with edible seeds', 'PAPAYA': 'Tropical fruit, orange flesh',
        'DATES': 'Sweet, sticky desert fruit', 'OLIVE': 'Small oval, yields oil', 'COCOA': 'Source of chocolate', 'LIME': 'Sour green citrus', 'APRICOT': 'Like a small peach', 'NECTAR': 'Sweet fruit juice', 'QUINCE': 'Yellow fruit, made into jelly', 'CITRUS': 'Family for oranges and lemons'
      },
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
      wordHints: {
        'RED': 'Color of blood or fire', 'BLUE': 'Color of the sky and ocean', 'GREEN': 'Color of grass and leaves', 'YELLOW': 'Color of the sun', 'PURPLE': 'Color of royalty or grapes', 'PINK': 'Light red / Color of flamingos', 'BROWN': 'Color of earth or wood', 'BLACK': 'Color of night or coal',
        'WHITE': 'Color of snow or milk', 'ORANGE': 'Color of a pumpkin', 'SILVER': 'Shiny grey metal color', 'GOLD': 'Shiny yellow precious metal', 'GRAY': 'Color of ash or clouds', 'CYAN': 'Light greenish-blue', 'MAGENTA': 'Purplish-red color', 'LIME': 'Yellow-green citrus color',
        'OLIVE': 'Dark yellowish-green', 'MAROON': 'Dark brownish-red', 'NAVY': 'Very dark blue', 'AQUA': 'Watery greenish-blue', 'TEAL': 'Medium blue-green', 'CORAL': 'Pinkish-orange color', 'IVORY': 'Off-white, like elephant tusks', 'AZURE': 'Bright blue color of unstinted sky'
      },
      color: Colors.teal,
    ),
    // Subject(
    //   id: 'numbers',
    //   name: 'Numbers',
    //   icon: '🔢',
    //   words: [
    //     'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT',
    //     'NINE', 'TEN', 'ZERO', 'FIRST', 'SECOND', 'THIRD', 'DOZEN', 'SCORE',
    //     'MANY', 'FEW', 'HALF', 'UNIT', 'DIGIT', 'SUM', 'TOTAL', 'COUNT'
    //   ],
    //   wordHints: {
    //     'ONE': 'Single unit', 'TWO': 'A pair or couple', 'THREE': 'Number of sides on a triangle', 'FOUR': 'Number of sides on a square', 'FIVE': 'Fingers on a hand', 'SIX': 'Half a dozen', 'SEVEN': 'Days in a week', 'EIGHT': 'Legs on a spider',
    //     'NINE': '3 x 3', 'TEN': 'Fingers on both hands', 'ZERO': 'Nothing / Naught', 'FIRST': 'Coming before all others', 'SECOND': 'Right after first', 'THIRD': 'Right after second', 'DOZEN': 'Set of 12', 'SCORE': 'Set of 20',
    //     'MANY': 'A large number', 'FEW': 'A small number', 'HALF': 'Fifty percent', 'UNIT': 'A single thing', 'DIGIT': 'A single numeral (0-9)', 'SUM': 'Result of addition', 'TOTAL': 'Whole amount', 'COUNT': 'Tally or enumerate'
    //   },
    //   color: Colors.cyan,
    // ),
    // Subject(
    //   id: 'toys',
    //   name: 'Toys',
    //   icon: '🧸',
    //   words: [
    //     'BALL', 'DOLL', 'CAR', 'TRAIN', 'BLOCK', 'PUZZLE', 'KITE', 'ROBOT',
    //     'BEAR', 'DRUM', 'SLIDE', 'SWING', 'BIKE', 'TRIKE', 'YO YO', 'PLANE',
    //     'CHESS', 'DICE', 'HOOP', 'TOP', 'TRUCK', 'SHIP', 'TENT', 'DOLLS'
    //   ],
    //   wordHints: {
    //     'BALL': 'Round bouncing toy', 'DOLL': 'Toy baby or person', 'CAR': 'Toy automobile', 'TRAIN': 'Toy that runs on tracks', 'BLOCK': 'Cube for building', 'PUZZLE': 'Jigsaw game', 'KITE': 'Flies on a string in the wind', 'ROBOT': 'Mechanical toy',
    //     'BEAR': 'Teddy...', 'DRUM': 'Toy instrument you beat', 'SLIDE': 'Playground chute', 'SWING': 'Playset seat that hangs', 'BIKE': 'Two-wheeled rideable', 'TRIKE': 'Three-wheeled rideable', 'YO YO': 'Spinning toy on a string', 'PLANE': 'Toy aircraft',
    //     'CHESS': 'Board game with knights and pawns', 'DICE': 'Cubes with dots for numbers', 'HOOP': 'Hula ring', 'TOP': 'Spinning toy', 'TRUCK': 'Toy hauling vehicle', 'SHIP': 'Toy boat', 'TENT': 'Play fort enclosure', 'DOLLS': 'Plural of doll'
    //   },
    //   color: Colors.lime,
    // ),
    Subject(
      id: 'weather',
      name: 'Weather',
      icon: '☀️',
      words: [
        'SUN', 'RAIN', 'SNOW', 'WIND', 'CLOUD', 'STORM', 'FOG', 'HAIL',
        'HEAT', 'COLD', 'MIST', 'GALE', 'DEW', 'FROST', 'GUST', 'CALM',
        'SKY', 'AIR', 'DAMP', 'DRY', 'HUMID', 'WARM', 'COOL', 'BREEZE'
      ],
      wordHints: {
        'SUN': 'Bright star, makes it day', 'RAIN': 'Water falling from clouds', 'SNOW': 'White frozen flakes', 'WIND': 'Moving air', 'CLOUD': 'White fluffy thing in the sky', 'STORM': 'Bad weather with thunder/lightning', 'FOG': 'Thick cloud at ground level', 'HAIL': 'Falling balls of ice',
        'HEAT': 'High temperature', 'COLD': 'Low temperature', 'MIST': 'Light fog or fine spray', 'GALE': 'Very strong wind', 'DEW': 'Morning drops of water on grass', 'FROST': 'Thin layer of ice on freezing mornings', 'GUST': 'Sudden burst of wind', 'CALM': 'No wind, peaceful',
        'SKY': 'Blue dome above us', 'AIR': 'Gas we breathe', 'DAMP': 'Slightly wet', 'DRY': 'Without moisture', 'HUMID': 'Moisture in the air, feels sticky', 'WARM': 'Comfortably hot', 'COOL': 'Comfortably cold', 'BREEZE': 'Light, gentle wind'
      },
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
        'GERMANY', 'POLAND', 'AUSTRIA', 'BELGIUM', 'DENMARK', 'FINLAND', 'IRELAND'
      ],
      wordHints: {
        'CANADA': 'North of USA, maple leaf', 'BRAZIL': 'South American country, Carnival', 'JAPAN': 'Land of the rising sun', 'FRANCE': 'Eiffel Tower country', 'INDIA': 'Taj Mahal location', 'EGYPT': 'Pyramids and Sphinx', 'MEXICO': 'South of USA, Tacos', 'CHINA': 'Great Wall country',
        'RUSSIA': 'Largest country in the world', 'ITALY': 'Boot-shaped country in Europe', 'SPAIN': 'European country, flamenco dancing', 'GREECE': 'Country of Athens', 'NORWAY': 'Scandinavian country, fjords', 'SWEDEN': 'Scandinavian country, IKEA', 'TURKEY': 'Bridges Europe and Asia', 'VIETNAM': 'Southeast Asian country, Pho',
        'GERMANY': 'European country, Berlin', 'POLAND': 'European country, Warsaw', 'AUSTRIA': 'European country, Vienna', 'BELGIUM': 'European country, chocolate', 'DENMARK': 'Scandinavian country, Lego', 'FINLAND': 'Scandinavian country, lakes', 'IRELAND': 'The Emerald Isle'
      },
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
      wordHints: {
        'SOCCER': 'Football (global), kicks ball into net', 'TENNIS': 'Played with a racket over a net', 'HOCKEY': 'Played on ice with puck or grass with ball', 'CRICKET': 'Played with bat and ball, wickets', 'GOLF': 'Hitting ball into holes', 'RUGBY': 'Physical team sport, oval ball', 'BOXING': 'Fighting with gloves in a ring', 'RACING': 'Competing for speed',
        'CHESS': 'Strategic board game', 'SKATING': 'Gliding on ice or wheels', 'DIVING': 'Jumping into water gracefully', 'SURFING': 'Riding ocean waves on a board', 'KARATE': 'Martial art with striking', 'JUDO': 'Martial art with throwing/grappling', 'BALLET': 'Theatrical dance', 'ROWING': 'Propelling a boat with oars',
        'ARCHERY': 'Shooting with bow and arrow', 'FENCING': 'Sword fighting sport', 'SQUASH': 'Racket sport in a walled court', 'BOWLING': 'Rolling a heavy ball to knock down pins', 'DARTS': 'Throwing small projectiles at a board', 'CARDS': 'Games played with a deck', 'HIKING': 'Walking in nature', 'SKIING': 'Gliding on snow'
      },
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
      wordHints: {
        'DOCTOR': 'Treats sick people', 'TEACHER': 'Educates students', 'PILOT': 'Flies airplanes', 'CHEF': 'Cooks professional meals', 'ARTIST': 'Creates paintings or sculptures', 'JUDGE': 'Presides over a court', 'ACTOR': 'Performs in movies/plays', 'NURSE': 'Assists doctors, cares for patients',
        'POLICE': 'Enforces the law', 'WRITER': 'Authors books/articles', 'DENTIST': 'Doctor for teeth', 'COACH': 'Trains athletes/teams', 'FARMER': 'Grows crops or raises animals', 'BAKER': 'Makes bread and pastries', 'MINER': 'Extracts coal/ore from underground', 'DRIVER': 'Operates a vehicle',
        'SAILOR': 'Works on a ship', 'BUTLER': 'Head servant in a household', 'TAILOR': 'Makes or alters clothes', 'BARBER': 'Cuts hair', 'WAITER': 'Serves food at a restaurant', 'SERVER': 'Alternative term for waiter', 'GUARD': 'Protects people or property', 'WARDEN': 'In charge of a prison'
      },
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
      wordHints: {
        'CAR': 'Four-wheeled personal vehicle', 'BUS': 'Large road vehicle for many passengers', 'TRAIN': 'Locomotive pulling cars on tracks', 'SHIP': 'Large ocean vessel', 'BIKE': 'Two-wheeled pedal vehicle', 'PLANE': 'Flying machine with wings', 'TRUCK': 'Heavy cargo vehicle', 'BOAT': 'Small watercraft',
        'BICYCLE': 'Long name for bike', 'SUBWAY': 'Underground transit system', 'ROCKET': 'Vehicle for space travel', 'TRAM': 'Streetcar', 'VAN': 'Boxy vehicle, larger than a car', 'JEEP': 'Rugged off-road vehicle brand', 'SLED': 'Vehicle for sliding on snow', 'GLIDER': 'Aircraft without engine',
        'YACHT': 'Luxury boat', 'CANOE': 'Narrow boat paddled by hand', 'RAFT': 'Flat floating platform', 'JET': 'Fast aircraft with turbine engines', 'HELCO': 'Short for Helicopter', 'DRONE': 'Unmanned aerial vehicle', 'SCOOT': 'Short for Scooter', 'KART': 'Small open-wheel racing vehicle'
      },
      color: Colors.brown,
    ),
    Subject(
      id: 'instruments',
      name: 'Music',
      icon: '🎵',
      words: [
        'GUITAR', 'PIANO', 'DRUMS', 'VIOLIN', 'FLUTE', 'TRUMPET', 'HARP', 'CELLO',
        'BANJO', 'ORGAN', 'TUBA', 'BUGLE', 'OBOE', 'LYRE', 'SITAR', 'LUTE',
        'BASS', 'DRUM', 'KEY', 'NOTE', 'SONG', 'BEAT', 'ROCK'
      ],
      wordHints: {
        'GUITAR': 'Six-stringed fretted instrument', 'PIANO': 'Keyboard instrument with hammers', 'DRUMS': 'Percussion set', 'VIOLIN': 'Small bowed string instrument', 'FLUTE': 'Woodwind instrument blown across', 'TRUMPET': 'Brass instrument with valves', 'HARP': 'Large plucked string instrument', 'CELLO': 'Large bowed string instrument resting on floor',
        'BANJO': 'String instrument with drum-like body', 'ORGAN': 'Keyboard instrument with pipes', 'TUBA': 'Largest, lowest brass instrument', 'BUGLE': 'Simple brass instrument, used in military', 'OBOE': 'Double-reed woodwind', 'LYRE': 'Ancient harp-like instrument', 'SITAR': 'Indian stringed instrument', 'LUTE': 'Pear-shaped string instrument',
        'BASS': 'Lowest pitched instrument', 'DRUM': 'Single percussion instrument', 'KEY': 'White or black lever on a piano', 'NOTE': 'A musical sound', 'SONG': 'Vocal musical piece', 'BEAT': 'The rhythm or pulse', 'ROCK': 'Genre of loud music'
      },
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
      wordHints: {
        'PIZZA': 'Round dough baked with cheese & toppings', 'BURGER': 'Ground meat patty in a bun', 'PASTA': 'Italian noodles (spaghetti, macaroni)', 'SUSHI': 'Japanese rice and raw fish', 'SALAD': 'Mixed vegetables', 'STEAK': 'Thick slice of beef', 'SOUP': 'Liquid food dish', 'BREAD': 'Baked dough staple',
        'TACO': 'Mexican folded tortilla', 'CURRY': 'Spicy Indian/Asian dish', 'RICE': 'Staple grain of Asia', 'CAKE': 'Sweet baked dessert', 'PIE': 'Baked pastry with filling', 'JELLY': 'Wobbly fruit dessert', 'HONEY': 'Sweet liquid made by bees', 'SYRUP': 'Sweet sticky liquid (e.g. Maple)',
        'MEAT': 'Animal flesh as food', 'FISH': 'Aquatic animal eaten as food', 'EGG': 'Laid by chickens, scrambled/fried', 'MILK': 'White dairy liquid', 'TEA': 'Hot infused beverage from leaves', 'WINE': 'Alcoholic drink from grapes', 'BEER': 'Brewed alcoholic beverage', 'SODA': 'Carbonated sweet drink'
      },
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
      wordHints: {
        'TITANIC': 'Movie about a sinking ship', 'AVATAR': 'Movie with tall blue aliens', 'INCEPTION': 'Movie about dreams within dreams', 'GLADIATOR': 'Movie with Russell Crowe in ancient Rome', 'FROZEN': 'Disney movie with Elsa and Anna', 'JUMANJI': 'Movie about a magical board game', 'CASABLANCA': '"Here\'s looking at you, kid"', 'ROCKY': 'Movie about a boxer',
        'BATMAN': 'The Dark Knight', 'THRILLER': 'Suspenseful genre or MJ song/video', 'WIZARD': '...of Oz', 'MATRIX': 'Movie with Neo and red/blue pills', 'ALIEN': 'Sci-fi horror movie with Xenomorph', 'PSYCHO': 'Hitchcock movie with shower scene', 'SCREAM': 'Horror movie with Ghostface', 'SHREK': 'Movie with a green ogre',
        'VERTIGO': 'Hitchcock movie about fear of heights', 'GHOSTS': 'Supernatural spirits', 'ZOMBIE': 'Undead flesh eater', 'ACTION': 'Fast-paced movie genre', 'COMEDY': 'Funny movie genre', 'DRAMA': 'Serious movie genre', 'HORROR': 'Scary movie genre', 'SCIFI': 'Science fiction genre'
      },
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
      wordHints: {
        'COMPUTER': 'Electronic calculating machine', 'INTERNET': 'Global network of computers', 'SOFTWARE': 'Programs and apps', 'HARDWARE': 'Physical parts of a computer', 'PROGRAMMING': 'Writing code', 'DATABASE': 'Organized collection of data', 'NETWORK': 'Connected devices', 'ALGORITHM': 'Set of rules for calculation',
        'WIFI': 'Wireless network technology', 'MOBILE': 'Cell phone', 'LAPTOP': 'Portable folding computer', 'TABLET': 'Touchscreen device larger than a phone', 'SERVER': 'Computer that provides services to others', 'CLOUD': 'Internet-based storage/computing', 'ROBOT': 'Automated machine', 'VIRTUAL': 'Not physical, simulated by computer',
        'BINARY': 'System of 0s and 1s', 'PIXEL': 'Smallest dot on a screen', 'DATA': 'Information', 'CODE': 'Instructions for a computer', 'TECH': 'Short for technology', 'CHIP': 'Integrated circuit', 'RAM': 'Temporary short-term memory', 'ROM': 'Read-Only Memory'
      },
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
      wordHints: {
        'PHYSICS': 'Study of matter and energy', 'CHEMISTRY': 'Study of substances and reactions', 'BIOLOGY': 'Study of living things', 'ASTRONOMY': 'Study of space and stars', 'MOLECULE': 'Group of atoms bonded together', 'ATOM': 'Basic unit of an element', 'GRAVITY': 'Force pulling objects together', 'ENERGY': 'Capacity to do work',
        'OXYGEN': 'Gas we breathe to live', 'CARBON': 'Element basis of all life', 'GENETIC': 'Relating to genes / heredity', 'FOSSIL': 'Preserved remains of ancient life', 'PLASMA': 'Fourth state of matter', 'VACUUM': 'Space entirely devoid of matter', 'STATIC': 'Stationary electrical charge', 'LASER': 'Focused beam of light',
        'SPACE': 'The universe beyond Earth', 'TIME': 'Past, present, future progression', 'HEAT': 'Thermal energy', 'LIGHT': 'Visible electromagnetic radiation', 'FORCE': 'Push or pull on an object', 'MASS': 'Amount of matter in an object', 'CELL': 'Basic unit of life', 'DNA': 'Carries genetic information'
      },
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
      wordHints: {
        'PYRAMID': 'Triangular tomb in Egypt', 'PHARAOH': 'Ruler of ancient Egypt', 'GLADIATOR': 'Ancient Roman fighters', 'COLOSSEUM': 'Large Roman amphitheater', 'MUMMY': 'Preserved ancient Egyptian body', 'TEMPLE': 'Building for religious practice', 'SCROLL': 'Roll of parchment with writing', 'EMPIRE': 'Extensive group of states under one ruler',
        'GREECE': 'Ancient civilization with Athens/Sparta', 'ROMAN': 'Relating to ancient Rome', 'AZTEC': 'Ancient civilization in Mexico', 'MAYA': 'Ancient Mesoamerican civilization', 'DYNASTY': 'Line of hereditary rulers', 'LEGEND': 'Traditional historical story', 'MYTH': 'Traditional story explaining nature/history', 'RUINS': 'Remains of destroyed buildings',
        'KING': 'Male monarch', 'GOD': 'Deity worshipped in religion', 'WAR': 'Armed conflict', 'HERO': 'Person admired for courage', 'GOLD': 'Valuable yellow metal', 'IRON': 'Strong metal, gave name to an Age', 'STONE': 'Rock, gave name to an Age', 'CLAY': 'Earthy material for pottery'
      },
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
      wordHints: {
        'PLANET': 'Large body orbiting a star', 'STAR': 'Luminous sphere of plasma (e.g. the Sun)', 'GALAXY': 'System of millions/billions of stars', 'COMET': 'Icy solar system body with a tail', 'ASTEROID': 'Small rocky body orbiting the sun', 'TELESCOPE': 'Instrument to see distant stars', 'SATELLITE': 'Object orbiting a planet', 'ORBIT': 'Curved path around a star or planet',
        'MARS': 'The Red Planet', 'VENUS': 'Second planet from sun', 'MOON': 'Earth\'s natural satellite', 'COSMOS': 'The universe as a complex system', 'NEBULA': 'Cloud of gas/dust in space', 'CRATER': 'Bowl-shaped impact hole', 'SOLAR': 'Relating to the sun', 'LUNAR': 'Relating to the moon',
        'ROCKET': 'Space vehicle', 'VOID': 'Completely empty space', 'DARK': 'Absence of light', 'LIGHT': 'Moves extremely fast in space', 'SUN': 'The star at our solar system center', 'EARTH': 'The planet we live on', 'SPHERE': 'Round 3D shape, like a planet', 'ALIEN': 'Extraterrestrial being'
      },
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
      wordHints: {
        'ZEUS': 'Greek king of gods (lightning)', 'THOR': 'Norse god of thunder', 'ATHENA': 'Greek goddess of wisdom/war', 'ODIN': 'Norse Allfather god', 'HERA': 'Greek queen of gods', 'APOLLO': 'Greek god of sun/music', 'ARES': 'Greek god of war', 'LOKI': 'Norse trickster god',
        'HADES': 'Greek god of the underworld', 'TITAN': 'Older gods before Olympians', 'DRAGON': 'Mythical flying reptile', 'GIANT': 'Mythical very large person', 'SIREN': 'Lures sailors with song', 'SPHINX': 'Lion body, human head, asks riddles', 'HYDRA': 'Multi-headed mythical serpent', 'MEDUSA': 'Snake hair, turns you to stone',
        'HERO': 'Demigod/Mortal of great courage', 'RELIC': 'Sacred ancient object', 'SPELL': 'Magical words/incantation', 'CURSE': 'Magical affliction', 'MAGIC': 'Supernatural power', 'SOUL': 'Spiritual essence', 'FATE': 'Destiny', 'DOOM': 'Terrible fate'
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