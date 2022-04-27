final int GAMESTART = 0, GAMERUN = 1, GAMEOVER = 2;
int gameState = 0;
int timer,hogStat;
boolean cabStat;
final int BLOCK=80;
final int HOGIDLE=0,HOGDOWN=1,HOGLEFT=2,HOGRIGHT=3;
float soldierX,soldierY,hogX,hogY,cabX,cabY,offsetY=0;

final int GRASSHEIGHT = 15;
final int STARTBUTTONW = 144;
final int STARTBUTTONH = 60;
final int STARTBUTTONX = 248;
final int STARTBUTTONY = 360;

PImage title;
PImage gameover;
PImage startNormal;
PImage startHovered;
PImage restartNormal;
PImage restartHovered;
PImage heartImg;
PImage bg;
PImage soil0;
PImage soil1;
PImage soil2;
PImage soil3;
PImage soil4;
PImage soil5;
PImage stone1;
PImage stone2;
PImage hogImg;
PImage hogDImg;
PImage hogRImg;
PImage hogLImg;
PImage soldierImg;
PImage cabImg;

int lifeHealth = 0;
float cameraOffsetY = 0;
boolean debug = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here 
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  heartImg = loadImage("img/life.png");//heart
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  hogImg = loadImage("img/groundhogIdle.png");
  hogDImg = loadImage("img/groundhogDown.png");
  hogLImg = loadImage("img/groundhogLeft.png");
  hogRImg = loadImage("img/groundhogRight.png");
  soldierImg = loadImage("img/soldier.png");
  cabImg = loadImage("img/cabbage.png");
  //load image 
  
  gameState=GAMESTART;
  
}

void draw() {
    if (debug) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    
  switch (gameState) {

    case GAMESTART: // Start Screen
    image(title, 0, 0);

    if(STARTBUTTONX + STARTBUTTONW > mouseX
      && STARTBUTTONX < mouseX
      && STARTBUTTONY + STARTBUTTONH > mouseY
      && STARTBUTTONY < mouseY) {

      image(startHovered, STARTBUTTONX, STARTBUTTONY);
      if(mousePressed){
        
        mousePressed = false;

        //soldier coordinate
        soldierX=0;
        soldierY=BLOCK*(int(random(4)+2));
        
        //Cabbage coordinate
        cabX=BLOCK*int(random(8));
        cabY=BLOCK*(int(random(4))+2);
        
        //Cabbage Stat
        cabStat=true;
        
        // Life count
        lifeHealth=5;//life have 5 heart
       
        
        // hog pos
        hogX = 3 * BLOCK;
        hogY = BLOCK;
        
        //hog stat
        hogStat = HOGIDLE;
        offsetY = 0;
        
        gameState = GAMERUN;
      }

    }else{

      image(startNormal, STARTBUTTONX, STARTBUTTONY);

    }
    break;
    
    case GAMERUN: // In Game
    
    image(bg, 0, 0);//bg location

      stroke(255,255,0);//sun outside color
      strokeWeight(5);//sun weight
      fill(253,184,19);//sun inside color
      ellipse(590,50,120,120);//sun
    
    pushMatrix();
    translate(0, offsetY);
    
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASSHEIGHT, width, GRASSHEIGHT);//Grass
    //the soils can go straight down 
    
    
    for(int i=0;i<8;i++){
      
      for(int j=0;j<24;j++){
        
        if(j<4){
        image(soil0,i*80,160+j*80);
        }else if(j<8){
        image(soil1,i*80,160+j*80);
        }else if(j<12){
        image(soil2,i*80,160+j*80);
        }else if(j<16){
        image(soil3,i*80,160+j*80);
        }else if(j<20){
        image(soil4,i*80,160+j*80);
        }else if(j<24){
        image(soil5,i*80,160+j*80);
        }
        
      }
      
    }
    
    //stones location 
   
    for(int i=0;i<8;i++){//layer1 to 8
      image(stone1,i*80,160+i*80);
    }
    
    
    for(int i=0;i<8;i++){//layer9-16
      for(int j=8;j<16;j++){
        if(j==8 || j==11||j==12||j==15){
          if(i==1 || i==2||i==5||i==6){
          image(stone1,i*80,160+j*80);
          }
          
        }else{
          if(i==0 || i==3||i==4||i==7){
          image(stone1,i*80,160+j*80);
          }
        }
      }
    }
    
    
    for(int i=0;i<8;i++){//layer17-24
      for(int j=16;j<24;j++){
        if(i+j==17||i+j==18||i+j==20||i+j==21||i+j==23||i+j==24||i+j==26||i+j==27||i+j==29||i+j==30){
          image(stone1,i*80,160+j*80);
          if(i+j==18||i+j==21||i+j==24||i+j==27||i+j==30){
          image(stone2,i*80,160+j*80);
          }
        }
      }
    }  
    // Player
    
    
    //hog
    switch(hogStat){
      case HOGIDLE:
        image(hogImg,hogX,hogY);
        break;
      case HOGDOWN:
        image(hogDImg,hogX,hogY);
        timer+=1;
        hogY+=80.0/15;
        break;
      case HOGRIGHT:
        image(hogRImg,hogX,hogY);
        timer+=1;
        hogX+=80.0/15;
        break;
      case HOGLEFT:
        image(hogLImg,hogX,hogY);
        timer+=1;
        hogX-=80.0/15;
        break;
    }
    
    //Roll soil 
    if(offsetY>-20*BLOCK){
      offsetY=BLOCK-hogY;
    }

    if(timer==15){
      hogStat=HOGIDLE;
      if(hogY%BLOCK<10){
        hogY=hogY-hogY%BLOCK;
      }
      else{
        hogY=hogY-hogY%BLOCK+BLOCK;
      }
      if(hogX%BLOCK<10){
        hogX=hogX-hogX%BLOCK;
      }
      else{
        hogX=hogX-hogX%BLOCK+BLOCK;
      }
      
      println(hogX);
      println(hogY);
      timer=0;
    }


    //Soldier
    image(soldierImg,soldierX-80,soldierY);//Draw Soldier
    soldierX+=3;//Move Soldier
    soldierX%=720;
    
    
    if(cabStat){
      image(cabImg,cabX,cabY);
    
      //Cab collision 
      if(hogX<cabX+BLOCK&&hogX+BLOCK>cabX&&hogY<cabY+BLOCK&&hogY+BLOCK>cabY){
        cabStat=false;
        lifeHealth++;
      }
    }
    
    //soldier collision 
    if(hogX<soldierX-80+BLOCK&&hogX+BLOCK>soldierX-80&&hogY<soldierY+BLOCK&&hogY+BLOCK>soldierY){
      lifeHealth--;
      hogStat=HOGIDLE;
      
      //hog pos
      hogX=4*BLOCK;
      hogY=BLOCK;
      
    }
    
    
    //game over
    if(lifeHealth==0){
      gameState=GAMEOVER;
    }
    
    popMatrix();
    
    // hp seat

    for(int i=0;i<lifeHealth;i++)
    {
      image(heartImg,10+i*70,10);
    }

    break;

    case GAMEOVER:
    image(gameover, 0, 0);
    //gameover location
    
    
    if(STARTBUTTONX + STARTBUTTONW > mouseX
      && STARTBUTTONX < mouseX
      && STARTBUTTONY + STARTBUTTONH > mouseY
      && STARTBUTTONY < mouseY) {

      image(restartHovered, STARTBUTTONX, STARTBUTTONY);
      if(mousePressed){
        
        mousePressed = false;

    
        //soldier coordinate
        soldierX=0;
        soldierY=BLOCK*(int(random(4)+2));
        
        //Cabbage coordinate
        cabX=BLOCK*int(random(8));
        cabY=BLOCK*(int(random(4))+2);
        
        //Cabbage Stat
        cabStat=true;
        
        //Life count
        lifeHealth=2;
        
        //hog pos
        hogX=4*BLOCK;
        hogY=BLOCK;
        
        //hog stat
        hogStat=HOGIDLE;
        
        offsetY=0;
        
        gameState = GAMERUN;
      }
    }else{

      image(restartNormal, STARTBUTTONX, STARTBUTTONY);

    }
    break;
    
  }

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debug) {
        popMatrix();
    }
}

void keyPressed(){
 
      if(key ==CODED){
          switch(keyCode){
            case DOWN:
              if(hogY+BLOCK<26*BLOCK&&hogStat==HOGIDLE){
                hogStat=HOGDOWN;
                timer=0;
              }
              break;
              
            case RIGHT:
              if(hogX+BLOCK<width&&hogStat==HOGIDLE){
                hogStat=HOGRIGHT;
                timer=0;
              }
              break;
              
            case LEFT:
              if(hogX>0&&hogStat==HOGIDLE){
                hogStat=HOGLEFT;
                timer=0;
              }
              break;
          }
          
        }
  
    switch(key){
      case 'w':
      debug = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debug = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(lifeHealth > 0) lifeHealth --;
      break;

      case 'd':
      if(lifeHealth < 5) lifeHealth ++;
      break;
    }
}
void keyReleased(){
}
