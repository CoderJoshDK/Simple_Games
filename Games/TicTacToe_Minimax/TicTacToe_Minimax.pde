String[][] board = {
  {"", "", ""}, 
  {"", "", ""}, 
  {"", "", ""}
};


String human = "O";
String ai = "X";
//String[] players = {"X", "O"};
//int currentPlayer;
String currentPlayer = human;
float w, h;

String result = null;

void setup() {
  size(800, 800);

  w = width / 3.0;
  h = height / 3.0;

  noFill();
  strokeWeight(4);
  //currentPlayer = floor(random(players.length));

  //Making a score dict
  scores.set("X", 1);
  scores.set("O", -1);
  scores.set("tie", 0);

  if (random(1) > 0.5) {
    bestMove();
  }
}

void mousePressed() {
  if (result != null) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        board[i][j] = "";
      }
    }
    result = null;
    if (random(1) > 0.5) {
      bestMove();
    } 
    currentPlayer = human;
  } else if (currentPlayer == human) {
    int j = floor(mouseX / w);
    int i = floor(mouseY / h);

    if (board[i][j] == "") {
      board[i][j] = human;
      currentPlayer = ai;
      result = checkWinner();
      bestMove();
    }
  }
}

void draw() {
  background(255);

  float xr = w/3;

  line(w, 0, w, height);
  line(w * 2, 0, w * 2, height);
  line(0, h, width, h);
  line(0, h*2, width, h*2);

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      float x = w * i + (w/2);
      float y = h * j + (h/2);
      String spot = board[j][i];
      if (spot == human) {
        ellipse(x, y, xr * 2.0, xr * 2.0);
      } else if (spot == ai) {
        line(x - xr, y - xr, x + + xr, y + xr);
        line(x + xr, y - xr, x - xr, y + xr);
      }
    }
  }

  if (result != null) {
    if (result == "tie") {
      println("Tie!");
    } else {
      println(result + " wins!");
    }
  }
}

boolean equals3(String a, String b, String c) {
  return (a == b && b == c && a != "");
}

String checkWinner() {
  String winner = null;

  ArrayList<PVector> available = new ArrayList<PVector>();
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == "") {
        available.add(new PVector(i, j));
      }
    }
  }

  // horizontal
  for (int i = 0; i < 3; i++) {
    if (equals3(board[i][0], board[i][1], board[i][2])) {
      winner = board[i][0];
    }
  }

  // Vertical
  for (int i = 0; i < 3; i++) {
    if (equals3(board[0][i], board[1][i], board[2][i])) {
      winner = board[0][i];
    }
  }

  // Diagonal
  if (equals3(board[0][0], board[1][1], board[2][2])) {
    winner = board[0][0];
  }
  if (equals3(board[2][0], board[1][1], board[0][2])) {
    winner = board[2][0];
  }

  if (winner == null && available.size() == 0) {
    return "tie";
  } else {
    return winner;
  }
}
