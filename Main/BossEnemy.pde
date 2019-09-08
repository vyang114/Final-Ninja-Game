class BossEnemy extends Character{
  
  ArrayList <BossProjectile> bossprojectiles = new ArrayList <BossProjectile>();
  

  color bossColor;
  color white = color(255);
  
  
  BossEnemy(PVector pos, PVector vel){
    super(pos, vel);
    health = 8;
  }
  
   void hitBoss() {
    death_timer = 180;
    
    
    if (health > 0) {
      health--;
    }

    if (health == 0) {
      vel.x = 0;
      vel.y = 0;
    }
  }
  
  
  void shoot() {
   bossprojectiles.add(new BossProjectile(new PVector(pos.x, pos.y), new PVector(5, 0)));
  }
  
  
  void killed(){
     bossenemies.remove(this);
     respawn();
  }
  
   
  void update(){
    move();
    handleWalls(); 


    if (death_timer == -1) { 
      drawMe();
    }
    if (death_timer > 0) { 
      death_timer--;
      drawMe();
    }
    if (death_timer == 0) { 
      bossenemies.remove(this);
      death_timer = 180;
      score++;
      respawn();
    }
    
    
    //when boss projectiles hit player
    for (int i=0; i<bossprojectiles.size(); i++){
     BossProjectile bp = bossprojectiles.get(i);
     bp.update();
     bp.hitCharacter(girl);
     
     if (bp.hitCharacter(girl)){
       girl.health--;
       girl.pos.x = 900;
       girl.pos.y = 580;
       bossprojectiles.remove(i);
     }
    }
  }
  
  
  void move(){
    pos.add(vel);
  }
  
   boolean hitCharacter(Projectile p){
    return dist(pos.x, pos.y + 50, p.pos.x, p.pos.y) < pos.x/8;
  }
  
   //overrides character's drawMe method
   void drawMe() {
     bossColor = color(random(255), random(255), random(255));
     stroke = bossColor;
     c = bossColor;
     
     pushMatrix();
     translate(pos.x, pos.y);
     scale(1.5);
     super.drawMe();
     popMatrix();
 }
 
  
  void handleWalls(){
   if (pos.x > width){
     killed();
   }
  }
  
  
  void respawn(){
   bossenemies.add(new BossEnemy(new PVector(random(-200), random(60, height - 130)), new PVector(1.5, 0)));
  }
}  //end of class