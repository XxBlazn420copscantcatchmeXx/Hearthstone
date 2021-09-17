class Button{
  String text;
  int x;
  int y;
  int w;
  int h;
  
  Button(String text, int x, int y, int w, int h){
    this.text = text;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void draw(){
    if(isHovered()){
      fill(204, 164, 61);
    }
    else{
      fill(242, 193, 68);
    }
    rect(x, y, w, h, 5);
    textSize(30);
    fill(0);
    text(text, x + w/2 - textWidth(text)/2, y + h/2 + 10);
  }
  
  boolean isHovered(){
    return mouseX > x && mouseX <= x + w && mouseY > y && mouseY <= y + h;
  }
}
