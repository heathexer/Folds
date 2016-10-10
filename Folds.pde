float numCorners, radius;
Corner[] vertices;
void setup() {
  size(800, 800);
  background(255);
  numCorners = 6;
  radius = 300;
  vertices = new Corner[(int)numCorners];
  for(float i=0; i<vertices.length; i++){
    vertices[(int)i] = new Corner(i*(360/numCorners));
    vertices[(int)i].show();
    System.out.println(i*(360/numCorners));
  }
}

void draw() {
}

class Corner {
  float rot, dist;
  Corner(float rot) {
    this.rot = rot;
  }
  void show() {
    System.out.println(this.rot);
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(this.rot));
    ellipse(0, radius, 5, 5);
    popMatrix();
  }
}
