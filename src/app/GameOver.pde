class GameOverPage {
  
    StartMenuComponent winTitle;
    Button exitButton;
    
    GameOverPage() {
        
        winTitle = new StartMenuComponent("", width / 2, height / 2 - 50, 30);

        exitButton = new Button("Exit", width / 2, height / 2 + 100, 30, () -> {
            gameState = GameState.STARTPAGE;
        });
    }
    
    void setWinner(String winner) {
        winTitle.content = "Player " + winner + " wins!";
    }
    
  void draw() {
    
    winTitle.draw();
    exitButton.draw();
    
  }
  
}
