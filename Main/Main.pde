Player girl;

boolean pointInRect(float a, float b, float x, float y, float w, float h) {
  if ((a >= x && a <= x + w) && (b >= y && b <= y + h)) {
    return true;
  } else {
    return false;
  }
}

boolean startMode;
boolean gameOver;

float box_x = 430;
float box_y = 420;
float box_w = 150;
float box_h = 40;

color red = color(255, 0, 0);
color r = color(255, 0, 0);
color black = color(0);

PImage background;
PImage start;

PFont discription;
PFont name;
PFont ready;

int score;

ArrayList <BasicEnemy> basicenemies = new ArrayList <BasicEnemy>();
ArrayList <BossEnemy> bossenemies = new ArrayList <BossEnemy>();
ArrayList <BossProjectile> bossprojectiles = new ArrayList <BossProjectile>();


void mousePressed() {
  if (pointInRect(mouseX, mouseY, box_x, box_y, box_w, box_h)) {
    startMode = false;
  }
}


void setup() {
  size(1000, 600);

  startMode = true;
  gameOver = false;

  background = loadImage("ninja-village medium.png");
  start = loadImage("Red_Bit_Ninja_Background_Red_night small.jpg");

  discription = loadFont("TrajanPro3-Bold-48.vlw");
  name = loadFont("TrajanPro3-Regular-48.vlw");  
  ready = loadFont("STBaoli-SC-Regular-48.vlw");

  girl = new Player(new PVector(930, 300), new PVector());

  for (int i=0; i<10; i++) {
    basicenemies.add(new BasicEnemy(new PVector(random(-380, -320), random(60, height - 100)), new PVector(2, 0)));
  }

  for (int k=0; k<1; k++) {
    bossenemies.add(new BossEnemy(new PVector(-320, random(60, height - 100)), new PVector(1.5, 0)));
  }
}


void draw() {
  background(255);

  image(start, 0, 0);

  if (startMode) {
    startScreen();
  } else if (!startMode && !gameOver) {
    drawGame();
  }

  //detects if mouse point hovers over "i'm ready"
  if (pointInRect(mouseX, mouseY, box_x, box_y, box_w, box_h)) {
    red = black;
  } else {
    red = r;
  }

  if (up) girl.move(upAcc);
  if (down) girl.move(downAcc);
  if (left) girl.move(leftAcc);
  if (right) girl.move(rightAcc);

  girl.update();
  girl.drawMe();

  for (int i=0; i<basicenemies.size(); i++) {
    BasicEnemy e = basicenemies.get(i);

    if (!startMode) {
      e.update();
    }

    //add a basic enemy when there is less than 10
    if (basicenemies.size() < 10) {
     basicenemies.add(new BasicEnemy(new PVector(random(-380, -320), random(60, height - 100)), new PVector(2, 0)));
    }
  }


  //remove basic enemies when game over
  for (int i=basicenemies.size() - 1; i>=0; i--) {
    if (gameOver) {
      basicenemies.remove(i);
    }
  }


  for (int i=0; i<bossenemies.size(); i++) {
    BossEnemy b = bossenemies.get(i);
    if (!startMode) {
      b.update();
    }

    //add a boss enemy when there is less than 1
    if (bossenemies.size() < 1) {
      b.respawn();
    }
    else if((bossenemies.size() == 1)){
     if(frameCount % 150 == 0) b.shoot();
    }
  }
  

  //remove boss enemies when game over
  for (int i=bossenemies.size() - 1; i>=0; i--) {
    if (gameOver) {
      bossenemies.remove(i);
    }
  }
}  //end of draw


void drawGame() { 
  image(background, 0, 0);
  fill(255);
  textFont(discription, 18);
  text("ninja killed :" + score, 300, 40);
}


void startScreen() {
  //draw shuriken
  pushMatrix();
  translate(500, 260);
  rotate(PI/3);
  scale(2);
  fill(150);
  noStroke();
  ellipse(0, 0, 40, 40);
  triangle(0, -47, -10, -17, 10, -17); //top
  triangle(0, 45, -10, 15, 10, 15); //bottom
  triangle(50, 0, 18, -10, 18, 10); //right
  triangle(-50, 0, -18, -10, -18, 10); //left
  fill(255);
  ellipse(0, 0, 20, 20); 
  popMatrix();

  textFont(name, 50);
  text("Final Ninja", 340, 200);
  textFont(discription, 15);
  String s = "YOU, the last survivor of the village, be ready to take on the stealthiest, most myestrious ninjas with your deadly skills";
  text(s, 360, 330, 330, 380);  
  
  textSize(13);
  text("instruction:", 360, 500);
  text("P to pause \nR to resume \nsapce bar to fire", 490, 500);

  textFont(name, 25);
  fill(red);
  text("I'm ready", 440, 450);

  noStroke();
  noFill();
  rect(box_x, box_y, box_w, box_h);  //box around i'm ready
  
  
  
}