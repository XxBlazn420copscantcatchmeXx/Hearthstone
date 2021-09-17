import java.util.Random;

class Game {
  ArrayList<Card> availableCards;
  Hero player1;
  Hero player2;
  PImage background;
  boolean playerOneTurn;
  Random random;
  Button endTurnButton;  
  
  Game(ArrayList<Card> availableCards){
    this.availableCards = availableCards;
    random = new Random();
    player1 = new Hero(this, "Player One");
    player2 = new Hero(this, "Player Two");
    playerOneTurn = random.nextInt(2) == 0;
    background = loadImage("background.jpg");
    endTurnButton = new Button("End Turn", width -  220, height / 2 - 25, 200, 50);
    getCurrentPlayer().startTurn();
  }
  
  Card getRandomCard(){
    return availableCards.get(random.nextInt(availableCards.size())).copy();
  }
  
  void switchPlayer(){
    playerOneTurn = !playerOneTurn;
    getCurrentPlayer().startTurn();
  }
  
  Hero getCurrentPlayer(){
    if(playerOneTurn){
      return player1;
    }
    return player2;
  }
  
  Hero getOtherPlayer(Hero hero){
    if(hero == player1){
      return player2;
    }
    return player1;
  }
  
  void draw(){
    image(background, 0, 0, width, height);
    endTurnButton.draw();
    
    Hero currentPlayer = getCurrentPlayer();
    Hero otherPlayer = getOtherPlayer(currentPlayer);
    
    currentPlayer.draw(true);
    otherPlayer.draw(false);
 }
  
  
  void mouseClicked(){
    if(endTurnButton.isHovered()){
      getCurrentPlayer().endTurn();
    }
    getCurrentPlayer().mouseClicked();
  }
}
  
  
 
 
 
