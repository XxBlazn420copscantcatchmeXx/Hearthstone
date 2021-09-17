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
  
  Card copy(){
    return new Card(name, attack, health, cost, image);
  }
  
  void draw(int x, int y, boolean inHand, boolean flipped, boolean selected){
    if(flipped){
      fill(55);
      rect(x, y, 120, 163, 12);
    }
    else{
      String costString = String.valueOf(cost);
      float costW = textWidth(costString);
      String attackString = String.valueOf(attack);
      float attackW = textWidth(attackString);
      String healthString = String.valueOf(health);
      float healthW = textWidth(healthString);
      
      image(image, x-20, y-20, 150, 210);
      
      fill(0, 0, 0, 0);
      if(selected){
        stroke(50, 150, 250);
      }
      else if(!inHand && canAttack){
        stroke(50, 250, 150);
      }
      rect(x, y, 120, 163, 12);
      noStroke();
      
      //textSize(24);
      //fill(150);
      //text(name, x + 60 - textWidth(name)/2, y + 140);
      
      textSize(20);
      fill(255);
      text(costString, x + 5 - costW/2, y + 10);
      
      text(attackString, x + 5 - attackW/2, y + 175);
      
      if(health < maxHealth){
        fill(160, 0, 0);
      }
      text(healthString, x + 112 - healthW/2, y + 175);
    }
  }
}
