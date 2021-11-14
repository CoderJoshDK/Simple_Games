class Turtle extends Body {

  int time = (int) random(1000);
  boolean up = true;

  Turtle(float x, float y, float w, float h, float s) {
    super(x, y, w, h, s);
  }

  void show() {

    time++;
    time %= 1050;
    if (time > 900) {
      up = false;
    } else {
      up = true;
    }

    if (up) {
      fill(75, 240, 100);
    } else {
      fill(75, 100, 100, 150);
    }

    rect(x, y, w, h);
  }
}
