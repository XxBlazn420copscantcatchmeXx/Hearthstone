class Unit {
  int attack;
  int health;
  int maxHealth;
  boolean attackedThisTurn;
  //Image
  
  Unit(int attack, int health){
    this.attack = attack;
    this.health = health;
    this.maxHealth = health;
    this.attackedThisTurn = false;
  }
  
  void attack(Unit otherUnit){
    if(!attackedThisTurn){
      health -= otherUnit.attack;
      otherUnit.health -= this.attack;
      attackedThisTurn = true;
    }
  }
}
