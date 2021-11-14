class Ship {
  float x;
  Ship() {
    x = width/2;
  }
  void show() {
    fill(255);
    rect(x, height-22, 20, 20);
  }
  void move(int i) {
    if (x > 0 && x < width - 20) {
      x += 5 * i;
    }
    if (x == 0){
      if (i == 1){
        x += 5 * i;
      }
    }
    if (x == width - 20){
      if (i == -1){
        x += 5 * i;
      }
    }
  }
}