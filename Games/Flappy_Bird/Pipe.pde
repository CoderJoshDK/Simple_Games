class Pipe {

  float top;
  float bottom;
  float x;

  float openSpace;

  int w = 30;
  int speed = 2;

  color pipeColor = color(0, 255, 0);

  boolean scored = false;

  Pipe() {

    openSpace = random(bird.size * 3, bird.size * 4);

    top = random(openSpace / 2, height - openSpace * 2);
    bottom = top + openSpace;
    //println(top, bottom, openSpace);

    x = width;
  }

  void show() {

    fill(pipeColor);

    rect(x, 0, w, top);
    rect(x, bottom, w, height - bottom);
  }

  void update() {
    x -= speed;
  }

  boolean hits(Bird bird) {

    if (bird.pos.y - bird.size / 2 < top || 
      bird.pos.y + bird.size / 2 > bottom) {

      if (bird.pos.x + bird.size / 2 > x && 
        bird.pos.x - bird.size / 2 < x + w) {

        pipeColor = color(255, 0, 0);
        return true;
      }
    }

    return false;
  }

  boolean score(Bird bird) {

    if (!scored) {

      if (bird.pos.x > x + (w / 2)) {
        
        scored = true;
        return true;
      }
    }

    return false;
  }
}