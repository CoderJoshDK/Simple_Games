class Enemy {

  float x;
  float y;
  float r;
  
  color l;

  float xMove = 1;

  Enemy(int z, int q, color b) {
    x = z;
    y = q;
    r = 15;
    l = b;
  }

  void show() {
    fill(l);
    ellipse(x, y, r*2, r*2);
  }

  void move(float mult) {
    x += xMove * mult;
  }


  void shift() {
    y += 15;
    xMove *= -1;
  }
}