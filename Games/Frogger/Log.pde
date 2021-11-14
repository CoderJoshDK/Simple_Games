class Log extends Body {

  Log(float x, float y, float w, float h, float s) {
    super(x, y, w, h, s);
  }

  void show() {
    fill(20, 240, 100);
    rect(x, y, w, h);
  }
}
