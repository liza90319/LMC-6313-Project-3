class Pos{
  Pos (int x, int y){
    this.x = x;
    this.y = y;
  }

  private int x;
  private int y;
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  public void print(){
    println("x:" + x + "y:" + y);
  }
  
}