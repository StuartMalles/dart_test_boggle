// https://dartpad.dev/ to execute
// Note - No dictionary or board validation is included.

void main() {
  const List<String> dictionary = [
    "GEEKS",
    "FOR",
    "QUIZ",
    "GO",
  ];

  const List<List<String>> board = [
    ["G", "I", "Z"],
    ["U", "E", "K"],
    ["Q", "S", "E"],
  ];

  Boggle(dictionary, board);
}

class Boggle {
  final List<String> dictionary;
  final List<List<String>> board;
  final List<String> foundWords = [];

  List<List<bool>> resetEvaluation() {
    return List.generate(
        board.length, (i) => List.generate(board[0].length, (j) => false));
  }

  bool isValidCell(r, c) {
    return ((r >= 0) && (c >= 0) && r < board.length && c < board[0].length);
  }

  bool isWord(String word) {
    return dictionary.contains(word);
  }

  bool containsWord(String word) {
    return dictionary.any(
      (e) {
        return e.contains(word);
      },
    );
  }

  void wordCheck(String wordPart, List<List<bool>> evaluated, int r, int c) {
    if (isValidCell(r, c)) {
      if (!evaluated[r][c]) {
        // Combine the wordPart with this letter and see if its in the dictionary.
        final String word = wordPart + board[r][c];
        final bool foundWord = isWord(word);

        if (foundWord) {
          foundWords.add(word);
        }
        
        // Even if the word is found, continue looking
        // If wordPart not found, no reason to continue looking.
        if ((foundWord) || (!foundWord && containsWord(word))) {
          evaluated[r][c] = true;

          // cycle through all adjacent cells keeping a copy of the state.
          wordCheck(word, evaluated.toList(), r + 0, c + 1);
          wordCheck(word, evaluated.toList(), r + 1, c + 1);
          wordCheck(word, evaluated.toList(), r + 1, c + 0);
          wordCheck(word, evaluated.toList(), r + 1, c - 1);
          wordCheck(word, evaluated.toList(), r + 0, c - 1);
          wordCheck(word, evaluated.toList(), r - 1, c - 1);
          wordCheck(word, evaluated.toList(), r - 1, c + 0);
          wordCheck(word, evaluated.toList(), r - 1, c + 1);
        }
      }
    }
  }

  Boggle(this.dictionary, this.board, {bool extendWords = false}) {
    // show dictionary
    print('Dictionary : $dictionary');
    print('');

    // show board
    for (var r = 0; r < board.length; r++) {
      print(board[r]);
    }

    // start top level evaluation for each cell
    for (var r = 0; r < board.length; r++) {
      for (var c = 0; c < board[r].length; c++) {
        wordCheck('', resetEvaluation(), r, c);
      }
    }

    // Show Results
    print('');
    print('Resuls : Found $foundWords');
  }
}
