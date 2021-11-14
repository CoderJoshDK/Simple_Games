class Body extends Rectangle {

  float speed;

  Body(float x, float y, float w, float h, float s) {
    super(x, y, w, h);
    speed = s;
  }

  void update() {
    x += speed;

    if (speed > 0) {
      if (x > width + grid) {
        x = -w - grid;
      }
    } else if (x < - w) {
      x = width + w + grid;
    }
  }
}
