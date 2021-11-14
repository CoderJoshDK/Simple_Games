class Frog extends Rectangle {


  Body attached = null;

  Frog(float x, float y, float w) {
    super(x, y, w, w);
  }

  void show() {
    fill(75, 255, 200);
    rect(x, y, w, w);
  }

  void attached(Body b) {
    attached = b;
  }

  void update() {
    if (attached != null) {
      frog.x += attached.speed;
    } else {
      float xloc = frog.x / grid;
      xloc = round(xloc);
      xloc *= grid;
      x = xloc;
    }
    x = constrain(x, 0, width - grid);
  }

  void move(float xdir, float ydir) {
    x += xdir * grid;
    y += ydir * grid;
    x = constrain(x, 0, width - grid);
    y = constrain(y, 4, height - grid + 4);
  }
}
