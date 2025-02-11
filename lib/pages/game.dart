import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/boxes.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/functions/emptyBoxes.dart';
import 'package:tictatctoe/constants/functions/findBestMove.dart';
import 'package:tictatctoe/constants/functions/makeMove.dart';
import 'package:tictatctoe/data/gameLog.dart';
import 'package:tictatctoe/constants/functions/findWinner.dart';
import 'package:tictatctoe/constants/functions/navigator.dart';
import 'package:tictatctoe/pages/home.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.gameType, required this.isAiMode});

  final int gameType;
  final bool isAiMode;

  @override
  State<GamePage> createState() => _GamePageState(gameType, isAiMode);
}

class _GamePageState extends State<GamePage> {
  _GamePageState(this.gameType, this.isAIMode);

  final int gameType;
  final bool isAIMode;

  List<String> boxes = new List.filled(9, ''); // Array of 3x3 box
  String winner = ''; // Variable for saving winner.

  int filledBoxes = 0; // Count of filled boxes.
  bool gameEnded = false; // Saves game status ( True [Ended] , False )
  bool playerWon = false; // Saves the win status.
  bool isTurnX = true; // Is turn for X ? [True [X Turn] , False [O Turn] ]

  // Saves scores and ties count
  int p1Score = 0;
  int p2Score = 0;
  int ties = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getBar(),
      body: SafeArea(
        child: _getGameBody(),
      ),
    );
  }

  // Main method of the page
  Widget _getGameBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 30),
          _gridView(),
          SizedBox(height: 60),
          _scoreBoard(),
          SizedBox(height: 20),
          Visibility(
            visible: gameEnded,
            child: _winBox(),
          ),
        ],
      ),
    );
  }

  // Used for saving game logs [Index => Month]
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Returns now date in a format of "Month DayNumber, H:M"
  String _getDate() {
    DateTime now = DateTime.now();
    int month = now.month;
    int day = now.day;
    int hour = now.hour;
    int minute = now.minute;
    String fixed_minute = minute < 10 ? ("0${minute}") : minute.toString();
    String now_month = months[(month - 1)];
    return "${now_month} ${day}, ${hour}:${fixed_minute}";
  }

  // Returns the 3x3 grid of game
  GridView _gridView() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 9,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          setState(() {
            // Check if box is empty and game is not ended.
            if (boxes[index] == "" && !gameEnded) {
              // If is not ai mode, put the O. If is ai mode Do nothing.
              isTurnX
                  ? makeMove(boxes, index, 'X')
                  : (isAIMode ? () : makeMove(boxes, index, 'O'));

              winner = findWinner(boxes, filledBoxes); // Find winner

              // Check if there is no win.
              if (winner != "X" && winner != "O") {
                // AI move ( Only if AI mode enabled )
                if (isAIMode) {
                  int bestMove = findBestMove(boxes, filledBoxes);

                  if (bestMove > 0) {
                    // Check if best move is effecting on a empty box.
                    while (boxes[bestMove] != '') {
                      bestMove = findBestMove(boxes, filledBoxes);
                    }

                    // Put the 'O' in  'bestMove' index of box
                    makeMove(boxes, bestMove, 'O');
                    winner = findWinner(boxes, filledBoxes);
                    winner == "" ? () : setWin(winner);
                  } else {
                    // Find empty boxes
                    List<int> emptyBoxes = getAvailableMoves(boxes);

                    // Randomly select one box and put O
                    if (emptyBoxes.length > 0) {
                      int randomIndex = Random().nextInt(emptyBoxes.length);

                      while (boxes[randomIndex] != '') {
                        randomIndex = findBestMove(boxes, filledBoxes);
                      }

                      makeMove(boxes, randomIndex, 'O');
                      winner = findWinner(boxes, filledBoxes);
                      winner == "" ? () : setWin(winner);
                    }
                  }
                }
                // Change the turn ( Only for PvP ).
                isAIMode ? () : isTurnX = !isTurnX;

                // Increase count of filled boxes. ( Increases 2 time for AI mode, One for player move and one for ai )
                isAIMode ? filledBoxes += 2 : filledBoxes++;
              } else {
                setWin(winner);
              }
            }
          });
        },
        child: _getBox(index),
      ),
    );
  }

  void setWin(String winner) {
    gameEnded = true;

    // Save the history of this match
    switch (winner) {
      case 'X':
        p1Score++;
        games.add(Gamelog(gameType, 'Player (X) Won', _getDate()));
        break;

      case 'O':
        p2Score++;
        games.add(Gamelog(
            gameType, isAIMode ? 'AI (O) Won' : 'Player (O) Won', _getDate()));
        break;

      case 'Draw':
        ties++;
        games.add(Gamelog(gameType, 'Draw', _getDate()));
        break;

      default:
    }
  }

  // Each square of 3x3 grid.
  Container _getBox(int index) {
    return Container(
      width: 100,
      margin: EdgeInsets.all(4),
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.boxGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          boxes[index],
          style: TextStyle(
            fontFamily: 'Tahoma',
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: boxes[index] == "X" ? AppColors.purple : AppColors.blue,
          ),
        ),
      ),
    );
  }

  void resetGame() {
    boxes = List.filled(9, '');
    gameEnded = !gameEnded;

    // Change the turn ( Only for PvP ).
    isAIMode ? () : isTurnX = !isTurnX;
    playerWon = false;
    filledBoxes = 0;
    winner = '';
  }

  // Winner box that gets visible when someone wins.
  Column _winBox() {
    return Column(
      children: [
        Text(
          winner != "Draw" ? "Player ${winner} Won!" : "Draw",
          style: TextStyle(
            fontFamily: 'Tahoma',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.purple,
          ),
        ),
        SizedBox(height: 10),
        Text(
          winner != "Draw"
              ? "Congratulations! Want to play again?"
              : "No problem! Why don't try again?",
          style: TextStyle(
            fontFamily: 'Tahoma',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.lightGrey,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              resetGame();
            });
          },
          child: Text(
            "Play Again",
            style: TextStyle(
              fontFamily: 'Tahoma',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            minimumSize: Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Nav().gotoPage(HomePage(), context);
          },
          child: Text(
            "Back to Home",
            style: TextStyle(
              fontFamily: 'Tahoma',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            minimumSize: Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey[400]!, width: 2),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Container _scoreBoard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.boxGrey,
      ),
      height: 65,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Player (X)",
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 13,
                  color: AppColors.lightGrey,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "${p1Score}",
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 18,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ties",
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 13,
                  color: AppColors.lightGrey,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "${ties}",
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 18,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gameType == 0 ? "Player (O)" : "AI (O)",
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 13,
                  color: AppColors.lightGrey,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "${p2Score}",
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 18,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // App Header
  AppBar _getBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,

      // Title shows the turn of player ( Only changes if game mode be PvP)
      title: Text(
        isTurnX ? "Turn X" : "Turn O",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              resetGame();
            });
          },
          icon: Icon(Icons.refresh, color: AppColors.grey),
        )
      ],
    );
  }
}
