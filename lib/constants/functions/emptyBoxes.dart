List<int> getAvailableMoves(List<String> board) {
  List<int> availableMoves = [];
  for (int i = 0; i < board.length; i++) {
    if (board[i] == "") {
      availableMoves.add(i);
    }
  }
  return availableMoves;
}
