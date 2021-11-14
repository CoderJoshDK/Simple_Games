Blob player;

float zoom = 1;

ArrayList<Blob> blobs = new ArrayList<Blob>();

void setup() {

  size(600, 600);
  colorMode(HSB);

  player = new Blob(0, 0, 32);

  for (int i = 0; i < 200; i++) {

    float x = random(-width * 4, width * 4);
    float y = random(-height * 4, height * 4);

    blobs.add(new Blob(x, y, 16));
  }
}

void draw() {

  background(51);

  if (blobs.size() < 200) {

    float x = random(-width * 4, width * 4);
    float y = random(-height * 4, height * 4);

    blobs.add(new Blob(x, y, 16));
  }


  //The translate keeps the player in the center, but I put it
  //up here so that I can draw the player OVER other things

  translate(width / 2, height / 2); //Set everything to the center

  float newzoom = 32 / player.r;
  zoom = lerp(zoom, newzoom, 0.1);//This makes it slowly be the same
  scale(zoom); //Zoom the world out

  translate(-player.pos.x, -player.pos.y); //Move the world

  for (int i = blobs.size() - 1; i >= 0; i--) {

    Blob b = blobs.get(i);  

    if (player.eats(b)) {
      blobs.remove(b);
    }
    b.show();
  }

  player.show();
  player.update();
  
  //println(player.pos);
}