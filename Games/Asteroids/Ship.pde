class Ship {

  PVector pos = new PVector(width / 2, height / 2);
  PVector vel = new PVector(0, 0);

  PVector[] points = new PVector[4];

  int r = 15;

  float heading = -HALF_PI;
  float rotaion = 0;

  float rand1 = 0;
  float rand2 = 0;
  float rand3 = 0;

  Boolean isBoosting = false;
  Boolean isSlowing = false;

  color inside = color(255);

  Ship() {
    points[0] = new PVector(-r, r);
    points[1] = new PVector(0, r / 2);
    points[2] = new PVector(r, r);
    points[3] = new PVector(0, -r);
  }

  void render() {

    pushMatrix();

    translate(pos.x, pos.y);
    rotate(heading + HALF_PI);

    fill(0);
    stroke(inside);

    beginShape();

    for (PVector p : points) {
      vertex(p.x, p.y);
    }

    endShape(CLOSE);

    if (isBoosting) {

      beginShape();

      stroke(255, 215, 215);

      if (frameCount % 3 == 0) {
        rand1 = random(4);
        rand2 = random(4);
        rand3 = random(4);
      }
      if (frameCount % 6 == 0) {
        rand1 = 0;
        rand2 = 0;
        rand3 = 0;
      }

      vertex(-r, r);
      vertex(0, r / 2);
      vertex(r, r);
      vertex(r / 2, r * 1.5 + rand1);
      vertex(0, r + rand2);
      vertex(-r / 2, r * 1.5 + rand3);


      endShape(CLOSE);
    }

    popMatrix();
  }

  void update() {
    if (isBoosting) {
      boost();
    } else if (isSlowing) {
      vel.mult(0.95);
    }
    pos.add(vel);
    vel.mult(0.975);
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

  void boost() {

    PVector force = PVector.fromAngle(heading);
    force.mult(0.2);
    vel.add(force);
  }

  void boosting(Boolean b) {
    isBoosting = b;
  }

  void slowing(Boolean s) {
    isSlowing = s;
  }

  void setRotation(float angle) {
    rotaion = angle;
  }

  void turn() {
    heading += rotaion;
  }

  Boolean hits(Obsticals a) {

    float d = dist(pos.x, pos.y, a.pos.x, a.pos.y);

    if (d < r + a.r) {
      return true;
    }

    return false;
  }
}
