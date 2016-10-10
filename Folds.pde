float radius, edgeLength, angleMeasure, rotation, numCorners;
Corner[] vertices;
Edge[] edges;
MovingLine movingLine;

void setup() {
  size(800, 800);
  background(255);
  strokeWeight(3);
  frameRate(150);
  numCorners = 12;
  radius = 300;
  vertices = new Corner[(int)numCorners];
  edges = new Edge[(int)numCorners];
  for(int i=0; i<vertices.length; i++) vertices[i] = new Corner(i*(360/numCorners));
  for(int i=0; i<edges.length; i++) edges[i] = new Edge(i);
  edgeLength = dist(vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y);
  angleMeasure = 180*(numCorners-2)/numCorners;
  movingLine = new MovingLine();
  rotation = 105;
}

void draw() {
  translate(width/2, height/2);
  rotate(radians(rotation));
  rotation-=.5;
  background(255);
  for(int i=0; i<edges.length; i++) edges[i].show();
  movingLine.move();
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
  MovingLine() {
    this.angle = angleMeasure/2;
    this.angleDif = 0;
    this.index = 0;
    this.speed = 2.5;
  }
  void move() {
    originPoint = vertices[index];
    pushMatrix();
    translate(originPoint.x, originPoint.y);
    rotate(radians(180+this.angle));
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
      angle = 180+angle;
      angleDif = 0;
    }
  }
}
