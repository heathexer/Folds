float radius, edgeLength, angleMeasure, rotation;
int numCorners;
Corner[] vertices;
Edge[] edges;
MovingLine movingLine;
Slider sidesSlider, speedSlider;

void setup() {
  size(800, 800);
  background(255);
  strokeWeight(3);
  frameRate(150);
  textSize(30);
  textAlign(CENTER);
  numCorners = 12;
  radius = 300;
  vertices = new Corner[(int)numCorners];
  edges = new Edge[(int)numCorners];
  for(int i=0; i<vertices.length; i++) vertices[i] = new Corner(i*(360/numCorners));
  for(int i=0; i<edges.length; i++) edges[i] = new Edge(i);
  edgeLength = dist(vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y);
  angleMeasure = 180*(numCorners-2)/numCorners;
  movingLine = new MovingLine(2.5);
  rotation = 90+(360/numCorners)/2;
  sidesSlider = new Slider("Sides", 10, 750, 200, 40, 4, 50, 12);
  speedSlider = new Slider("Speed", 590, 750, 200, 40, 0, 25, 3);
}

void draw() {
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(rotation));
  rotation-= (360/(float)numCorners)/(angleMeasure/movingLine.speed);
  background(255);
  for(int i=0; i<edges.length; i++) edges[i].show();
  movingLine.move();
  popMatrix();
  sidesSlider.update();
  sidesSlider.show();
  speedSlider.update();
  speedSlider.show();
}

class Corner {
  float x, y;
  Corner(float rot) {
    this.x = radius * cos(radians(rot));
    this.y = radius * sin(radians(rot));
  }
  void show() {
    point(Math.round(this.x), Math.round(this.y));
  }
}

class Edge {
  float x1, y1, x2, y2;
  boolean showing;
  Edge(int index) {
    this.x1 = vertices[index].x;
    this.y1 = vertices[index].y;
    this.showing = true;
    if(index < vertices.length-1) {
      this.x2 = vertices[index+1].x;
      this.y2 = vertices[index+1].y;
    } else {
      this.x2 = vertices[0].x;
      this.y2 = vertices[0].y;
    }
  }
  void show() {
    if(showing) {
      stroke(0);
      line(x1, y1, x2, y2);
    }
  }
  void toggle() {
    if(showing) {
      showing = false;
    } else {
      showing = true;
    }
  }
}

class MovingLine {
  float angle, angleDif, speed;
  Corner originPoint;
  int index;
  MovingLine(float speed) {
    this.angle = angleMeasure/2;
    this.angleDif = 0;
    this.index = 0;
    this.speed = speed;
  }
  void move() {
    originPoint = vertices[index];
    pushMatrix();
    translate(originPoint.x, originPoint.y);
    rotate(radians(this.angle-180));
    stroke(0);
    line(0, 0, edgeLength, 0);
    popMatrix();
    angle -= speed;
    angleDif += speed;
    if(angleDif >= angleMeasure) {
      if(index < edges.length-1) {
        index++;
        edges[index-1].toggle();
      } else {
        index = 0;
        edges[edges.length-1].toggle();
      }
      angle = angle-180;
      angleDif -= angleMeasure;
    }
  }
}

class Slider {
  String title;
  int x, y, w, h;
  float value, min, max;
  boolean mouseOver;
  Slider(String title, int x, int y, int w, int h, float min, float max, float defaultVal) {
     this.title = title;
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     this.min = min;
     this.max = max;
     this.value = defaultVal;
  }
  void update() {
    if(mouseX >= this.x && mouseX <= this.x+this.w && mouseY >= this.y && mouseY <= this.y+this.h) {
      this.mouseOver = true;
      if(mousePressed) {
        this.value = mouseX - this.x;
        reset();
      }
    } else {
      mouseOver = false;
    }
  }
  void show() {
    fill(0);
    text(this.title, (this.x+this.x+this.w)/2, this.y-10);
    if(mouseOver) {
      noFill();
      stroke(128);
    } else {
      noFill();
      stroke(0);
    }
    rect(this.x, this.y, this.w, this.h);
    line(this.x+this.value, this.y, this.x+this.value, this.y+this.h);
  }
  double getValue() {
    return map(value, 0, (float)(this.x+this.w), this.min, this.max);
  }
}
void reset() {
  numCorners = (int)(sidesSlider.getValue());
  movingLine = new MovingLine((float)(speedSlider.getValue()));
  vertices = new Corner[numCorners];
  edges = new Edge[numCorners];
  for(int i=0; i<vertices.length; i++) vertices[i] = new Corner(i*(360/(float)numCorners));
  for(int i=0; i<edges.length; i++) edges[i] = new Edge(i);
  edgeLength = dist(vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y);
  angleMeasure = 180*(numCorners-2)/numCorners;
  rotation = 90+(360/numCorners)/2;
}
