class Obsticals {

  PVector pos;
  PVector vel = PVector.random2D();

  float r = random(20, 50);

  int total = floor(random(5, 15));

  float[] offset = new float[total];

  Obsticals(PVector nPos, float rad) {
    if (rad != 99999) {
      r = rad * 0.45;
    }

    if (nPos != null) {

      float x = nPos.x;
      float y = nPos.y;

      pos = new PVector(x, y);
    } else {

      int rand = floor(random(4));

      if (rand == 0) {
        pos = new PVector(random(width), -r);
      } else if (rand == 1) {
        pos = new PVector(random(width), height + r);
      } else if (rand == 2) {
        pos = new PVector(-r, random(height));
      } else {
        pos = new PVector(width + r, random(height));
      }
    }

    for (int i = 0; i < total; i++) {
      offset[i] = random(-r / 2, r / 2);
    }
  }

  void update() {
    pos.add(vel);
    edges();
  }

  void edges() {
    if (pos.x > width + r) {
      pos.x = -r;
    } else if (pos.x < -r) {
      pos.x = width + r;
    }
    if (pos.y > height + r) {
      pos.y = -r;
    } else if (pos.y < -r) {
      pos.y = height + r;
    }
  }

  void breakup() {

    asteroids.add(new Obsticals(pos, r));
    asteroids.add(new Obsticals(pos, r));

    asteroids.remove(this);
  }

  void render() {

    pushMatrix();

    translate(pos.x, pos.y);
    
    noFill();
    stroke(255);

    beginShape();

    for (int i = 0; i < total; i++) {

      float angle = map(i, 0, total, 0, TAU);

      float off = r + offset[i];

      float x = off * cos(angle);
      float y = off * sin(angle);

      vertex(x, y);
    }

    endShape(CLOSE);

    popMatrix();
  }
}