Ship ship;

ArrayList<Enemy> highPoints = new ArrayList<Enemy>();
ArrayList<Enemy> medPoints = new ArrayList<Enemy>();
ArrayList<Enemy> lowPoints = new ArrayList<Enemy>();
ArrayList<Attack> fire = new ArrayList<Attack>();

int move;
int score = 0;
int highscore = 0;
int wave = 1;

float gameSpeed = 1;
float waveSize = 5;

boolean tryFire = false;
boolean canFire = true;
boolean waveEnd = true;
boolean gameOver = false;
boolean playGame = false;

boolean displayWaveMSG = true;
int startTime;
final int display_dur = 1500;

color playColor = color(250);
color quitColor = color(250);

void setup() {

  size(720, 480);
  frameRate(50);
  ship = new Ship();
}

void draw() {

  if (playGame) {

    if (!gameOver) {

      background(51);

      ship.show();
      boolean edge = false;

      if (waveEnd) {

        if (displayWaveMSG) {
          displayWave();
        } else {

          wave += 1;
          canFire = true;

          for (int i = 0; i < 10; i++) {
            Enemy topLev = new Enemy(i*60+60, 80, color(200, 0, 150));
            highPoints.add(topLev);
          }

          for (int i = 0; i < 10; i++) {
            Enemy nlev = new Enemy(i*60+60, 130, color(50, 150, 100));
            medPoints.add(nlev);
          }

          for (int i = 0; i < 10; i++) {
            Enemy nlev = new Enemy(i*60+60, 180, color(50, 150, 100));
            medPoints.add(nlev);
          }

          for (int i = 0; i < 10; i++) {
            Enemy nlev = new Enemy(i*60+60, 230, color(150, 50, 100));
            lowPoints.add(nlev);
          }

          for (int i = 0; i < 10; i++) {
            Enemy nlev = new Enemy(i*60+60, 280, color(150, 50, 100));
            lowPoints.add(nlev);
          }

          for (int i = 0; i < 10; i++) {
            Enemy lowst = new Enemy(i*60+60, 330, color(150, 50, 100));
            lowPoints.add(lowst);
          }

          waveEnd = false;
          gameSpeed *= 1.15;
        }
      }


      if (tryFire) {
        if (canFire) {
          Attack attack = new Attack(ship.x + 10, height - 20);
          fire.add(attack);
          canFire = false;
        }
      }

      ship.move(move);

      //highPoints
      for (Enemy h : highPoints) {
        h.move(gameSpeed);
        h.show();
        if ((h.x > width - h.r) || (h.x < h.r)) {
          edge = true;
        }
        if (h.y > height - h.r - 25) {
          gameOver = true;
          playGame = false;
        }
      }
      //medPoints
      for (Enemy m : medPoints) {

        m.move(gameSpeed);
        m.show();
        if ((m.x > width - m.r) || (m.x < m.r)) {
          edge = true;
        }
        if (m.y > height - m.r - 25) {
          gameOver = true;
          playGame = false;
        }
      }
      //lowPoints
      for (Enemy l : lowPoints) {

        l.move(gameSpeed);
        l.show();
        if ((l.x > width - l.r) || (l.x < l.r)) {
          edge = true;
        }
        if (l.y > height - l.r - 25) {
          gameOver = true;
          playGame = false;
        }
      }

      if (edge) {
        for (Enemy h : highPoints) {
          h.shift();
        }
        for (Enemy m : medPoints) {
          m.shift();
        }
        for (Enemy l : lowPoints) {
          l.shift();
        }
      }

      for (int i = fire.size()-1; i >= 0; i--) {
        Attack a = fire.get(i);
        a.move(gameSpeed);
        a.show();
        for (int j = highPoints.size()-1; j >= 0; j--) {
          Enemy h = highPoints.get(j);
          float d = dist(a.x, a.y, h.x, h.y);
          if (d < a.r + h.r) {
            highPoints.remove(h);
            score += 30;
            a.disp();
          }
        }

        for (int j = medPoints.size()-1; j >= 0; j--) {
          Enemy m = medPoints.get(j);
          float d = dist(a.x, a.y, m.x, m.y);
          if (d < a.r + m.r) {
            medPoints.remove(m);
            score += 20;
            a.disp();
          }
        }

        for (int j = lowPoints.size()-1; j >= 0; j--) {
          Enemy l = lowPoints.get(j);
          float d = dist(a.x, a.y, l.x, l.y);
          if (d < a.r + l.r) {
            lowPoints.remove(l);
            score += 10;
            a.disp();
          }
        }
      }
      for (int i = fire.size()-1; i >= 0; i--) {
        Attack d = fire.get(i);
        if (d.delete) {
          canFire = true;
          fire.remove(d);
        }
        if (d.y <= 30) {
          canFire = true;
          fire.remove(d);
        }
      }

      stroke(0);
      fill(0, 50, 0);
      rect(0, 0, width, 50);
      fill(0);
      textSize(50);
      text("Score: " + score, width/2 - 125, 45);

      if (!waveEnd) {
        if (highPoints.size() + medPoints.size() + lowPoints.size() == 0) {
          startTime = millis();
          waveEnd = true;
          displayWaveMSG = true;
        }
      }
      fill(0);
      stroke(0);
      line(0, height - 24, width, height - 24);
      line(0, height - 25, width, height - 25);
      line(0, height - 26, width, height - 26);
    }
  } else {

    if (score > highscore) {
      highscore = score;
    }

    background(51);
    textSize(50);
    fill(250);
    text("Invaders!", width/2 - 100, 60);

    fill(200, 0, 150);
    ellipse(width/2 - 75, 130, 30, 30);
    fill(250);
    textSize(25);
    text("= 30 Points", width/2 - 45, 138);

    fill(50, 150, 100);
    ellipse(width/2 - 75, 180, 30, 30);
    fill(250);
    text("= 20 Points", width/2 - 45, 188);

    fill(150, 50, 100);
    ellipse(width/2 - 75, 230, 30, 30);
    fill(250);
    text("= 10 Points", width/2 - 45, 238);

    if (gameOver) {
      textSize(40);
      fill(215);
      float moveMSG = highscore/1000;
      text("Highscore: " + highscore, width/2 - 125 - moveMSG, 100);
      fill(playColor);
      textSize(50);
      text("Play Again", width/2 - 110, 350);
    } else {
      fill(playColor);
      textSize(50);
      text("Play Game", width/2 - 113, 350);
    }
    fill(quitColor);
    textSize(40);
    text("Quit", width/2 - 50, 420);

    if (mouseX > width/2 - 50 && mouseX < width/2 + 35) {
      if (mouseY > 385 && mouseY < 425) {
        quitColor = color(200);
        if (mousePressed) {
          exit();
        }
      } else quitColor = color(250);
    } else quitColor = color(250);

    if (mouseX > width/2 - 110 && mouseX < width/2 + 140) {
      if (mouseY > 310 && mouseY < 360) {
        playColor = color(200);
        if (mousePressed) {
          playGame = true;
          gameOver = false;
        }
      } else playColor = color(250);
    } else playColor = color(250);
  }
}


void keyPressed() {
  if (playGame) {
    if (keyCode == RIGHT) {
      move = 1;
    } else if (keyCode == LEFT) {
      move = -1;
    }
    if (keyCode == UP || key == ' ') {
      tryFire = true;
    }
  }
}

void keyReleased() {
  if (keyCode == RIGHT) {
    move = 0;
  } else if (keyCode == LEFT) {
    move = 0;
  }
  if (keyCode == UP || key == ' ') {
    tryFire = false;
  }
}

void displayWave() {
  textSize(100);
  text("Wave:"  + wave, width/2 - 300, height/2);
  canFire = false;
  if (millis() - startTime > display_dur) {
    displayWaveMSG = false;
  }
}