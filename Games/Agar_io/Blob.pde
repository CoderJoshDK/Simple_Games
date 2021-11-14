class Blob {

  PVector pos;
  PVector vel = new PVector(0, 0);

  float r;

  color inside = color(random(255), 255, 255);

  Blob(float x, float y, float r) {

    pos = new PVector(x, y);
    this.r = r;
  }

  void update() {

    PVector newvel = new PVector(mouseX - width / 2, mouseY - height / 2);

    newvel.setMag(3);
    vel.lerp(newvel, 0.1);

    pos.add(vel);
    
    pos.x = constrain(pos.x, -width * 4, width * 4);
    pos.y = constrain(pos.y, -height * 4, height * 4);
  }

  boolean eats(Blob other) {

    float dist = PVector.dist(pos, other.pos);

    if (r - other.r > 5) {
      
      if ( dist < r) {
      
        float sum = (PI * (r * r)) + (PI * (other.r * other.r));
        r = sqrt(sum / PI);

        //r += other.r * 0.22;

        return true;
      }
    }

    return false;
  }

  void show() {

    fill(inside); 
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
}