import processing.serial.*;
Serial port; // Create object from Serial class
groundClass[][] ground = new groundClass[14][19];
brickClass brick = new brickClass();
PImage back,start,again,win,lv1,lv2,lv3,lv4,lv5;
int nowStage,goal_row,goal_col,val,valLast;
boolean keyActive,setDone,tryAgain,showLv;
void setup() {
  size(510, 360);
  frameRate(10);
  // Open the port that the board is connected to and use the same speed (9600 bps)
  println(Serial.list());
  String portName = Serial.list()[0];
  //where 0 is dependent on the "com" port number. (How many?)
  port = new Serial(this, portName, 9600);
  // Game set
  for (int i=0;i<14;i++)
    for (int j=0;j<19;j++)
      ground[i][j] = new groundClass();
  back=loadImage("back.jpg");
  start=loadImage("head.png");
  again=loadImage("again.png");
  win=loadImage("end.png");
  lv1=loadImage("stage1.png");
  lv2=loadImage("stage2.png");
  lv3=loadImage("stage3.png");
  lv4=loadImage("stage4.png");
  lv5=loadImage("stage5.png");
  nowStage=0;
  goal_row=-100;
  goal_col=-100;
  val=0;
  valLast=999;
  keyActive=true;
  setDone=false;
  tryAgain=false;
  showLv=true;
  image(start,0,0);
}
void draw(){
  if (0 < port.available()) { // If data is available,
    val = port.read(); // read it and store it in val
  }
  if (val!=valLast){
    print(val+" ");
    if (nowStage>=6){
      image(win,0,0);
      if (val==9)
        exit();
    }
    else if (nowStage==0){
      if (val==9)
        nowStage++;
    }
    else {
      stage(nowStage);
      gamePlay();
    }
    valLast=val;
  }
}
void gamePlay(){
  if (showLv){
    showStage(nowStage);
    if (val==9)
      showLv=false;
  }
  else {
      if (!tryAgain)  brick.roll(val); 
      image(back,0,0);
      showGround();
      fill(0,66,255,150);
      rect(goal_col*30-30,goal_row*30-30,30,30);
      brick.show();
      if (brick.isDrop()){
        tryAgain=true;
        image(again,0,0);
        fill(255,100);
        rect(0,0,510,360);
        if (val==9){
          setDone=false;
          tryAgain=false;
          showLv=true;
        }
      }
      else if (brick.isGoal()){
        nowStage++;
        setDone=false;
        showLv=true;
      }
    }
  
}
void showStage(int nowStage){
  if (nowStage==1)  image(lv1,0,0);
  else if (nowStage==2)  image(lv2,0,0);
  else if (nowStage==3)  image(lv3,0,0);
  else if (nowStage==4)  image(lv4,0,0);
  else if (nowStage==5)  image(lv5,0,0);
}
// About Ground
void clearGround(){
  for (int i=0;i<14;i++)
    for (int j=0;j<19;j++)
      ground[i][j].canNotStand();
}
void showGround(){
  for (int row=0;row<14;row++)
    for (int col=0;col<19;col++)
      if (ground[row][col].exist){
        fill(112,150);
        rect(col*30-30, row*30-30, 30, 30);
      }
}
void stage(int level){
  if (level==1){
    if (!setDone){
      //image(lv1,0,0);
      clearGround();
      for (int i=3;i<=5;i++) ground[2+2][i+2].canStand();
      for (int i=3;i<=8;i++) ground[2+3][i+2].canStand();
      for (int i=3;i<=11;i++) ground[2+4][i+2].canStand();
      for (int i=4;i<=12;i++) ground[2+5][i+2].canStand();
      for (int i=8;i<=12;i++) ground[2+6][i+2].canStand();
      for (int i=9;i<=11;i++) ground[2+7][i+2].canStand();
      brick.setStart(3+2,4+2);
      goal_row=6+2;
      goal_col=10+2;
      setDone=true;
    }
  }
  else if (level==2){
    if (!setDone){
      clearGround();
      //image(lv2,0,0);
      for (int i=6;i<=12;i++) ground[2+2][i+2].canStand();
      for (int i=0;i<=3;i++) ground[2+3][i+2].canStand();
      for (int i=6;i<=8;i++) ground[2+3][i+2].canStand();
      for (int i=11;i<=12;i++) ground[2+3][i+2].canStand();
      for (int i=0;i<=8;i++) ground[2+4][i+2].canStand();
      for (int i=11;i<=14;i++) ground[2+4][i+2].canStand();
      for (int i=0;i<=3;i++) ground[2+5][i+2].canStand();
      for (int i=11;i<=14;i++) ground[2+5][i+2].canStand();
      for (int i=0;i<=3;i++) ground[2+6][i+2].canStand();
      for (int i=11;i<=14;i++) ground[2+6][i+2].canStand();
      for (int i=12;i<=14;i++) ground[2+7][i+2].canStand();
      brick.setStart(5+2,1+2);
      goal_row=5+2;
      goal_col=13+2;
      setDone=true;
    }
  }
  else if (level==3){
    if (!setDone){
      clearGround();
      //image(lv3,0,0);
      for (int i=4;i<=10;i++) ground[2+0][i+2].canStand();
      for (int i=4;i<=10;i++) ground[2+1][i+2].canStand();
      for (int i=1;i<=4;i++) ground[2+2][i+2].canStand();
      for (int i=10;i<=12;i++) ground[2+2][i+2].canStand();
      for (int i=1;i<=3;i++) ground[2+3][i+2].canStand();
      for (int i=11;i<=12;i++) ground[2+3][i+2].canStand();
      for (int i=1;i<=3;i++) ground[2+4][i+2].canStand();
      for (int i=11;i<=12;i++) ground[2+4][i+2].canStand();
      for (int i=1;i<=3;i++) ground[2+5][i+2].canStand();
      for (int i=6;i<=14;i++) ground[2+5][i+2].canStand();
      for (int i=1;i<=3;i++) ground[2+6][i+2].canStand();
      for (int i=6;i<=14;i++) ground[2+6][i+2].canStand();
      for (int i=6;i<=8;i++) ground[2+7][i+2].canStand();
      for (int i=11;i<=14;i++) ground[2+7][i+2].canStand();
      for (int i=6;i<=8;i++) ground[2+8][i+2].canStand();
      for (int i=11;i<=14;i++) ground[2+8][i+2].canStand();
      brick.setStart(5+2,2+2);
      goal_row=7+2;
      goal_col=7+2;
      setDone=true;
    }
  }
  else if (level==4){
    if (!setDone){
      clearGround();
      //image(lv4,0,0);
      ground[2+1][5+2].canStand();
      ground[2+2][5+2].canStand();
      ground[2+6][6+2].canStand();
      for (int i=5;i<=10;i++) ground[2+0][i+2].canStand();
      for (int i=8;i<=10;i++) ground[2+1][i+2].canStand();
      for (int i=8;i<=12;i++) ground[2+2][i+2].canStand();
      for (int i=0;i<=5;i++) ground[2+3][i+2].canStand();
      for (int i=11;i<=14;i++) ground[2+3][i+2].canStand();
      for (int i=4;i<=6;i++) ground[2+4][i+2].canStand();
      for (int i=11;i<=14;i++) ground[2+4][i+2].canStand();
      for (int i=4;i<=6;i++) ground[2+5][i+2].canStand();
      for (int i=12;i<=14;i++) ground[2+5][i+2].canStand();
      for (int i=9;i<=10;i++) ground[2+6][i+2].canStand();
      for (int i=6;i<=10;i++) ground[2+7][i+2].canStand();
      for (int i=6;i<=10;i++) ground[2+8][i+2].canStand();
      for (int i=7;i<=9;i++) ground[2+9][i+2].canStand();
      brick.setStart(3+2,0+2);
      goal_row=4+2;
      goal_col=13+2;
      setDone=true;
    }
  }
  else if (level==5){
    if (!setDone){
      clearGround();
      //image(lv5,0,0);
      ground[2+3][3+2].canStand();
      ground[2+4][3+2].canStand();
      ground[2+6][7+2].canStand();
      ground[2+6][13+2].canStand();
      ground[2+7][13+2].canStand();
      for (int i=3;i<=6;i++) ground[2+0][i+2].canStand();
      for (int i=3;i<=6;i++) ground[2+1][i+2].canStand();
      for (int i=3;i<=5;i++) ground[2+2][i+2].canStand();
      for (int i=7;i<=12;i++) ground[2+3][i+2].canStand();
      for (int i=7;i<=8;i++) ground[2+4][i+2].canStand();
      for (int i=11;i<=12;i++) ground[2+4][i+2].canStand();
      for (int i=2;i<=8;i++) ground[2+5][i+2].canStand();
      for (int i=11;i<=13;i++) ground[2+5][i+2].canStand();
      for (int i=7;i<=10;i++) ground[2+7][i+2].canStand();
      for (int i=7;i<=13;i++) ground[2+8][i+2].canStand();
      for (int i=10;i<=12;i++) ground[2+9][i+2].canStand();
      brick.setStart(2+5,2+2);
      goal_row=1+2;
      goal_col=4+2;
      setDone=true;
    }
  }
}
// Class
class brickClass{
  int colL,colR,rowU,rowD;
  boolean stand,asl;
  void stand(){
    stand=true;
    asl=false;
    colR=-100;
    rowD=-100;
  }
  void layAsl(){
    stand=false;
    asl=true;
    colR=-100;
  }
  void layAs_(){
    stand=false;
    asl=false;
    rowD=-100;
  }
  void setStart(int start_row,int start_col){
    colL=start_col;
    colR=-100;
    rowU=start_row;
    rowD=-100;
    this.stand();
  }
  boolean isDrop(){
    if (stand){
      if (!ground[rowU][colL].exist)
        return true;
    }
    else if (asl){
      if (!ground[rowU][colL].exist || !ground[rowD][colL].exist)
        return true;
    }
    else{ // as_
      if (!ground[rowU][colL].exist || !ground[rowU][colR].exist)
        return true;
    }
    return false;
  }
  boolean isGoal(){
    if (stand && colL==goal_col && rowU==goal_row)
      return true;
    return false;
  }
  void show(){
    fill(255,55,11,150);
    rect(colL*30-30, rowU*30-30, 30, 30);
    rect(colR*30-30, rowU*30-30, 30, 30);
    rect(colL*30-30, rowD*30-30, 30, 30);
    rect(colR*30-30, rowD*30-30, 30, 30);
  }
  void roll(int way){
    /* 1=up */
    if (way==1){
      if (stand){
        this.layAsl();
        rowU-=2;
        rowD=rowU+1;
      }
      else if (asl){
        this.stand();
        rowU--;
      }
      else if (!asl/*as_*/){
        rowU--;
      }
    }
    /* 2=right */
    else if (way==2){
      if (stand){
        this.layAs_();
        colL++;
        colR=colL+1;
      }
      else if (asl){
        colL++;
      }
      else if (!asl/*as_*/){
        this.stand();
        colL+=2;
      }
    }
    /* 3=down */
    else if (way==3){
      if (stand){
        this.layAsl();
        rowU++;
        rowD=rowU+1;
      }
      else if (asl){
        this.stand();
        rowU=rowU+2;
      }
      else if (!asl/*as_*/){
        rowU++;
      }
    }
    /* 4=left */
    else if (way==4){
      if (stand){
        this.layAs_();
        colL-=2;
        colR=colL+1;
      }
      else if (asl){
        colL--;
      }
      else if (!asl/*as_*/){
        this.stand();
        colL-=1;
      }
    }
  }
}
class groundClass{
  boolean exist;
  int R,G,B;
  void canStand(){
    exist=true;
  }
  void canNotStand(){
    exist=false;
  }
  void setColor(int red,int green,int blue){
    R=red;
    G=green;
    B=blue;
  }
}
  
