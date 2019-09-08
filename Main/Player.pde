class Player extends Character {

  ArrayList <Projectile> projectiles = new ArrayList <Projectile>(); //stores projectles
  
  //constructor
  Player(PVector pos, PVector vel) {
    super(pos, vel);
    health = 10;
  }
  
  
  void fire() {
   projectiles.add(new Projectile(new PVector(pos.x, pos.y), new PVector(-5, 0)));
  }
  

 void update(){
   super.update();
   
   //get projectiles
   for (int i=0; i<projectiles.size(); i++){
     Projectile p = projectiles.get(i);
     p.update();
   
   //when projectiles hit basic enemies
   for (int j=0; j<basicenemies.size(); j++){
    BasicEnemy e = basicenemies.get(j);
    p.hitCharacter(e);
    
    if(p.hitCharacter(e)){
      e.hit();
      p.isAlive = false;
    }
   }
   
   //when projectiles hit boss enemies
   for (int k=0; k<bossenemies.size(); k++){
    BossEnemy b = bossenemies.get(k);
    b.hitCharacter(p);
    
    if(b.hitCharacter(p)){
      b.hitBoss();
      p.isAlive = false;
    }
   }
   
   
   //removes projectiles
   if (!p.isAlive) projectiles.remove(i);
   }
 } 
 
 
 void drawMe(){
   
   pushMatrix();
  translate(pos.x, pos.y);
  scale(0.8);
  
  //draw the girl
  //head
  strokeWeight(0.5);
  fill(252, 242, 228);
  stroke(252, 242, 228);
  ellipse(0, 0, dim.x, dim.y);
  
  stroke(1);
  line(-1, -3, -2, 2); //nose
  line(-2, 2, 0, 3);
  strokeWeight(1.5);
  point(0, 8); //mouth
  strokeWeight(2);
  line(-6, -1, -4, -1); //left eye
  line(4, -1, 6, -1); //right eye
  
  //scarf
  strokeWeight(0.5);
  fill(136, 71, 67);
  stroke(136, 71, 67);
  beginShape();
  vertex(-20, 8);
  vertex(-1, 13);
  vertex(20, 8);
  vertex(20, 25);
  vertex(-10, 28);
  vertex(-20, 25);
  vertex(-20, 8);
  endShape();
  
  stroke(0.2);
  //legs
  fill(134, 135, 130);
  stroke(134, 135, 130);
  quad(-18, 100, -8, 100, -5, 140, -9, 140);
  quad(7, 100, 17, 100, 12, 140, 7, 140);
  
  //shoes
  fill(0);
  stroke(0);
  quad(-5, 140, -9, 140, -5, 150, 0, 150);
  quad(7, 140, 12, 140, 9, 150, 4, 150);
  
  //jacket
  fill(218, 224, 196);
  stroke(218, 224, 196);
  quad(dim.x - 45, dim.y - 5, dim.x - 35, dim.y - 2, dim.x - 35, dim.y + 70, dim.x - 50, dim.y + 70);
  quad(-10, 28, 20, 25, 27, 100, -10, 100); //right
  curve(-25, 50, -25, 100, 25, 100, 25, 50);
  strokeWeight(2.5); //buttons
  stroke(152, 164, 152);
  point(-10, 40);
  point(-10, 55);
  point(-10, 70);
  point(2, 40);
  point(2, 55);
  point(2, 70);
  
  strokeWeight(3.3);
  //hair
  fill(77, 70, 63);
  stroke(77, 70, 63);
  ellipse(0, -13, 24, 14);
  quad(-10, -15, -5, -15, -15, 25, -24, 29); //left hair
  curve(20, -15, -10, -17, -25, 30, 20, 30);
  curve(-40, 0, -25, 30, -15, 25, -20, -30);  
  quad(10, -15, 11, -15, 20, 30, 6, 30); //right hair
  curve(-15, -15, 12, -15, 20, 30, -15, 30);
  curve(0, -10, 6, 30, 20, 30, 10, -10);
  
  popMatrix();
 }
}  //end of class


float acc = 2;
PVector upAcc = new PVector(0, -acc);
PVector downAcc = new PVector(0, acc);
PVector leftAcc = new PVector(-acc, 0);
PVector rightAcc = new PVector(acc, 0);

boolean up, down, left, right;
void keyPressed() {
  if (key == CODED) {
    if (!startMode && keyCode == UP) up = true;
    else if (!startMode && keyCode == DOWN) down = true;
    else if (!startMode && keyCode == LEFT) left = true;
    else if (!startMode && keyCode == RIGHT) right = true;
 }

  if (!startMode && key==' ') {
   girl.fire();
  }
 
  //pause the game
  if (!startMode && (key == 'p' || key == 'P')) {
    noLoop();
  }
  
  //resume the game
  if (!startMode && (key == 'r' || key == 'R')) {
    loop();
  }
}


void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) up = false;
    else if (keyCode == DOWN) down = false;
    else if (keyCode == LEFT) left = false;
    else if (keyCode == RIGHT) right = false;
  }
}