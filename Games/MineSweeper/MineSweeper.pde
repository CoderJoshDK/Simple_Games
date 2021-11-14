int scl = 30;
int bombs = 99;

int cols;
int rows;

int amountToWin;

ArrayList<Cell> cells = new ArrayList<Cell>();

boolean gameOver = false;
boolean gameWon = false;

boolean firstClick = true;

boolean doBot = false;


void setup() {

  size(900, 480);

  cols = floor(width / scl);
  rows = floor(height / scl);

  println("Cols: " + cols);
  println("Rows: " + rows);
  println("Total: " + (rows * cols));

  for (int j = 0; j < rows; j++) {

    for (int i = 0; i < cols; i++) {

      Cell cell = new Cell(i, j);
      cells.add(cell);
    }
  }
}

void draw() {

  background(51);

  int shown = 0;

  for (Cell c : cells) {

    c.show();
    if (c.isClicked) {
      shown += 1;
    }
    if (shown == amountToWin && !firstClick) {
      gameWon = true;
    }
  }

  if (gameOver) {
    fill(0);
    textSize(100);
    textAlign(CENTER);
    text("YOU LOSE!", width / 2, height / 3);
  } else if (gameWon) {
    fill(0);
    textSize(100);
    textAlign(CENTER);
    text("YOU WIN!", width / 2, height / 3);
  }

  if (doBot && (!gameOver || !gameWon)) {
    bot();
    textSize(25);
    textAlign(CENTER);
    fill(0);
    text("bot", width / 2, height / 2);
  }
}

void keyPressed() {
  if (key == 'r') {
    restart();
  } else if (key == 'b') {
    doBot = !doBot;
  } else if (key == 's') {
    speed = !speed;
  } else if (key == 'q') {
    int i = floor(mouseX / scl);
    int j = floor(mouseY / scl);
    reavalueate(i, j);
    int index = i + (j * cols);
    println(cells.get(index).chance, cells.get(index + cols).chance);
  }
}

void restart() {
  firstClick = true;
  gameOver = false;
  gameWon = false;

  trys = 0;
  indexI = 0;
  indexJ = 0;

  cells = new ArrayList<Cell>();

  for (int j = 0; j < rows; j++) {

    for (int i = 0; i < cols; i++) {

      Cell cell = new Cell(i, j);
      cells.add(cell);
    }
  }
}

void mousePressed() {

  int i = floor(mouseX / scl);
  int j = floor(mouseY / scl);
  Cell c = cells.get(i + (j * cols));

  if (!gameOver && !gameWon) {
    if (mouseButton == LEFT) {
      if (firstClick) {

        addBomb(i, j);
        firstClick = false;
      }
      if (!c.isFlaged) {
        c.isClicked = true;
        clearAround(i, j, c);
      }
    } else if (mouseButton == RIGHT) {
      if (!c.isClicked || c.isFlaged) {
        c.isFlaged = !c.isFlaged;
      }
    }
  }
}

void clearAround(int i, int j, Cell c) {
  int flagged = 0;

  int index = i + (j * cols);

  if (i != cols - 1) {
    if (cells.get(index + 1).isFlaged) {
      flagged++;
    }
  }
  if (i != 0) {
    if (cells.get(index - 1).isFlaged) {
      flagged++;
    }
  }

  if (j != 0) {
    if (cells.get(index - cols).isFlaged) {
      flagged++;
    }
  }
  if (j != 0 && i != 0) {
    if (cells.get(index - cols - 1).isFlaged) {
      flagged++;
    }
  }
  if (j != 0 && i != cols - 1) {
    if (cells.get(index - cols + 1).isFlaged) {
      flagged++;
    }
  }

  if (j != rows - 1) {
    if (cells.get(index + cols).isFlaged) {
      flagged++;
    }
  }
  if (j != rows - 1 && i != 0) {
    if (cells.get(index + cols - 1).isFlaged) {
      flagged++;
    }
  }
  if (j != rows - 1 && i != cols - 1) {
    if (cells.get(index + cols + 1).isFlaged) {
      flagged++;
    }
  }

  if (flagged == c.nearBomb && !c.hasBomb) {

    if (!c.isFlaged) {

      c.completed = true;
      c.isClicked = true;
    }

    if (i != cols - 1) {
      if (!cells.get(index + 1).isClicked && !cells.get(index + 1).isFlaged) {
        cells.get(index + 1).isClicked = true;
        if (cells.get(index + 1).nearBomb == 0) {
          clearAround(i + 1, j, cells.get(index + 1));
        }
      }
    }
    if (i != 0) {
      if (!cells.get(index - 1).isClicked && !cells.get(index - 1).isFlaged) {
        cells.get(index - 1).isClicked = true;
        if (cells.get(index - 1).nearBomb == 0) {
          clearAround(i - 1, j, cells.get(index - 1));
        }
      }
    }

    if (j != 0) {
      if (!cells.get(index - cols).isClicked && !cells.get(index - cols).isFlaged) {
        cells.get(index - cols).isClicked = true;
        if (cells.get(index - cols).nearBomb == 0) {
          clearAround(i, j - 1, cells.get(index - cols));
        }
      }
    }
    if (j != 0 && i != 0) {
      if (!cells.get(index - cols - 1).isClicked && !cells.get(index - cols - 1).isFlaged) {
        cells.get(index - cols - 1).isClicked = true;
        if (cells.get(index - cols - 1).nearBomb == 0) {
          clearAround(i - 1, j - 1, cells.get(index  - cols - 1));
        }
      }
    }
    if (j != 0 && i != cols - 1) {
      if (!cells.get(index - cols + 1).isClicked && !cells.get(index - cols + 1).isFlaged) {
        cells.get(index - cols + 1).isClicked = true;
        if (cells.get(index - cols + 1).nearBomb == 0) {
          clearAround(i + 1, j - 1, cells.get(index - cols + 1));
        }
      }
    }

    if (j != rows - 1) {
      if (!cells.get(index + cols).isClicked && !cells.get(index + cols).isFlaged) {
        cells.get(index + cols).isClicked = true;
        if (cells.get(index + cols).nearBomb == 0) {
          clearAround(i, j + 1, cells.get(index + cols));
        }
      }
    }
    if (j != rows - 1 && i != 0) {
      if (!cells.get(index + cols - 1).isClicked && !cells.get(index + cols - 1).isFlaged) {
        cells.get(index + cols - 1).isClicked = true;
        if (cells.get(index + cols - 1).nearBomb == 0) {
          clearAround(i - 1, j + 1, cells.get(index + cols - 1));
        }
      }
    }
    if (j != rows - 1 && i != cols - 1) {
      if (!cells.get(index + cols + 1).isClicked && !cells.get(index + cols + 1).isFlaged) {
        cells.get(index + cols + 1).isClicked = true;
        if (cells.get(index + cols + 1).nearBomb == 0) {
          clearAround(i + 1, j + 1, cells.get(index + cols + 1));
        }
      }
    }
  }
}

void getCount() {


  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      int index = i + (j * cols);

      Cell c = cells.get(index);
      c.nearBomb = 0;

      if (i != cols - 1) {
        if (cells.get(index + 1).hasBomb) {
          c.nearBomb++;
        }
      }
      if (i != 0) {
        if (cells.get(index - 1).hasBomb) {
          c.nearBomb++;
        }
      }

      if (j != 0) {
        if (cells.get(index - cols).hasBomb) {
          c.nearBomb++;
        }
      }
      if (j != 0 && i != 0) {
        if (cells.get(index - cols - 1).hasBomb) {
          c.nearBomb++;
        }
      }
      if (j != 0 && i != cols - 1) {
        if (cells.get(index - cols + 1).hasBomb) {
          c.nearBomb++;
        }
      }

      if (j != rows - 1) {
        if (cells.get(index + cols).hasBomb) {
          c.nearBomb++;
        }
      }
      if (j != rows - 1 && i != 0) {
        if (cells.get(index + cols - 1).hasBomb) {
          c.nearBomb++;
        }
      }
      if (j != rows - 1 && i != cols - 1) {
        if (cells.get(index + cols + 1).hasBomb) {
          c.nearBomb++;
        }
      }
    }
  }
}

void addBomb(int i, int j) {

  int total = cols * rows;

  if (bombs > total) {
    bombs = total;
  }

  int totalBombs = 0;
  int trys = 0;

  while (totalBombs < bombs) {

    int q = floor(random(total));

    Cell c = cells.get(q);

    if (!c.hasBomb && c != cells.get(i + (j * cols))) {
      c.hasBomb = true;
      totalBombs++;
    }

    if (trys >= bombs * 10) {
      totalBombs = bombs;
    }
    trys++;
  }

  amountToWin = total - totalBombs;

  getCount();
}