class Cell {

  int i;
  int j;

  int nearBomb = 0;

  boolean hasBomb = false;
  boolean isClicked = false;
  boolean isFlaged = false;

  boolean completed = false;

  FloatList posibil = new FloatList();
  float chance = 0;

  Cell(int i, int j) {

    this.i = i;
    this.j = j;
  }

  void calculate() {
    
    for (float p : posibil) {
      chance += p;
      if (p >= 99){
        chance += p * 3;
      }
    }
    
    chance /= posibil.size();
  }

  void show() {

    int x = i * scl;
    int y = j * scl;

    stroke(0);
    strokeWeight(2);

    fill(200);

    if (isFlaged || (gameWon && hasBomb)) {
      fill(255, 0, 0);
    } else if (isClicked) {
      fill(200, 150, 255);
    }

    rect(x, y, scl, scl);

    if (gameOver || gameWon) {
      if (hasBomb) {
        fill(155);
        ellipseMode(CORNER);
        float smulScl = scl / 1.5;
        ellipse(x + smulScl / 3.5, y + smulScl / 3.5, smulScl, smulScl);
      }
    }

    textSize(scl);
    textAlign(CORNER);

    if (isClicked) {
      if (hasBomb) {
        gameOver = true;
        fill(255, 0, 0);
        text("X", x + scl / 5, y + scl - 2);
      } else if (nearBomb == 1) {
        fill(0, 0, 255);
        text("1", x + scl / 5, y + scl - 2);
      } else if (nearBomb == 2) {
        fill(0, 255, 0);
        text("2", x + scl / 5, y + scl - 2);
      } else if (nearBomb == 3) {
        fill(255, 0, 0);
        text("3", x + scl / 5, y + scl - 2);
      } else if (nearBomb == 4) {
        fill(0, 0, 150);
        text("4", x + scl / 5, y + scl - 2);
      } else if (nearBomb == 5) {
        fill(150, 0, 0);
        text("5", x + scl / 5, y + scl - 2);
      } else if (nearBomb == 6) {
        fill(100, 255, 100);
        text("6", x + scl / 5, y + scl - 2);
      } else if (nearBomb == 7) {
        fill(100, 100, 255);
        text("7", x + scl / 5, y + scl - 2);
      } else if (nearBomb == 8) {
        fill(100);
        text("8", x + scl / 5, y + scl - 2);
      }
    }
  }
}