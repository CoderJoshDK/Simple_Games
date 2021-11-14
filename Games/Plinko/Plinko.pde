ArrayList<Peg> pegs;
ArrayList<Wall> walls;
Player c;

int peg_size = 10;
int w = 60;
int h = 120;

int score = 0;//DO actual game things later

void setup() {

  size(740, 500);
  colorMode(HSB);

  c = new Player();
  pegs = new ArrayList<Peg>();
  walls = new ArrayList<Wall>();

  for (int x = 0; x < 12; x++) {
    for (int y = 0; y < 4; y++) {
      pegs.add(new Peg(((x) * w) + 40, ((y) * h) + 80));
    }
  }

  for (int x = 0; x < 11; x++) {
    for (int y = 0; y < 3; y++) {
      pegs.add(new Peg(((x) * w) + 70, (y * h) + 140));
    }
  }

  for (int x = 0; x < 12; x++) {
    walls.add(new Wall(((x) * w) + 40, height - (height - ((3 * h) + 80)) / 2));
  }
}

void draw() {

  background(51);

  for (Wall w : walls) {
    w.show();
  }
  for (Peg p : pegs) {
    p.show();
  }


  c.update();
  c.show();
}

void mousePressed() {
  if (!c.go) {
    c.go = true;
  }
}
