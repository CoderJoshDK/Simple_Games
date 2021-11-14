class Wall {

  PVector pos;
  float wi  = 15;
  float hi = h/2;

  Wall(int x, int y) {
    pos = new PVector(x, y);
  }

  void show() {
    fill(150);
    rectMode(CENTER);
    rect(pos.x, pos.y, wi, hi);
  }
}
