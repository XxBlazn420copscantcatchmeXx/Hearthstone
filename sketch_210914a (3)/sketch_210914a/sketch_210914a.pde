ArrayList<Card> availableCards;
Game game;

void setup(){
  size(1600, 900);
  availableCards = new ArrayList<Card>();
  availableCards.add(new Card("Big Chungus", 3, 5, 4, loadImage("CHUNGUS.png")));
  availableCards.add(new Card("Bugs Bunny Communist", 2, 3, 2, loadImage("bugs bunny communist v2.png")));
  availableCards.add(new Card("Zoinks Man", 3, 3, 3, loadImage("zoinks man v2.png")));
  availableCards.add(new Card("Shrugging Tom", 1, 3, 2, loadImage("Shrugging Tom.png")));
  availableCards.add(new Card("Samurai Cheems", 8, 6, 8, loadImage("Samurai Cheems v2.png")));
  availableCards.add(new Card("KEK", 1, 1, 1, loadImage("risitas heeeeeeeeeeeeeee.png")));
  availableCards.add(new Card("Dr Phil", 10, 10, 10, loadImage("Dr PHil MM v2.png")));
  availableCards.add(new Card("Gru with a Gun", 10, 10, 10, loadImage("Gru with a GUn v2.png")));
  availableCards.add(new Card("Doomer", 2, 3, 4, loadImage("Doomer v2.png")));
  availableCards.add(new Card("Master Oogway", 2, 2, 3, loadImage("Master Oogway v2.png")));
   availableCards.add(new Card("Evil patrik", 2, 3, 2, loadImage("Evil patrick.png")));
   availableCards.add(new Card("Big Brain", 3, 3, 5, loadImage("BIg brain.png")));
  game = new Game(availableCards);
}

void draw(){
  game.draw();
}

void mouseClicked(){
  game.mouseClicked();
}
