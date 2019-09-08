class BasicEnemy extends Character {


  BasicEnemy(PVector pos, PVector vel) {
    super(pos, vel);
    health = 2;
  }
  

  void hit() {
    death_timer = 60;
    
    
    if (health > 0) {
      health--;
    }

    if (health == 0) {
      vel.x = 0;
      vel.y = 0;
    }
  }


  void update() {
    move();
    handleWalls(); 
    
    
    if (death_timer == -1) { 
      drawMe();
      //basicenemies.remove(this);
    }
    if (death_timer > 0) { 
      death_timer--;
      drawMe();
    }
    if (death_timer == 0) { 
      basicenemies.remove(this);
      death_timer=60;
      score++;
      respawn();
    }
  }


  void move() {
    pos.add(vel);
  }


  //overrides character's drawMe method
  void drawMe() {
    pushMatrix();
    translate(pos.x, pos.y);
    scale(0.5);
    super.drawMe();
    popMatrix();
  }


  void handleWalls() {
    if (pos.x > width + 100) {
      basicenemies.remove(this);
    }
  }


  void respawn() {
    basicenemies.add(new BasicEnemy(new PVector(random(-200), random(60, height - 130)), new PVector(2, 0)));
  }
}