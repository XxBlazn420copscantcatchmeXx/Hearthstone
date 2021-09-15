class Hero extends Unit {
  Game game;
  int mana;
  int maxMana;
  ArrayList<Card> deck;
  ArrayList<Card> hand;
  ArrayList<Card> table;
  int fatigue;
  String name;
  
  Hero(Game game, String name){
    super(0, 30);
    this.game = game;
    mana = 1;
    maxMana = 1;
    deck = new ArrayList<Card>();
    for(int i = 0; i < 30; i++){
      deck.add(game.getRandomCard());
    }
    hand = new ArrayList<Card>();
    for(int i = 0; i < 3; i++){
      drawCard();
    }
    table = new ArrayList<Card>();
    fatigue = 0;
    this.name = name;
  }
  
  Card getHandCard(int index){
    if(index >= 0 && index < hand.size()){
      return hand.get(index);
    }
    return null;
  }
  
  void startTurn(){
    attackedThisTurn = false;
    
    for(Card card : table){
      card.attackedThisTurn = false;
    }
    
    if(maxMana < 10){
      maxMana++;
    }
    
    mana = maxMana;
    drawCard();
  }
  
  void drawCard(){
    if(deck.isEmpty()){
      fatigue++;
      health -= fatigue;
    }
    else{
      hand.add(deck.remove(0));
    }
  }
  
  void playCard(int index){
    Card card = getHandCard(index);
    if(card == null)
      return;
    
    if(card.cost <= mana){
      hand.remove(index);
      table.add(card);
      mana -= card.cost;
    }
  }
  
  void attack(int attacker, int target){
    Unit attacking;
    if(attacker == -1){
      attacking = this;
    }
    else{
      attacking = getHandCard(attacker);
    }
    
    Unit targetted;
    if(target == -1){
      targetted = this;
    }
    else{
      targetted = game.getOtherPlayer(this).getHandCard(target);
    }
    
    if(attacking != null && targetted != null){
      attacking.attack(targetted);
    }
  }
  
  void endTurn(){
    game.switchPlayer();
  }
  
  void draw(boolean isPlayersTurn){
    if(isPlayersTurn){
      fill(255);
      textSize(30);
      text(name, 100, height-100);
      
      drawDeck(height/2 + 100);
      drawTable(height/2 + 25, true);
      drawHand(height - 200, true);
    }
    else{
      fill(255);
      textSize(30);
      text(name, 100, 100);
      
      drawDeck(height/2 - 200);
      drawTable(height/2 - 225, false);
      drawHand(0, false);
    }
  }
  
  void drawDeck(int y){
    int remainingCards = deck.size();
    String cardsLeft = remainingCards + " cards left";
    
    fill(155, 0, 0);
    rect(width - 50, y, 30, 100);
    
    if(deck.size() > 0){
      fill(155);
      rect(width - 50, y, remainingCards, 100);
    }
          
    fill(255);
    textSize(16);
    float cardsLeftWidth = textWidth(cardsLeft);
    text(cardsLeft, width - 20 - cardsLeftWidth, y - 20);
  }
  
  void drawTable(int y, boolean isPlayersTurn){
    int spacing = 50;
    int w = 120;
    int h = 200;
    int cards = table.size();
    
    int totalWidth = w * cards + spacing * cards - 1;
    int startingX = width/2 - totalWidth/2;
    
    for(int i = 0; i < cards; i++){
      int x = startingX + i * (w+spacing);
      table.get(i).draw(x, y, false);
    }
  }
  
  void drawHand(int y, boolean isPlayersTurn){
    int spacing = 5;
    int w = 120;
    int cards = hand.size();
    
    int totalWidth = w * cards + spacing * cards - 1;
    int startingX = width/2 - totalWidth/2;
    
    for(int i = 0; i < cards; i++){
      int x = startingX + i * (w+spacing);
      hand.get(i).draw(x, y, !isPlayersTurn);
    }
  }
}
