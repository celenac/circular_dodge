int radius, x,y, points,speed;
double rad;
boolean gameOver=false;
boolean advance=false;
ArrayList <Bullet> bullets=new ArrayList<Bullet>();
You character = new You();
int bulletSpeed=4;
Audio gameOverSound=new Audio(); //make new HTML5 audio object 
Audio advanceSound=new Audio();

void setup(){
  size(500,500);
  strokeWeight(2);
  gameOverSound.setAttribute("src","squish.mp3");
  advanceSound.setAttribute("src","bite2.mp3");
  gameOverSound.volume=1;
  advanceSound.volume=1;
  newGame();
}

void draw(){
  background(255);

  //orbit path
  stroke(200);
  noFill();
  ellipse(width/2, height/2, radius, radius);

  character.show();
  character.move();
  
  if(gameOver==false){
    for(Bullet i: bullets){
     i.move();
     i.show();
    }
  }

  //points
  fill(0);
  textSize(30);
  textAlign(RIGHT);
  text(points, width-15, 40);

  //gameOver 
  for (int i = 0; i < bullets.size(); ++i) {
    if((bullets.get(i).getX()<=character.getX()+10)&&(bullets.get(i).getX()>=character.getX()-10)&&(bullets.get(i).getY()>=character.getY()-10)&&bullets.get(i).getY()<=character.getY()+10){
      gameOver=true;
      gameOverSound.play();
    }
  }
  if(gameOver==true){
    for (int j = 0; j < bullets.size(); ++j) {
      bullets.remove(j);
    }
    fill(255,0,0,100);
    rect(0,0,width,height);
    textAlign(CENTER);
    fill(255);
    text("Click to play again",width/2,height/2);
  }
}

public void newGame(){
  radius=220;
  rad=0;
  points=0;
  speed=20;
  bullets.add(new NorthBullet());
  bullets.add(new SouthBullet());
  bullets.add(new WestBullet());
  bullets.add(new EastBullet());
}

void mousePressed(){
  if(gameOver==true){
    gameOverSound.play();
    fill(255);
    rect(0,0,width,height);
    gameOver=false;
    newGame();
  }
}

void keyPressed(){
 if(keyCode==LEFT && gameOver==false){
   rad=rad-(Math.PI/speed);
 }
 else if(keyCode==RIGHT && gameOver==false){
  rad=rad+(Math.PI/speed); 
 }
}

class You{
  private int x,y;
  You(){
     x=width/2+(int)(Math.cos(rad)*(radius/2));
     y=height/2+(int)(Math.sin(rad)*(radius/2));
  }
  void show(){
    fill(255);
    stroke(0);
    ellipse(x,y,10,10);
  }
  void move(){
      x=width/2+(int)(Math.cos(rad)*(radius/2));
     y=height/2+(int)(Math.sin(rad)*(radius/2));
  }
  public int getX(){
    return x;
  }
  public int getY(){
    return y;
  }
}

interface Bullet{
 public void move();  
 public void show();
 public int getX();
 public int getY();
 public void setX(int x);
 public void setY(int y);
}

class NorthBullet implements Bullet{
 private int x,y;
 boolean onScreen;
 NorthBullet(){
  x=width/2+(int)(Math.random()*(radius))-radius/2;
  y=0;
  onScreen=true;
 }
 public void move(){
  if(bullets.get(3).getX()<=-10){
    y+=bulletSpeed;
  }
  else{
    y+=0;
  }
  if(y>height+10){
    bullets.get(3).setX(width+1);
    bullets.get(3).setY(height/2+(int)(Math.random()*(radius))-radius/2);
  }
 }
 public void show(){
  line(x,y,x,y-10); 
 }
 public int getX(){return x;}
 public int getY(){return y;}
 public void setX(int x){this.x=x;}
 public void setY(int y){this.y=y;}
}

class SouthBullet implements Bullet{
 private int x,y;
 boolean onScreen;
 SouthBullet(){
  x=width/2+(int)(Math.random()*(radius))-radius/2;
  y=height;
  onScreen=true;
 }
 public void move(){
  if(bullets.get(0).getY()>height+10){
     y-=bulletSpeed;
  } 
  else{
    y-=0;
  }
  if(y<-10){
    bullets.get(0).setY(-1);
    bullets.get(0).setX(width/2+(int)(Math.random()*(radius))-radius/2);
  }
 }
 public void show(){
  line(x,y,x,y+10); 
 }
 public int getX(){return x;}
 public int getY(){return y;}
 public void setX(int x){this.x=x;}
 public void setY(int y){this.y=y;}
}

class WestBullet implements Bullet{
 private int x,y;
 boolean onScreen;
 WestBullet(){
  x=-2;
  y=height/2+(int)(Math.random()*(radius))-radius/2;;
  onScreen=true;
 }
 public void move(){
  if(bullets.get(1).getY()<-10){
     x+=bulletSpeed;
  }  
  else{
    x+=0;
  }
  if(x>width+10){
    advance=true;
    bullets.get(1).setY(height+1);
    bullets.get(1).setX(width/2+(int)(Math.random()*(radius))-radius/2);
  }
 }
 public void show(){
  line(x,y,x-10,y); 
 }
 public int getX(){return x;}
 public int getY(){return y;}
 public void setX(int x){this.x=x;}
 public void setY(int y){this.y=y;}
}

class EastBullet implements Bullet{
 private int x,y;
 boolean onScreen;
 EastBullet(){
  x=-12;
  y=height/2+(int)(Math.random()*(radius))-radius/2;
  onScreen=false;
 }
 public void move(){
  if(bullets.get(2).getX()>width+10){
    x-=bulletSpeed;
  }  
  else{
    x-=0;
  }
  if(x<-12){
    if(advance==true){
      if(radius>40){
        radius=radius-5;
        speed++;
      }
      points+=10;
      advanceSound.play();
      advance=false;
    }
    bullets.get(2).setX(-1);
    bullets.get(2).setY(height/2+(int)(Math.random()*(radius))-radius/2);
  }
 }
 public void show(){
  line(x,y,x+10,y); 
 }
 public int getX(){return x;}
 public int getY(){return y;}
 public void setX(int x){this.x=x;}
 public void setY(int y){this.y=y;}
}