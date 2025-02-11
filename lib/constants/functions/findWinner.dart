String findWinner(List<String> boxes, int filledBoxes) {
  if (boxes[1] == boxes[0] && boxes[2] == boxes[0] && boxes[0] != "") {
    return boxes[0];
  } else if (boxes[4] == boxes[3] && boxes[5] == boxes[3] && boxes[3] != "") {
    return boxes[3];
  } else if (boxes[7] == boxes[6] && boxes[8] == boxes[6] && boxes[6] != "") {
    return boxes[6];
  } else if (boxes[3] == boxes[0] && boxes[6] == boxes[0] && boxes[0] != "") {
    return boxes[0];
  } else if (boxes[4] == boxes[1] && boxes[7] == boxes[1] && boxes[1] != "") {
    return boxes[1];
  } else if (boxes[5] == boxes[2] && boxes[8] == boxes[2] && boxes[2] != "") {
    return boxes[2];
  } else if (boxes[4] == boxes[2] && boxes[6] == boxes[2] && boxes[2] != "") {
    return boxes[2];
  } else if (boxes[4] == boxes[0] && boxes[8] == boxes[0] && boxes[0] != "") {
    return boxes[0];
  } else if (filledBoxes >= 9) {
    return "Draw";
  }
  return '';
}
