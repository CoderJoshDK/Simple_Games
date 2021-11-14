
boolean play = false;
boolean gameOver = false;

float mainR = 25;

ArrayList<Blob> ens = new ArrayList<Blob>();

int score = 0;
void setup() {

  size(1080, 720);
  //fullScreen();

  colorMode(HSB);

  strokeWeight(3);

  frameRate(60);
}

void draw() {

  background(26);

  if (play & !gameOver) {

    fill(255);
    noCursor();
    ellipse(mouseX, mouseY, mainR, mainR);

    if (frameCount % 4 == 0) {

      if (ens.size() < 100) {

        Blob newEn = new Blob(random(mainR / 3, mainR * 2));
        ens.add(newEn);
      }
    }



    for (int i = ens.size() - 1; i >= 0; i--) {

      Blob e = ens.get(i);

      e.move();
      e.show();

      if (e.checkEdge(mouseX, mouseY, mainR)) {

        ens.remove(e);
      }
    }
  } else if (gameOver) {

    if (frameCount % 4 == 0) {

      if (ens.size() < 90) {

        Blob newEn = new Blob(random(mainR / 3, mainR * 2));
        ens.add(newEn);
      }
    }

    for (int i = ens.size() - 1; i >= 0; i--) {

      Blob e = ens.get(i);

      e.move();
      e.show();

      if (e.checkEdge(-100, -100, mainR)) {

        ens.remove(e);
      }
    }

    cursor();

    textAlign(CENTER);

    fill(255);
    textSize(75);
    text("You dead", width / 2, height / 2 - 75);

    text(score + " pts", width / 2, height / 2);

    fill(230, 150);
    textSize(50);
    text("(Click to restart)", width / 2, height / 2 + 50);

    if (mousePressed) {

      for (int i = ens.size() - 1; i >= 0; i--) {

        Blob e = ens.get(i);
        ens.remove(e);
      }

      score = 0;
      mainR = 25;

      play = true;
      gameOver = false;
    }
  } else if (!play) {

    textAlign(CENTER);

    fill(255);
    textSize(75);
    text("Eat smaller Circles", width / 2, height / 2 - 75);
    text("Avoid bigger Circles", width / 2, height / 2);

    fill(210, 150);
    textSize(50);
    text("(Click to play)", width / 2, height / 2 + 75);

    if (mousePressed) {

      score = 0;

      play = true;
    }
  }
}