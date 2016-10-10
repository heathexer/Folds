float numCorners, radius;
Corner[] vertices;
void setup() {
  size(800, 800);
  background(255);
  fill(0);
  numCorners = 6;
  radius = 300;
  vertices = new Corner[(int)numCorners];
  for(float i=0; i<vertices.length; i++) vertices[(int)i] = new Corner(i*(360/numCorners));
}

void draw() {
  translate(width/2, height/2);
  background(255);
  for(int i=0; i<vertices.length; i++) vertices[i].show();
}

class Corner {
  float x, y;
  Corner(float rot) {
    this.x = radius * cos(radians(rot));
    this.y = radius * sin(radians(rot));
  }
  void show() {
    ellipse(this.x, this.y, 3, 3);
  }
}
