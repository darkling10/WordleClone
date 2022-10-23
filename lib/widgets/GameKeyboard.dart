import 'package:flutter/material.dart';
import 'package:wordleclone/utils/game_provider.dart';
import 'package:wordleclone/widgets/GameBoard.dart';

class GameKeyboard extends StatefulWidget {
  GameKeyboard(this.game, {Key? key}) : super(key: key);
  WordleGame game;

  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  List row1 = "QWERTYUIOP".split("");
  List row2 = "ASDFGHJKL".split("");
  List row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          WordleGame.game_message,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 10.0,
        ),
        GameBoard(
          (widget.game),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row1.map(
            (e) {
              return InkWell(
                onTap: () {
                  print(e);
                  if (widget.game.letterID < 5) {
                    print(widget.game.rowID);

                    setState(() {
                      widget.game
                          .insertWord(widget.game.letterID, Letter(e, 0));
                      widget.game.letterID++;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Text(
                    "${e}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row2.map(
            (e) {
              return InkWell(
                onTap: () {
                  if (widget.game.letterID < 5) {
                    print(widget.game.rowID);

                    setState(() {
                      widget.game
                          .insertWord(widget.game.letterID, Letter(e, 0));
                      widget.game.letterID++;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Text(
                    "${e}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row3.map(
            (e) {
              return InkWell(
                onTap: () {
                  if (e == "DEL") {
                    if (widget.game.letterID > 0) {
                      setState(() {
                        widget.game.insertWord(
                            widget.game.letterID - 1, Letter("", 0));
                        widget.game.letterID--;
                      });
                    }
                  } else if (e == "SUBMIT") {
                    // setting the game rules
                    // print("SUbmittinh");
                    if (widget.game.letterID >= 5) {
                      /* widget.game.wordleBoard[widget.game.rowID].replaceRange(
                      0,
                      5,
                      List.generate(5, (index) => Letter("", 3)),
                    ); */
                      String guess = widget.game.wordleBoard[widget.game.rowID]
                          .map((e) => e.letter)
                          .join();
                      // print("Check my word");
                      // print(WordleGame.game_guess);
                      if (widget.game.checkWordExist(guess.toLowerCase())) {
                        if (guess == WordleGame.game_guess) {
                          setState(() {
                            WordleGame.game_message = "Congratulations🎉";
                            widget.game.wordleBoard[widget.game.rowID]
                                .forEach((element) {
                              element.code = 1;
                            });
                          });
                        } else {
                          print("Hiiii");
                          int listLength = guess.length;
                          for (int i = 0; i < listLength; i++) {
                            String char = guess[i].toUpperCase();
                            print(
                                "the test: ${WordleGame.game_guess.contains(char)}");
                            if (WordleGame.game_guess.contains(char)) {
                              if (WordleGame.game_guess[i] == char) {
                                setState(() {
                                  print(char);
                                  widget.game.wordleBoard[widget.game.rowID][i]
                                      .code = 1;
                                });
                              } else {
                                setState(() {
                                  print(char);
                                  widget.game.wordleBoard[widget.game.rowID][i]
                                      .code = 2;
                                });
                              }
                            }
                          }

                          widget.game.rowID++;
                          widget.game.letterID = 0;
                        }
                      } else {
                        print("Trig!!!!!not equal");
                        print("Hiiii");
                        int listLength = guess.length;
                        for (int i = 0; i < listLength; i++) {
                          String char = guess[i].toUpperCase();
                          print(
                              "the test: ${WordleGame.game_guess.contains(char)}");
                          if (WordleGame.game_guess.contains(char)) {
                            if (WordleGame.game_guess[i] == char) {
                              setState(() {
                                print(char);
                                widget.game.wordleBoard[widget.game.rowID][i]
                                    .code = 1;
                              });
                            } else {
                              setState(() {
                                print(char);
                                widget.game.wordleBoard[widget.game.rowID][i]
                                    .code = 2;
                              });
                            }
                          }
                        }

                        setState(() {
                          WordleGame.game_message =
                              "The word does not exist try again😢";
                          widget.game.rowID++;
                          widget.game.letterID = 0;
                        });
                      }
                    }
                  } else {
                    if (widget.game.letterID < 5) {
                      print(widget.game.rowID);

                      setState(() {
                        widget.game
                            .insertWord(widget.game.letterID, Letter(e, 0));
                        widget.game.letterID++;
                      });
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Text(
                    "${e}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(
                  () {
                    widget.game.rowID = 0;
                    widget.game.letterID = 0;
                    for (int i = 0; i < 5; i++) {
                      for (int j = 0; j < 5; j++) {
                        widget.game.wordleBoard[i][j] = Letter("", 0);
                      }
                    }
                    WordleGame.initGame();
                  },
                );
              },
              child: Text("Reset"),
              // style: ButtonStyle(backgroundColor: Colors.white),
            )
          ],
        )
      ],
    );
  }
}
