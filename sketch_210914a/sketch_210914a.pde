ArrayList<Card> availableCards;
Game game;

void setup(){
  size(1600, 900);
  availableCards = new ArrayList<Card>();
  availableCards.add(new Card("Wisp", 1, 1, 0, loadImage("card_wisp.jpg")));
  game = new Game(availableCards);
}

void draw(){
  game.draw();
}

void mouseClicked(){
  game.mouseClicked();
}
