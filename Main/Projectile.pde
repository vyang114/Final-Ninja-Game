class Projectile { 
  
  PVector pos, vel, dim;
  boolean isAlive;
  
  //constructor
  Projectile(PVector pos, PVector vel){ //parameter for initial velocity
    this.pos = pos;
    this.vel = vel;
    dim = new PVector(40, 40);
    isAlive = true;
  }
  
  
  void update(){
    move();
    handleWalls();
    drawMe();
  }
  

  void drawMe(){ //draw projectile
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(PI/4);
  scale(0.4);
  fill(150);
  noStroke();
  ellipse(0, 0, dim.x, dim.y);
  triangle(0, -47, -10, -17, 10, -17); //top
  triangle(0, 45, -10, 15, 10, 15); //bottom
  triangle(50, 0, 18, -10, 18, 10); //right
  triangle(-50, 0, -18, -10, -18, 10); //left
  fill(255);
  ellipse(0, 0, 20, 20); 
  popMatrix();
  }
  
    
  boolean hitCharacter(BasicEnemy e){  //detects projectiles and basic enemies
   return dist(pos.x, pos.y, e.pos.x, e.pos.y) < pos.y/6;
  }
  
  
  void handleWalls(){
    if (abs(pos.x - width/2) > width/2 || abs(pos.y - height/2) > height/2) {
    isAlive = false;
    }
  }
  
  
  void move(){
    pos.add(vel);
  }
}