Frog frog;
Car[] cars = new Car[12];
Log[] logs = new Log[9];
Turtle[] turtles = new Turtle[8];

float grid = 50;

boolean hit = false;


void resetGame() {
  hit = false;
  frog = new Frog(width / 2 - grid / 2, height - grid + 4, grid - 4);
}


void setup() {
  size(600, 700);
  colorMode(HSB);
  frog = new Frog(width / 2 - grid / 2, height - grid + 4, grid - 4);

  int index = 0;

  //Car Row 1
  for (int i = 0; i < 3; i ++) {
    float x = i * 225;
    cars[index] = new Car(-x, height - grid * 2, grid, grid, 1.5, 150);
    index++;
  }

  //Car Row 2
  for (int i = 0; i < 3; i++) {
    float x = i * 225 + floor(random(2)) * grid;
    cars[index] = new Car(x + width, height - grid * 3, grid, grid, -3.5, 20);
    index++;
  }

  //Car Row 3
  for (int i = 0; i < 3; i++) {
    float x = i * 200 + 150;
    cars[index] = new Car(-x, height - grid * 4, grid, grid, 2.5, 230);
    index++;
  }

  //Car Row 4
  for (int i = 0; i < 1; i++) {
    float x = random(150);
    cars[index] = new Car(x + width, height - grid * 5, grid, grid, -5, 0);
    index++;
  }

  //Car Row 5
  for (int i = 0; i < 2; i++) {
    float x = i * 450;
    cars[index] = new Car(-x, height - grid * 6, grid * 2, grid, 2, 45);
    index++;
  }

  //Turtle Row 6
  for (int i = 0; i < 4; i++) {
    float x = i * 250;
    turtles[i] = new Turtle(x + width, height - grid * 8, grid * 3, grid, -2.5);
  }

  //Log Row 7
  index = 0;
  for (int i = 0; i < 3; i++) {
    float x = i * 250;
    logs[index] = new Log(-x, height - grid * 9, grid * 2.5, grid, 2);
    index++;
  }

  //Log Row 8
  for (int i = 0; i < 3; i++) {
    float x = i * 450;
    logs[index] = new Log(-x, height - grid * 10, grid * 5, grid, 5);
    index++;
  }

  //Turtle Row 9
  for (int i = 0; i < 4; i++) {
    float x = i * grid * 4;
    turtles[i + 4] = new Turtle(x + width, height - grid * 11, grid * 2, grid, -2.5);
  }

  //Log Row 10
  for (int i = 0; i < 3; i++) {
    float x = i * grid * 5;
    logs[index] = new Log(-x, height - grid * 12, grid * 2.75, grid, 2.1);
    index++;
  }
}

void draw() {
  background(0);

  fill(225);
  rect(0, height - grid, width, grid);
  rect(0, grid, width, grid);
  rect(0, height - grid * 7, width, grid);

  for (Car car : cars) {
    car.update();
    car.show();
    if (frog.intersects(car)) {
      hit = true;
    }
  }
  fill(175, 255, 255);
  rect(0, height - grid * 7, width, -grid * 5);
  for (Log log : logs) {
    log.update();
    log.show();
  }

  if (frog.y < height - grid * 7 && frog.y > grid * 2) {
    boolean ok = false;
    for (Log log : logs) {
      if (frog.intersects(log)) {
        ok = true;
        frog.attached(log);
      }
    }
    for (Turtle t : turtles) {
      if (frog.intersects(t) && t.up) {
        ok = true;
        frog.attached(t);
      }
    }
    if (!ok) {
      hit = true;
    }
  } else {
    frog.attached(null);
  }

  for (Turtle t : turtles) {
    t.update();
    t.show();
  }

  frog.update();
  frog.show();


  if (hit) {
    fill(0, 255, 255);
    textSize(100);
    text("You Died", grid * 1.5, height / 2);
  }
}

void keyPressed() {

  if (hit) {
    resetGame();
  } else if (keyCode == UP) {
    frog.move(0, -1);
  } else if (keyCode == DOWN) {
    frog.move(0, 1);
  } else if (keyCode == RIGHT) {
    frog.move(1, 0);
  } else if (keyCode == LEFT) {
    frog.move(-1, 0);
  }
}
