import 'dart:math';

import 'package:wordleclone/widgets/GameBoard.dart';

class WordleGame {
  int rowID = 0;
  int letterID = 0;

  static String game_message = "";
  static String game_guess = "";
  static List<String> word_list = [
    "world",
    "fight",
    "brain",
    "plane",
    "earth",
    "robot",
  ];
  static bool gameOver = false;

  static List<Letter> wordleRow = List.generate(
    5,
        (index) => Letter("", 0),
  );

  List<List<Letter>> wordleBoard = List.generate(
    5,
        (index) =>
        List.generate(
          5,
              (index) => Letter("", 0),
        ),
  );

  void passTry() {
    rowID++;
    letterID = 0;
  }

  static void initGame() {
    final random = Random();
    int index = random.nextInt(word_list.length);
    game_guess = word_list[index].toUpperCase();
    print(game_guess);
  }

  void insertWord(index, word) {
    wordleBoard[rowID][index] = word;
  }

  bool checkWordExist(String word) {
    return word_list.contains(word);
  }


   void resetGame() {
    game_guess = "";
    game_message = "";


    for (int i = 0; i < 5; i++) {
      wordleRow[i] = Letter("", 0);
    }
  }

}



class Letter {
  String? letter;

  int code = 0;

  Letter(this.letter, this.code);
}
