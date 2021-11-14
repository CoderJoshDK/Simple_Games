boolean speed = false;
boolean logic = false;

int trys = 0;

int indexI = 0;
int indexJ = 0;

void bot() {

  if (gameOver) {
    restart();
  } else {

    if (trys < 50) {

      int k = floor(random(cols));
      int j = floor(random(rows));

      if (firstClick) {

        addBomb(k, j);
        firstClick = false;
      }

      Cell c = cells.get(k + (j * cols));

      c.isClicked = true;

      clearAround(k, j, c);

      if (c.nearBomb == 0) {
        trys = 999;
      }

      trys++;
    } else {

      if (!speed) {

        logic = true;

        for (int d = 0; d < 2; d++) {

          for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {
              Cell c = cells.get(i + (j * cols));

              if (c.isClicked && c.hasBomb) {
                gameOver = true;
              }

              if (!gameOver) {
                checkAndClear(i, j, c);
              }
            }
          }
        }
        if (logic && (!gameOver || !gameWon)) {

          for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {

              if (cells.get(i + (j * cols)).isClicked && !cells.get(i + (j * cols)).completed) {
                reavalueate(i, j);
              }
            }
          }
          for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {

              Cell c = cells.get(i + (j * cols));

              if (!c.isClicked && !c.isFlaged) {
                c.calculate();
                c.posibil.clear();
                checkAndClear(i, j, c);
              }
            }
          }

          Cell origanal = new Cell(-1, -1);
          Cell best = origanal;

          for (int i = 0; i < cols; i++) {

            for (int j = 0; j < rows; j++) {

              Cell c = cells.get(i + (j * cols));

              if (!c.isClicked && !c.isFlaged) {

                if (c.chance > best.chance) {
                  best = c;
                }
              }
            }
          }

          if (best != origanal) {
            best.isFlaged = true;
            //println(best.chance, best.i, best.j);
          } 

          for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {
              Cell c = cells.get(i + (j * cols));
              c.chance = 0;
              checkAndClear(i, j, c);
            }
          }
        }
      } else {

        Cell c = cells.get(indexI + (indexJ * cols));


        if (c.isClicked && !c.completed) {

          int n = arround(indexI, indexJ);

          if (n == c.nearBomb) {
            makeAroundFlaged(indexI, indexJ);
          }
          clearAround(indexI, indexJ, c);
        }
        l = 0;
        next();
      }
    }
  }
}

void checkAndClear(int i, int j, Cell c) {
  if (c.isClicked && !c.completed) {

    int n = arround(i, j);

    if (n == c.nearBomb) {
      logic = false;
      makeAroundFlaged(i, j);
    }
  }
  clearAround(i, j, c);
}

int l = 0;
void next() {
  indexI++;

  if (indexI == cols) {
    indexJ++;
    indexI = 0;
    if (indexJ == rows) {
      indexJ = 0;
    }
  }
  l++;
  if (l < cols * rows) {
    if (!cells.get(indexI +(indexJ * cols)).isClicked 
      && !cells.get(indexI +(indexJ * cols)).completed) {
      next();
    }
  }
}

void reavalueate(int i, int j) {

  int near = 0;

  int index = i + (j * cols);
  int left = cells.get(index).nearBomb;

  if (cells.get(index).nearBomb != 0) {

    if (i != cols - 1) {
      if (cells.get(index + 1).isFlaged) {
        left--;
      }
      if (!cells.get(index + 1).isClicked && !cells.get(index + 1).isFlaged) {
        near += 1;
      }
    }
    if (i != 0) {
      if (cells.get(index - 1).isFlaged) {
        left--;
      }
      if (!cells.get(index - 1).isClicked && !cells.get(index - 1).isFlaged) {
        near += 1;
      }
    }

    if (j != 0) {
      if (cells.get(index - cols).isFlaged) {
        left--;
      }
      if (!cells.get(index - cols).isClicked && !cells.get(index - cols).isFlaged) {
        near += 1;
      }
    }
    if (j != 0 && i != 0) {
      if (cells.get(index - cols - 1).isFlaged) {
        left--;
      }
      if (!cells.get(index - cols - 1).isClicked && !cells.get(index - cols - 1).isFlaged) {
        near += 1;
      }
    }
    if (j != 0 && i != cols - 1) {
      if (cells.get(index - cols + 1).isFlaged) {
        left--;
      }
      if (!cells.get(index - cols + 1).isClicked && !cells.get(index - cols + 1).isFlaged) {
        near += 1;
      }
    }

    if (j != rows - 1) {
      if (cells.get(index + cols).isFlaged) {
        left--;
      }
      if (!cells.get(index + cols).isClicked && !cells.get(index + cols).isFlaged) {
        near += 1;
      }
    }
    if (j != rows - 1 && i != 0) {
      if (cells.get(index + cols - 1).isFlaged) {
        left--;
      }
      if (!cells.get(index + cols - 1).isClicked && !cells.get(index + cols - 1).isFlaged) {
        near += 1;
      }
    }
    if (j != rows - 1 && i != cols - 1) {
      if (cells.get(index + cols + 1).isFlaged) {
        left--;
      }
      if (!cells.get(index + cols + 1).isClicked && !cells.get(index + cols + 1).isFlaged) {
        near += 1;
      }
    }
  }
  if (left > 0 && near > 0) {

    float x = ((100 * left) / near);

    if (i != cols - 1) {
      if (!cells.get(index + 1).isClicked && !cells.get(index + 1).isFlaged) {
        cells.get(index + 1).posibil.append(x);
      }
    }
    if (i != 0) {
      if (!cells.get(index - 1).isClicked && !cells.get(index - 1).isFlaged) {
        cells.get(index - 1).posibil.append(x);
      }
    }

    if (j != 0) {
      if (!cells.get(index - cols).isClicked && !cells.get(index - cols).isFlaged) {
        cells.get(index - cols).posibil.append(x);
      }
    }
    if (j != 0 && i != 0) {
      if (!cells.get(index - cols - 1).isClicked && !cells.get(index - cols - 1).isFlaged) {
        cells.get(index - cols - 1).posibil.append(x);
      }
    }
    if (j != 0 && i != cols - 1) {
      if (!cells.get(index - cols + 1).isClicked && !cells.get(index - cols + 1).isFlaged) {
        cells.get(index - cols + 1).posibil.append(x);
      }
    }

    if (j != rows - 1) {
      if (!cells.get(index + cols).isClicked && !cells.get(index + cols).isFlaged) {
        cells.get(index + cols).posibil.append(x);
      }
    }
    if (j != rows - 1 && i != 0) {
      if (!cells.get(index + cols - 1).isClicked && !cells.get(index + cols - 1).isFlaged) {
        cells.get(index + cols - 1).posibil.append(x);
      }
    }
    if (j != rows - 1 && i != cols - 1) {
      if (!cells.get(index + cols + 1).isClicked && !cells.get(index + cols + 1).isFlaged) {
        cells.get(index + cols + 1).posibil.append(x);
      }
    }
  } else {
    cells.get(index).completed = true;
  }
}

void clearAllAround(int i, int j) {

  int index = i + (j * cols);

  clearAround(i, j, cells.get(index));

  if (i != cols - 1) {
    clearAround(i + 1, j, cells.get(index + 1));
  }
  if (i != 0) {
    clearAround(i - 1, j, cells.get(index - 1));
  }
  if (j != 0) {
    clearAround(i, j - 1, cells.get(index - cols));
  }
  if (j != 0 && i != 0) {
    clearAround(i - 1, j - 1, cells.get(index - cols - 1));
  }
  if (j != 0 && i != cols - 1) {
    clearAround(i + 1, j - 1, cells.get(index - cols + 1));
  }
  if (j != rows - 1) {
    clearAround(i, j + 1, cells.get(index + cols));
  }
  if (j != rows - 1 && i != 0) {
    clearAround(i - 1, j + 1, cells.get(index + cols - 1));
  }
  if (j != rows - 1 && i != cols - 1) {
    clearAround(i + 1, j + 1, cells.get(index + cols + 1));
  }
}

void makeAroundFlaged(int i, int j) {

  int index = i + (j * cols);

  if (i != cols - 1) {
    if (!cells.get(index + 1).isFlaged && !cells.get(index + 1).isClicked) {
      cells.get(index + 1).isFlaged = true;
    }
  }
  if (i != 0) {
    if (!cells.get(index - 1).isFlaged && !cells.get(index - 1).isClicked) {
      cells.get(index - 1).isFlaged = true;
    }
  }

  if (j != 0) {
    if (!cells.get(index - cols).isFlaged && !cells.get(index - cols).isClicked) {
      cells.get(index - cols).isFlaged = true;
    }
  }
  if (j != 0 && i != 0) {
    if (!cells.get(index - cols - 1).isFlaged && !cells.get(index - cols - 1).isClicked) {
      cells.get(index - cols - 1).isFlaged = true;
    }
  }
  if (j != 0 && i != cols - 1) {
    if (!cells.get(index - cols + 1).isFlaged && !cells.get(index - cols + 1).isClicked) {
      cells.get(index - cols + 1).isFlaged = true;
    }
  }

  if (j != rows - 1) {
    if (!cells.get(index + cols).isFlaged && !cells.get(index + cols).isClicked) {
      cells.get(index + cols).isFlaged = true;
    }
  }
  if (j != rows - 1 && i != 0) {
    if (!cells.get(index + cols - 1).isFlaged && !cells.get(index + cols - 1).isClicked) {
      cells.get(index + cols - 1).isFlaged = true;
    }
  }
  if (j != rows - 1 && i != cols - 1) {
    if (!cells.get(index + cols + 1).isFlaged && !cells.get(index + cols + 1).isClicked) {
      cells.get(index + cols + 1).isFlaged = true;
    }
  }

  cells.get(index).completed = true;
}

int arround(int i, int j) {

  int near = 0;

  int index = i + (j * cols);

  if (cells.get(index).nearBomb != 0) {

    if (i != cols - 1) {
      if (!cells.get(index + 1).isClicked) {
        near += 1;
      }
    }
    if (i != 0) {
      if (!cells.get(index - 1).isClicked) {
        near += 1;
      }
    }

    if (j != 0) {
      if (!cells.get(index - cols).isClicked) {
        near += 1;
      }
    }
    if (j != 0 && i != 0) {
      if (!cells.get(index - cols - 1).isClicked) {
        near += 1;
      }
    }
    if (j != 0 && i != cols - 1) {
      if (!cells.get(index - cols + 1).isClicked) {
        near += 1;
      }
    }

    if (j != rows - 1) {
      if (!cells.get(index + cols).isClicked) {
        near += 1;
      }
    }
    if (j != rows - 1 && i != 0) {
      if (!cells.get(index + cols - 1).isClicked) {
        near += 1;
      }
    }
    if (j != rows - 1 && i != cols - 1) {
      if (!cells.get(index + cols + 1).isClicked) {
        near += 1;
      }
    }
  } else {
    near = 999;
  }

  return near;
}