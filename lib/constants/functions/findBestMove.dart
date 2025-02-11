import 'package:tictatctoe/constants/functions/emptyBoxes.dart';
import 'package:tictatctoe/constants/functions/makeMove.dart';
import 'package:tictatctoe/constants/functions/miniMax.dart';

int findBestMove(List<String> board, int filledBoxes) {
  int bestMove = -1;
  int bestScore = 1000;
  List<int> availableMoves = getAvailableMoves(board);
  for (int move in availableMoves) {
    // ***ایجاد کپی از صفحه بازی***
    List<String> newBoard = List.from(board); // مهم!
    makeMove(newBoard, move, "O");
    int score = minimax(newBoard, 0, filledBoxes + 1); // filledBoxes++
    if (score < bestScore) {
      bestScore = score;
      bestMove = move;
    }
  }
  return bestMove;
}
