class BossProjectile { 
  
  PVector pos, vel, dim;
  boolean isAlive;
  
  //constructor
  BossProjectile(PVector pos, PVector vel){ //parameter for initial velocity
    this.pos = pos;
    this.vel = vel;
    dim = new PVector(40, 40);
    isAlive = true;
  }
  
  
  void update(){
    move();
    drawMe();
  }
  
  
  //boss projectiles hit player
   boolean hitCharacter(Player p){
    return pos.dist(p.pos) < pos.y/9;
  }
  

  void drawMe(){ //draw projectile  
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(PI/4);
  scale(0.4);
  fill(255);
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
 
  
  void move(){
    pos.add(vel);
  }
}