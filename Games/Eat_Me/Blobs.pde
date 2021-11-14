class Blob {

  PVector location;
  PVector dir;
  float r;

  PVector slope;

  color insides = color(random(255), 255, 255);

  Blob(float rad) {

    r = rad;

    if (ens.size() % 5 == 0) {

      location = new PVector(random(width), (0 - r) + 1);

      slope = new PVector(location.x - random(width), 
        location.y - height);      
      slope.setMag(random(0.65, 1.75));
    } else if (ens.size() % 4 == 0) {

      location = new PVector((0 - r) + 1, random(height));

      slope = new PVector(location.x - width, 
        location.y - random(height));      
      slope.setMag(random(0.65, 1.75));
    } else if (ens.size() % 3 == 0) {

      location = new PVector((width + r) - 1, random(height));

      slope = new PVector(location.x - 0, 
        location.y - random(height));      
      slope.setMag(random(0.65, 1.75));
    } else {

      location = new PVector(random(width), (height + r) - 1);

      slope = new PVector(location.x - random(width), 
        location.y - 0);
      slope.setMag(random(0.65, 1.75));
    }
  }


  void show() {

    fill(insides);

    ellipse(location.x, location.y, r, r);
  }

  void move() {

    location.sub(slope);
  }

  boolean checkEdge(int locX, int locY, float rad) {

    if (location.x < -r || location.x > width + r) {

      return true;
    }

    if (location.y < -r || location.y > height + r) {

      return true;
    }

    float dist = dist(location.x, location.y, locX, locY);

    if (dist <= rad) {

      if (rad < r) {

        gameOver = true;
        
        if (mainR <= 50) {
          
          mainR = 50;
        }

        return false;
      }

      mainR += 0.5;
      score += 1;

      return true;
    }

    return false;
  }
}