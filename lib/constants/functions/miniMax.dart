import 'dart:math';

import 'package:tictatctoe/constants/functions/emptyBoxes.dart';
import 'package:tictatctoe/constants/functions/findWinner.dart';
import 'package:tictatctoe/constants/functions/makeMove.dart';

int minimax(List<String> board, int depth, int filledBoxes) {
  String? result = findWinner(board, filledBoxes);
  if (result != '') {
    if (result == "X") {
      return 10 - depth;
    } else if (result == "O") {
      return depth - 10;
    } else {
      return 0;
    }
  }

  List<int> availableMoves = getAvailableMoves(board);

  if (depth % 2 != 0) {
    // نوبت بازیکن ('O')
    int bestScore = 1000;
    for (int move in availableMoves) {
      // ***ایجاد کپی از صفحه بازی***
      List<String> newBoard = List.from(board); // مهم!

      makeMove(newBoard, move, "O");
      int score =
          minimax(newBoard, depth + 1, filledBoxes + 1); // filledBoxes++
      bestScore = min(bestScore, score);
    }
    return bestScore;
  } else {
    // نوبت حریف ('X')
    int bestScore = -1000;
    for (int move in availableMoves) {
      // ***ایجاد کپی از صفحه بازی ***
      List<String> newBoard = List.from(board); // مهم!

      makeMove(newBoard, move, "X");
      int score =
          minimax(newBoard, depth + 1, filledBoxes + 1); // filledBoxes++
      bestScore = max(bestScore, score);
    }
    return bestScore;
  }
}
