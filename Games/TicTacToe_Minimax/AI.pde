void bestMove() {
  if (result == null) {

    //Making a list of available moves
    int bestScore = -2;
    PVector move = new PVector();
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        //Is the spot available
        if (board[i][j] == "") {
          board[i][j] = ai;
          int score = minimax(board, 0, false);
          board[i][j] = "";
          if (score > bestScore) {
            bestScore = score;
            move = new PVector(i, j);
          }
        }
      }
    }

    int i = (int) move.x;
    int j = (int) move.y;
    board[i][j] = ai;
    result = checkWinner();
    currentPlayer = human;
  }
}

IntDict scores = new IntDict();

int minimax(String[][] board, int depth, boolean isMaximizing) {
  String check = checkWinner();
  if (check != null) {
    return scores.get(check);
  }

  if (isMaximizing) {
    int bestScore = -2;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          board[i][j] = ai;
          int score = minimax(board, depth + 1, false);
          board[i][j] = "";
          bestScore = max(score, bestScore);
        }
      }
    }
    return bestScore;
  } else {
    int bestScore = 2;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          board[i][j] = human;
          int score = minimax(board, depth + 1, true);
          board[i][j] = "";
          bestScore = min(score, bestScore);
        }
      }
    }
    return bestScore;
  }
}
