// lib/wordgame/screens/word_search_game_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hangman/services/game_setting.dart';
import 'package:hangman/audio/audio_manager.dart';
import 'package:hangman/components/coin_dialogs.dart';
import '../models/word_search_level.dart';
import '../models/found_word.dart';
import '../models/word_search_subject.dart';
import 'package:hangman/services/game_progress.dart';

class WordSearchGameScreen extends StatefulWidget {
  final WordSearchLevel level;
  final int levelIndex;
  final int totalLevels;
  final VoidCallback onLevelComplete;
  final WordSearchSubject? subject;

  const WordSearchGameScreen({
    super.key,
    required this.level,
    required this.levelIndex,
    required this.totalLevels,
    required this.onLevelComplete,
    this.subject,
  });

  @override
  State<WordSearchGameScreen> createState() => _WordSearchGameScreenState();
}

class _WordSearchGameScreenState extends State<WordSearchGameScreen> {
  late int _gridSize;
  late List<String> _wordsToFindInGrid;
  late List<String> _cluesToShow;
  List<List<String>> _grid = [];
  final List<FoundWord> _foundWords = [];
  List<Offset> _currentSelectionPath = [];
  Offset? _startSelection;
  Offset? _endSelection;
  final GlobalKey _gridContainerKey = GlobalKey();
  final Random _random = Random();
  bool _isGameComplete = false;
  bool _showCompletionOverlay = false;
  final Map<String, List<Offset>> _wordPlacements = {};

  // Colors
  final Color _backgroundColor = const Color(0xFFF8FAFC);
  late Color _primaryColor;

  @override
  void initState() {
    super.initState();
    _primaryColor = widget.levelIndex % 2 == 0 ? Colors.blue : Colors.green;
    _initializeGame();
  }

  void _initializeGame() {
    _gridSize = widget.level.gridSize;
    
    if (widget.level.clues != null && widget.level.clues!.isNotEmpty) {
      _cluesToShow = widget.level.clues!.keys.toList();
      _wordsToFindInGrid = widget.level.clues!.values.map((w) => w.toUpperCase()).toList();
    } else {
      _cluesToShow = widget.level.words.map((w) => w.toUpperCase()).toList();
      _wordsToFindInGrid = widget.level.words.map((w) => w.toUpperCase()).toList();
    }
    
    _generateGrid();
  }

  void _generateGrid() {
    _grid = List.generate(_gridSize, (_) => List.filled(_gridSize, ''));
    _foundWords.clear();
    _wordPlacements.clear();
    _isGameComplete = false;
    _showCompletionOverlay = false;

    final wordsToPlace = List<String>.from(_wordsToFindInGrid);
    wordsToPlace.sort((a, b) => b.length.compareTo(a.length));

    for (String word in wordsToPlace) {
      bool placed = false;
      int attempts = 0;
      while (!placed && attempts < 1000) {
        final direction = _random.nextInt(3);
        final startRow = _random.nextInt(_gridSize);
        final startCol = _random.nextInt(_gridSize);

        if (_tryPlaceWord(word, startRow, startCol, direction)) {
          placed = true;
        }
        attempts++;
      }

      if (!placed) {
        _generateGrid();
        return;
      }
    }

    _fillEmptyCells();
    setState(() {});
  }

  bool _tryPlaceWord(String word, int r, int c, int direction) {
    int dr = 0, dc = 0;
    switch (direction) {
      case 0: dr = 0; dc = 1; break;
      case 1: dr = 1; dc = 0; break;
      case 2: dr = 1; dc = 1; break;
    }

    for (int i = 0; i < word.length; i++) {
      int curR = r + i * dr;
      int curC = c + i * dc;

      if (curR < 0 || curR >= _gridSize || curC < 0 || curC >= _gridSize) {
        return false;
      }
      if (_grid[curR][curC] != '' && _grid[curR][curC] != word[i]) {
        return false;
      }
    }

    List<Offset> path = [];
    for (int i = 0; i < word.length; i++) {
      int curR = r + i * dr;
      int curC = c + i * dc;
      _grid[curR][curC] = word[i];
      path.add(Offset(curC.toDouble(), curR.toDouble()));
    }
    _wordPlacements[word] = path;

    return true;
  }

  void _fillEmptyCells() {
    const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    for (int r = 0; r < _gridSize; r++) {
      for (int c = 0; c < _gridSize; c++) {
        if (_grid[r][c] == '') {
          _grid[r][c] = alphabet[_random.nextInt(alphabet.length)];
        }
      }
    }
  }

  Offset _getGridCoordinates(Offset globalPosition, RenderBox gridRenderBox) {
    final localPosition = gridRenderBox.globalToLocal(globalPosition);
    final double padding = 16.0;
    final double innerGridWidth = gridRenderBox.size.width - (2 * padding);
    final double cellSize = innerGridWidth / _gridSize;

    final int col = ((localPosition.dx - padding) / cellSize).floor();
    final int row = ((localPosition.dy - padding) / cellSize).floor();

    if (col < 0 || col >= _gridSize || row < 0 || row >= _gridSize) {
      return const Offset(-1, -1);
    }

    return Offset(col.toDouble(), row.toDouble());
  }

  void _onPanStart(DragStartDetails details) {
    if (_isGameComplete) return;

    final RenderBox? gridRenderBox = _gridContainerKey.currentContext?.findRenderObject() as RenderBox?;
    if (gridRenderBox == null) return;

    final startCoords = _getGridCoordinates(details.globalPosition, gridRenderBox);
    if (startCoords.dx < 0 || startCoords.dy < 0) return;

    setState(() {
      _startSelection = startCoords;
      _currentSelectionPath = [_startSelection!];
      _endSelection = null;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isGameComplete || _startSelection == null) return;

    final RenderBox? gridRenderBox = _gridContainerKey.currentContext?.findRenderObject() as RenderBox?;
    if (gridRenderBox == null) return;

    final endCoords = _getGridCoordinates(details.globalPosition, gridRenderBox);
    if (endCoords.dx < 0 || endCoords.dy < 0) return;

    setState(() {
      _endSelection = endCoords;
      _currentSelectionPath = _getCellsInSelection(_startSelection!, _endSelection!);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_isGameComplete) return;

    if (_startSelection != null && _endSelection != null) {
      _checkSelection();
    }
    setState(() {
      _startSelection = null;
      _endSelection = null;
      _currentSelectionPath = [];
    });
  }

  List<Offset> _getCellsInSelection(Offset start, Offset end) {
    List<Offset> cells = [];
    int startCol = start.dx.toInt();
    int startRow = start.dy.toInt();
    int endCol = end.dx.toInt();
    int endRow = end.dy.toInt();

    if (startCol < 0 || startCol >= _gridSize || startRow < 0 || startRow >= _gridSize ||
        endCol < 0 || endCol >= _gridSize || endRow < 0 || endRow >= _gridSize) {
      return [];
    }

    bool isHorizontal = startRow == endRow;
    bool isVertical = startCol == endCol;
    bool isDiagonal = (startRow - endRow).abs() == (startCol - endCol).abs();

    if (!isHorizontal && !isVertical && !isDiagonal) {
      return [start];
    }

    int dr = 0, dc = 0;
    if (startRow < endRow) dr = 1;
    if (startCol < endCol) dc = 1;
    if (startRow > endRow) dr = -1;
    if (startCol > endCol) dc = -1;

    int curR = startRow.toInt();
    int curC = startCol.toInt();

    while (true) {
      cells.add(Offset(curC.toDouble(), curR.toDouble()));
      if (curR == endRow.toInt() && curC == endCol.toInt()) break;
      curR += dr;
      curC += dc;
    }

    return cells;
  }

  void _checkSelection() {
    if (_currentSelectionPath.isEmpty) return;

    String selectedWord = '';
    for (Offset cell in _currentSelectionPath) {
      int r = cell.dy.toInt();
      int c = cell.dx.toInt();
      if (r >= 0 && r < _gridSize && c >= 0 && c < _gridSize) {
        selectedWord += _grid[r][c];
      }
    }

    String? matchedWord;
    for (String word in _wordsToFindInGrid) {
      if (word == selectedWord) {
        matchedWord = word;
        break;
      }
    }

    if (matchedWord != null && !_foundWords.any((fw) => fw.word == matchedWord)) {
      AudioManager.playCorrect();
      
      setState(() {
        _foundWords.add(FoundWord(matchedWord!, List.from(_currentSelectionPath)));
      });

      if (_foundWords.length == _wordsToFindInGrid.length) {
        _completeGame();
      }
    } else if (_currentSelectionPath.length >= 2) {
      AudioManager.playWrong();
    }
  }

  void _showHint() async {
    final settingsProvider = Provider.of<GameSettingsProvider>(context, listen: false);
    
    if (settingsProvider.coins < 5) {
      CoinDialogs.showNotEnoughCoinsDialog(
        context: context,
        settingsProvider: settingsProvider,
      );
      return;
    }

    // Find first unfound word
    String? firstUnfoundWord;
    for (String word in _wordsToFindInGrid) {
      if (!_foundWords.any((fw) => fw.word == word)) {
        firstUnfoundWord = word;
        break;
      }
    }

    if (firstUnfoundWord != null) {
      final wordPath = _wordPlacements[firstUnfoundWord];
      if (wordPath != null && wordPath.isNotEmpty) {
        settingsProvider.spendCoins(5);
        
        setState(() {
          _currentSelectionPath = [wordPath.first];
        });
        
        AudioManager.playCorrect(); // Play sound when hint is used
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('💡 First letter revealed! (-5 coins)'),
            backgroundColor: Colors.amber,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
        
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _currentSelectionPath = [];
            });
          }
        });
      }
    }
  }

  void _completeGame() {
    setState(() {
      _isGameComplete = true;
    });
    
    AudioManager.playLevelComplete();
    
    // Award coins for completing level
    final settingsProvider = Provider.of<GameSettingsProvider>(context, listen: false);
    settingsProvider.addCoins(30);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎉 Level Complete! +30 coins'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showCompletionOverlay = true;
      });
    });
  }

  void _restartGame() {
    setState(() {
      _isGameComplete = false;
      _showCompletionOverlay = false;
    });
    _generateGrid();
  }

  @override
  Widget build(BuildContext context) {
    if (_showCompletionOverlay) {
      return _buildCompletionOverlay();
    }

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          'Level ${widget.levelIndex + 1}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Consumer<GameSettingsProvider>(
            builder: (context, settings, _) => Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Text('🪙', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 4),
                  Text(
                    '${settings.coins}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Words to find grid
            Expanded(
              flex: 1,
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: _cluesToShow.length,
                itemBuilder: (context, index) {
                  final clue = _cluesToShow[index];
                  final targetWord = widget.level.clues != null 
                      ? widget.level.clues![clue]?.toUpperCase() 
                      : clue;
                  final isFound = _foundWords.any((fw) => fw.word == targetWord);
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isFound ? _primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isFound ? _primaryColor : Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      clue,
                      style: TextStyle(
                        color: isFound ? Colors.white : _primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: isFound ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Word Search Grid
            Expanded(
              flex: 3,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    onPanStart: _onPanStart,
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    child: Container(
                      key: _gridContainerKey,
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _gridSize,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: _gridSize * _gridSize,
                        itemBuilder: (context, index) {
                          final row = index ~/ _gridSize;
                          final col = index % _gridSize;
                          final letter = _grid[row][col];
                          final isSelected = _currentSelectionPath.contains(
                              Offset(col.toDouble(), row.toDouble()));
                          final isFound = _foundWords.any((fw) =>
                              fw.path.contains(Offset(col.toDouble(), row.toDouble())));
                          
                          return Container(
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? _primaryColor 
                                  : (isFound 
                                      ? _primaryColor.withOpacity(0.3) 
                                      : Colors.white),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected || isFound 
                                    ? _primaryColor 
                                    : Colors.grey.shade200,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              letter,
                              style: TextStyle(
                                color: isSelected || isFound 
                                    ? Colors.white 
                                    : _primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Control buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Hint button
                  Consumer<GameSettingsProvider>(
                    builder: (context, settings, child) {
                      final hasEnoughCoins = settings.coins >= 5;
                      return Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showHint,
                          icon: const Icon(Icons.lightbulb_outline, size: 20),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Hint'),
                              const SizedBox(width: 4),
                              Text(
                                '(5🪙)',
                                style: TextStyle(
                                  color: hasEnoughCoins ? Colors.white : Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: hasEnoughCoins ? Colors.amber : Colors.grey,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Restart button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _restartGame,
                      icon: const Icon(Icons.refresh, size: 20),
                      label: const Text('Restart'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: _primaryColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionOverlay() {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Center(
          child: Container(
            width: min(screenWidth * 0.85, 320),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: _primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emoji_events, color: Colors.white, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'LEVEL COMPLETE!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(
                            icon: Icons.grid_on,
                            value: '${widget.level.gridSize}x${widget.level.gridSize}',
                            label: 'Grid',
                          ),
                          _buildStatItem(
                            icon: Icons.done_all,
                            value: '${_foundWords.length}/${_wordsToFindInGrid.length}',
                            label: 'Words',
                          ),
                          _buildStatItem(
                            icon: Icons.monetization_on,
                            value: '+30',
                            label: 'Coins',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                widget.onLevelComplete();
                                if (widget.subject != null && widget.levelIndex + 1 < widget.totalLevels) {
                                  // Navigate to next level
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WordSearchGameScreen(
                                        level: widget.subject!.levels[widget.levelIndex + 1],
                                        levelIndex: widget.levelIndex + 1,
                                        totalLevels: widget.totalLevels,
                                        subject: widget.subject,
                                        onLevelComplete: () {
                                          Provider.of<GameProgressProvider>(context, listen: false)
                                              .markWordAsCompleted(widget.subject!.id, 'level_${widget.levelIndex + 1}');
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                widget.levelIndex + 1 < widget.totalLevels
                                    ? 'Next Level'
                                    : 'Finish',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _restartGame();
                        },
                        child: const Text('Play Again'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({required IconData icon, required String value, required String label}) {
    return Column(
      children: [
        Icon(icon, size: 24, color: _primaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}