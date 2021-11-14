class Attack {

  float x, y, r;
  boolean delete = false;

  Attack(float z, float q) {
    x = z;
    y = q;
    r = 10;
  }

  void show() {
    noStroke();
    fill(60, 0, 210);
    ellipse(x, y, 15, 20);
  }

  void move(float mult) {
    y -= 8 * mult;
  }

  void disp() {
    delete = true;
  }
}