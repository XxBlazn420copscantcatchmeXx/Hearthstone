class Card extends Unit { 
  String name;
  int cost;
  PImage image;
  
  Card(String name, int attack, int health, int cost, PImage image){
    super(attack, health);
    this.name = name;
    this.cost = cost;
    this.image = image;
  }
  
  void draw(int x, int y, boolean flipped){
    if(flipped){
      fill(55);
      rect(x, y, 120, 200, 12);
    }
    else{
      fill(40);
      rect(x, y, 120, 200, 12);
      String costString = String.valueOf(cost);
      float costW = textWidth(costString);
      String attackString = String.valueOf(attack);
      float attackW = textWidth(attackString);
      String healthString = String.valueOf(health);
      float healthW = textWidth(healthString);
      
      image(image, x + 10, y + 10, 100, 100);
      
      textSize(24);
      fill(150);
      text(name, x + 60 - textWidth(name)/2, y + 140);
      
      textSize(30);
      fill(0, 100, 230);
      text(costString, x + 20 - costW/2, y + 35);
      
      fill(0, 160, 100);
      text(attackString, x + 20 - attackW/2, y + 185);
      
      if(health < maxHealth){
        fill(160, 0, 0);
      }
      text(healthString, x + 100 - healthW/2, y + 185);
    }
  }
}
