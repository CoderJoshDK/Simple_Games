class Player {

  PVector pos = new PVector(0, 40);
  PVector grav = new PVector(0, 0.4);
  PVector vel = new PVector(random(-1, 1), 0);

  boolean go = false;

  int size = 12;
  float m = 1;

  float damping = 0.8;

  color inside = color(random(50, 220), 255, 255);

  Player() {
  }

  void update() {

    if (!go) {
      pos.x = mouseX;
    } else {
      vel.add(grav);
      pos.add(vel);

      checkBoundaryCollision();

      for (Peg p : pegs) {

        //hit(p);
        checkCollision(p);
      }
      for (Wall w : walls) {
        if (pos.y + vel.y + size >= w.pos.y - w.hi/2) {
          if (pos.x + vel.x + size >= w.pos.x - w.wi/2 && pos.x + vel.x - size <= w.pos.x + w.wi/2) {
            vel.x *= -damping;
          }

        }
      }
    }
  }

  void hit(Peg p) {
    //test thingy
    PVector distanceVect = PVector.sub(p.pos, pos);

    float distanceVectMag = distanceVect.mag();

    float minDistance = size + peg_size;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      pos.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(-theta);
      float cosine = cos(-theta);

      vel.x += cosine;
      vel.y += sine;
    }
  }

  void checkCollision(Peg other) {

    // Get distances between the balls components
    PVector distanceVect = PVector.sub(other.pos, pos);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = size + peg_size;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      pos.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball poss. You 
       just need to worry about bTemp[1] pos*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's pos is relative to the other
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].pos.x and bTemp[0].pos.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * vel.x + sine * vel.y;
      vTemp[0].y  = cosine * vel.y - sine * vel.x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final vel along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated vel for b[0]
      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;

      // final rotated vel for b[0]
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball poss and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;

      pos.add(bFinal[0]);

      // update velocities
      vel.x = (cosine * vFinal[0].x - sine * vFinal[0].y);
      vel.y = (cosine * vFinal[0].y + sine * vFinal[0].x);
    }
  }


  void checkBoundaryCollision() {
    if (pos.x > width-size) {
      pos.x = width-size;
      vel.x *= -damping;
    } else if (pos.x < size) {
      pos.x = size;
      vel.x *= -damping;
    } else if (pos.y > height-size) {
      pos.y = height-size;
      vel.y *= -damping;
      vel.x *= damping;
    } else if (pos.y < size) {
      pos.y = size;
      vel.y *= -damping;
    }
  }

  void show() {

    fill(inside);
    ellipse(pos.x, pos.y, size * 2, size * 2);
  }
}
