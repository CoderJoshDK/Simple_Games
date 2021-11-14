class Car extends Body {

  int c;
  
  Car(float x, float y, float w, float h, float s, int _c) {
    super(x, y, w, h, s);
    c = _c;
  }


  void show() {
    fill(c, 240, 240);
    rect(x, y, w, h);
  }
}
