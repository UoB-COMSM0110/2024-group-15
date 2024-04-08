class GameOverPage {
  
    GUIComponent winTitle;
    Button exitButton;
    
    GameOverPage() {
        
        winTitle = new GUIComponent("", width / 2 - 50, height / 2 - 50, 30);

        exitButton = new Button("Exit", width / 2, height / 2 + 100, 30, () -> {
            // reset game state
            gameState = GameState.STARTPAGE;
            startMenu = new StartMenu();
            // reset arrow and player
            planets = new ArrayList<>();
            spentArrows = new ArrayList<>();
            players = new Player[2];
            setup();
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
