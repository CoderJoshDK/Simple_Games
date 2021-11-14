class Rectangle {

  float x;
  float y;
  float w;
  float h;


  Rectangle(float _x, float _y, float _w, float _h) {
    this.x = _x;
    this.w = _w;
    this.y = _y;
    this.h = _h;
  }


  boolean intersects(Rectangle other) {
    
    float left = x;
    float right = x + w;
    float top = y;
    float bottom = y + h;
    
    float oleft = other.x;
    float oright = other.x + other.w;
    float otop = other.y;
    float obottom = other.y + other.h;
    
    
    return !(left >= oright || right <= oleft ||
      top >= obottom || bottom <= otop);
  }
}
