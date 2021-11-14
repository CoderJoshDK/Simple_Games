class Bird {

  PVector pos;

  PVector gravity = new PVector(0, 0.4);
  PVector vel = new PVector(0, 0);

  PVector lift = new PVector(0, -10);
  
  
  int size = 32;

  Bird() {

    pos = new PVector(75, height / 2);
  }

  void update() {

    vel.add(gravity);
    pos.add(vel);

    vel.mult(0.95);

    if (pos.y > height) {
      pos.y = height;
      vel.mult(0);
    }

    if (pos.y < 0) {
      pos.y = 0;
      vel.mult(0);
    }
  }

  void up() {

    vel.add(lift);
    pos.add(vel);
  }

  void show() {

    fill(120, 21, 234);

    ellipse(pos.x, pos.y, size, size);
  }
}