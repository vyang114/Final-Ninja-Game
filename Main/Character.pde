class Character {
  
  PVector pos, vel, acc;
  float damp = 0.8;
  int health;
  PVector dim; //player width and height
  PVector dim2; //enemy width and height
  int death_timer = -1;
  color c = color(0);
  color stroke = color(70);
  
  //constructor
  Character(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
    dim = new PVector(25, 30);
    dim2 = new PVector(90, 70);
  }
  
    
  void update(){ //for movement
  
    decreaseHealth(health);
    drawMe();
    pos.add(vel);
    vel.mult(damp);
    
  if (health == 0){
    gameOver = true;
  }
  
    
    //when player hits basic enemy
    for (int j=0; j<basicenemies.size(); j++){
    BasicEnemy e = basicenemies.get(j);    
    (this).hitCharacter(e);

   if ((this).hitCharacter(e)){
      pos.x = 900;
      pos.y = 580;
      girl.health--;
   }
   
   
   //when player hits boss enemy
   for (int i=0; i<bossenemies.size(); i++){
    BossEnemy b = bossenemies.get(i);    
    (this).hitCharacter(b);

   if ((this).hitCharacter(b)){
      pos.x = 900;
      pos.y = 580;
      girl.health--;
   }
  }
 }
}

  
  void move(PVector acc){ //update speed with acceleration
    vel.add(acc);
  }
  
  
  boolean hitCharacter(BasicEnemy e){
    return (dist(pos.x, pos.y + 50, e.pos.x, e.pos.y) < pos.y/6);
  }
  
  boolean hitCharacter(BossEnemy b){
    return (dist(pos.x, pos.y + 50, b.pos.x, b.pos.y) < pos.x/8);
  }
  
  
  void drawMe(){     
    pushMatrix();
    stroke(stroke);
    fill(c);
    ellipse(0, 0, dim2.x, dim2.y);   // mask
    fill(0);
    curve(15, -85, 15, 35, -10, 35, -20, -85);   // body
    line(0, 50, 0, 65);   // left leg
    line(5, 50, 5, 65);   // right leg
    ellipse(-5, 65, 10, 5);   // left foot
    ellipse(10, 65, 10, 5);   // right foot
    fill(255, 229, 204);
    ellipse(0, 8, dim2.x - 20, dim2.y - 15);   // face
    fill(0);
    line(-15, 0, -5, 5);   // left eyebrow
    line(15, 5, 25, 0);   // right eyebrow
    ellipse(-8, 12, 5, 5);   // left eye
    ellipse(15, 12, 5, 5);   // right eye
    popMatrix();
  }
  

  int decreaseHealth(int health){ //takes an int parameter  
  if(!startMode && !gameOver){
     fill(255);
     textSize(18);
     text("life :" + girl.health, 100, 40);
  }
  
  if (gameOver){
    girl.pos.x = 1300;
    
    image(start, 0, 0);
    textFont(name, 50);
    fill(255);
    text("You Failed", 340, 200);
    textFont(discription, 15);
    text("The ninjas have taken \n over the village", 390, 330);
    text("Ninja assassinated :" + score, 390, 400);
    
    noLoop();
  }
  return health;
  }
} //end of class