class Hero extends Unit {
  Game game;
  int mana;
  int maxMana;
  ArrayList<Card> deck;
  ArrayList<Card> hand;
  ArrayList<Card> table;
  int fatigue;
  String name;
  int cardOffset = 0;
  int selectedIndex = -1;
  
  Hero(Game game, String name){
    super(0, 30);
    this.game = game;
    mana = 0;
    maxMana = 0;
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
  
  Card getTableCard(int index){
    if(index >= 0 && index < table.size()){
      return table.get(index);
    }
    return null;
  }
  
  void startTurn(){
    canAttack = true;
    for(Card card : table){
      card.canAttack = true;
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
    else if(hand.size() >= 10){
      deck.remove(0);
    }
    else{
      hand.add(deck.remove(0));
    }
  }
  
  void playCard(int index){
    if(table.size() >= 7){
      return;
    }
    
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
      attacking = getTableCard(attacker);
    }
    
    Unit targetted;
    if(target == -1){
      targetted = game.getOtherPlayer(this);
    }
    else{
      targetted = game.getOtherPlayer(this).getTableCard(target);
    }
    
    if(attacking != null && targetted != null){
      attacking.attack(targetted);
      if(attacking.health <= 0){
        table.remove(attacker);
      }
      if(targetted.health <= 0){
        game.getOtherPlayer(this).table.remove(target);
      }
    }
    
    selectedIndex = -1;
  }
  
  void endTurn(){
    selectedIndex = -1;
    canAttack = false;
    for(Card card : table){
      card.canAttack = false;
    }
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
          
      textSize(20);
      fill(255);
      text("Health: " + health + "/" + maxHealth, 10, height - 30);
      String manaString = "Mana: " + mana + "/" + maxMana;
      text(manaString, width - textWidth(manaString) - 10, height - 30);
    }
    else{
      fill(255);
      textSize(30);
      text(name, 100, 100);
      
      drawDeck(height/2 - 200);
      drawTable(height/2 - 225, false);
      drawHand(0, false);
      
      textSize(20);
      fill(255);
      text("Health: " + health + "/" + maxHealth, 10, 20);
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
      table.get(i).draw(x, y, false, false, selectedIndex == i);
    }
  }
  
  public Card getHoveredCard(){
    int x = 0;
    for(Card c : game.getCurrentPlayer().hand){
        int cardLeft = 20 - cardOffset + 90*x;
        int cardWidth = 112;
        int cardTop = height-200;
        int cardHeight = 178;
        
        if(cardLeft < mouseX && mouseX < cardLeft + cardWidth && cardTop < mouseY && mouseY < cardTop + cardHeight){
          return c;
        }
        x++;
    }
    
    return null;
  }
  
  void drawHand(int y, boolean isPlayersTurn){
    int spacing = 5;
    int w = 120;
    int cards = hand.size();
    
    int totalWidth = w * cards + spacing * cards - 1;
    int startingX = width/2 - totalWidth/2;
    
    for(int i = 0; i < cards; i++){
      int x = startingX + i * (w+spacing);
      boolean isHovered = mouseX > x && mouseX <= x + w && mouseY > y && mouseY <= y + 200;
      if(isHovered && isPlayersTurn)
      {
        hand.get(i).draw(x, y - 10, true, !isPlayersTurn, false);
      }
      else
      {
        hand.get(i).draw(x, y, true, !isPlayersTurn, false);
      }
    }
  }
  
  void mouseClicked(){
    if(game.getCurrentPlayer() != this){
      return;
    }
    handClicked();
    tableClicked();
  }
  
  void handClicked(){
    int y = height - 200;
    int spacing = 5;
    int w = 120;
    int cards = hand.size();
    
    int totalWidth = w * cards + spacing * cards - 1;
    int startingX = width/2 - totalWidth/2;
    
    for(int i = 0; i < cards; i++){
      int x = startingX + i * (w+spacing);
      boolean isHovered = mouseX > x && mouseX <= x + w && mouseY > y && mouseY <= y + 200;
      if(isHovered){
        playCard(i);
        break;
      }
    }
  }
  
  void tableClicked(){
    int spacing = 50;
    int w = 120;
    int h = 200;
    int cards = table.size();
    
    int totalWidth = w * cards + spacing * cards - 1;
    int startingX = width/2 - totalWidth/2;
    int y = height/2 + 25;
    
    if(selectedIndex >= 0){
      int opponentCards = game.getOtherPlayer(this).table.size();
      int opponentWidth = w * opponentCards + spacing * opponentCards - 1;
      int opponentX = width/2 - opponentWidth/2;
      int opponentY = height/2 - 225;
      
      for(int i = 0; i < opponentCards; i++){
        int x = opponentX + i * (w+spacing);
        boolean isHovered = mouseX > x && mouseX <= x + w && mouseY > opponentY && mouseY <= opponentY + 200;
        if(isHovered){
          attack(selectedIndex, i);
        }
      }
    }

    for(int i = 0; i < cards; i++){
      int x = startingX + i * (w+spacing);
      boolean isHovered = mouseX > x && mouseX <= x + w && mouseY > y && mouseY <= y + 200;
      if(isHovered && table.get(i).canAttack){
        selectedIndex = i;
        break;
      }
    }
  }
}
