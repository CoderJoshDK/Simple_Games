Ship ship;
ArrayList<Obsticals> asteroids = new ArrayList<Obsticals>();
ArrayList<Laser> lasers = new ArrayList<Laser>();

int score = 0;

Boolean dead = false;

void setup() {

  size(1080, 720);

  ship = new Ship();

  for (int i = 0; i < 3; i++) {
    asteroids.add(new Obsticals(null, 99999));
  }
}

void draw() {
  background(0);

  for (Obsticals a : asteroids) {

    if (ship.hits(a)) {
      dead = true;
      ship.inside = color(255, 0, 0);
      println(score);
    }

    a.render();
    a.update();
  }

  for (int i = lasers.size() - 1; i >= 0; i--) {

    Laser l = lasers.get(i);

    l.render();
    l.update();

    for (int j = asteroids.size() - 1; j >= 0; j--) {

      Obsticals a = asteroids.get(j);

      if (l.hits(a)) {
        if (a.r > 15) {
          a.breakup();
          if (!dead) {
            score++;
          }
        } else {
          asteroids.remove(a);
          if (!dead) {
            score++;
          }
        }

        lasers.remove(l);
      }
    }
    if (l.offscreen()) {
      lasers.remove(l);
    }
  }

  ship.render();
  ship.turn();
  ship.update();
  ship.edges();

  if (frameCount % 20 == 0) {
    if (asteroids.size() < 20) {
      asteroids.add(new Obsticals(null, 99999));
    }
  }

  if (dead) {
    textAlign(CENTER);

    textSize(50);
    fill(255);
    text("You have lost", width / 2, height / 2);

    textSize(35);
    fill(200, 200);
    text("Score: " + score, width / 2, height / 2 + 45);

    textSize(25);
    fill(200, 200);
    text("Hit 'r' to reset", width / 2, height / 2 + 75);
  }
}

void keyPressed() {

  if (dead) {

    if (key == 'r') {

      ship = new Ship();

      asteroids.clear();
      lasers.clear();

      for (int i = 0; i < 3; i++) {
        asteroids.add(new Obsticals(null, 99999));
      }

      score = 0;
      dead = false;
    }
  }

  if (key == ' ') {

    lasers.add(new Laser(ship.pos, ship.heading));
  }

  if (keyCode == RIGHT || key == 'd') {
    ship.setRotation(0.1);
  }  
  if (keyCode == LEFT || key == 'a') {
    ship.setRotation(-0.1);
  }  
  if (keyCode == UP || key == 'w') {
    ship.boosting(true);
  }
  if (keyCode == DOWN || key == 's') {
    ship.slowing(true);
  }
}

void mousePressed() {
  lasers.add(new Laser(ship.pos, ship.heading));
}

void keyReleased() {
  if (keyCode == LEFT || key == 'a' || keyCode == RIGHT || key == 'd') {
    ship.setRotation(0);
  }

  if (keyCode == UP || key == 'w') {
    ship.boosting(false);
  }
  if (keyCode == DOWN || key == 's') {
    ship.slowing(false);
  }
}
