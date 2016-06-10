int radius, x,y;
double rad;
boolean gameOver=false;
ArrayList <Bullet> bullets=new ArrayList<Bullet>();
You character = new You();
int bulletSpeed=4;

void setup(){
  size(500,500);
  strokeWeight(2);
  radius=50;
  rad=0;
  bullets.add(new NorthBullet());
  bullets.add(new SouthBullet());
  bullets.add(new WestBullet());
  bullets.add(new EastBullet());
}

void draw(){
  background(255);

  //orbit path
  stroke(200);
  ellipse(width/2, height/2, radius, radius);

  character.show();
  character.move();
  
  for(Bullet i: bullets){
   i.move();
   i.show();
  }

  //gameOver 
  for (int i = 0; i < bullets.size(); ++i) {
    if((bullets.get(i).getX()<=character.getX()+10)&&(bullets.get(i).getX()>=character.getX()-10)&&(bullets.get(i).getY()>=character.getY()-10)&&bullets.get(i).getY()<=character.getY()+10){
      gameOver=true;
      fill((int)Math.random()*255,0,0);
    }
  }
}

void keyPressed(){
 if(keyCode==LEFT){
   rad=rad-(Math.PI/20);
 }
 else if(keyCode==RIGHT){
  rad=rad+(Math.PI/20); 
 }
}

class You{
  private int x,y;
  You(){
     x=width/2+(int)(Math.cos(rad)*(radius/2));
     y=height/2+(int)(Math.sin(rad)*(radius/2));
  }
  void show(){
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
  x=0;
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
  x=-10;
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
  if(x<-10){
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