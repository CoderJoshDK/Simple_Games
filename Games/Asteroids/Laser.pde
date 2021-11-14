class Laser {

  PVector pos;
  PVector vel;

  Laser(PVector sPos, float angle) {

    pos = new PVector(sPos.x, sPos.y);
    vel = PVector.fromAngle(angle);
    vel.mult(6);
  }

  void update() {

    pos.add(vel);
  }

  void render() {

    stroke(255);
    strokeWeight(4);

    point(pos.x, pos.y);

    strokeWeight(1);
  }

  Boolean offscreen() {

    if (pos.x > width || pos.x < 0) {
      return true;
    } 
    if (pos.y > height || pos.y < 0) {
      return true;
    }

    return false;
  }

  Boolean hits(Obsticals a) {

    float d = dist(pos.x, pos.y, a.pos.x, a.pos.y);

    if (d < a.r) {
      return true;
    }

    return false;
  }
}