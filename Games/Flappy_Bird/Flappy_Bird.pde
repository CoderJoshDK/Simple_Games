Bird bird;

ArrayList<Pipe> pipes;

boolean playing = false;
boolean gameOver = false;

int score = 0;

void setup() {

  size(400, 600);

  textAlign(CENTER);

  bird = new Bird();
  pipes = new ArrayList<Pipe>();
}

void draw() {

  background(17, 84, 142);

  bird.show();

  for (Pipe p : pipes) {

    p.show();
  }

  if (playing) {
    if (frameCount % 100 == 0) {

      pipes.add(new Pipe());
    }

    bird.update();


    for (int i = pipes.size() - 1; i >= 0; i--) {

      Pipe p = pipes.get(i);

      p.update();

      if (p.x < -p.w) {

        pipes.remove(p);
      }

      if (p.score(bird)) {
        
        score++;
      }

      if (p.hits(bird)) {
        
        playing = false;
        gameOver = true;
      }
    }
  }


  if (gameOver) {

    textSize(50);

    fill(255, 255, 0);

    if (mouseX > width / 2 - 125 && mouseX < width / 2 + 75) {
      if (mouseY > height / 2 && mouseY < height / 2 + 75) {

        fill(200, 200, 0);

        if (mousePressed) {

          playing = false;
          gameOver = false;
          
          score = 0;

          pipes = new ArrayList<Pipe>();
          bird = new Bird();
        }
      }
    }

    rect(width /2 - 125, height / 2, 250, 75);


    fill(0);
    text("Play again", width / 2, height / 2 + 50);

    textSize(75);
    text("Game Over", width / 2, height / 3);
  }
  
  fill(0);
  
  textSize(50);
  text(score, width / 2, 50);
}

void keyPressed() {

  if (playing && !gameOver) {
    if (key == ' ') {

      bird.up();
    }
  } else if (key == ' ' && !gameOver) {

    playing = true;
    bird.up();
  }
}

void mousePressed() {

  if (playing && !gameOver) {

    bird.up();
  } else if (!gameOver) {

    playing = true;
    bird.up();
  }
}