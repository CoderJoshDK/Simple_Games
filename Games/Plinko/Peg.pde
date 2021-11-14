class Peg {

  PVector pos = new PVector();
  float m = 10;

  Peg(int x, int y) {
    pos.x = x;
    pos.y = y;
  }



  void show() {

    fill(255, 255, 255);
    ellipse(pos.x, pos.y, peg_size * 2, peg_size * 2);
  }
}
