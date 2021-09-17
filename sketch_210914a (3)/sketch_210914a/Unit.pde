class Unit {
  int attack;
  int health;
  int maxHealth;
  boolean canAttack;
  //Image
  
  Unit(int attack, int health){
    this.attack = attack;
    this.health = health;
    this.maxHealth = health;
    this.canAttack = false;
  }
  
  void attack(Unit otherUnit){
    if(canAttack){
      health -= otherUnit.attack;
      otherUnit.health -= this.attack;
      canAttack = false;
    }
  }
}
