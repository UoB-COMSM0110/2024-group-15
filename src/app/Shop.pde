class ShopPage {

    StartMenuComponent shopTitle;
    Button optionButton1;
    Button optionButton2;

    ShopPage() {
        shopTitle = new StartMenuComponent("SHOP", width / 2, 70, 40);
        int buttonYStart = height / 2 - 50;
        int buttonSpacing = 100;

        optionButton1 = new Button("Path Finder", width / 2, buttonYStart, 30, () -> {
        println("Selected Path Finder");
        isPathFinderActive = true;
        gameState = GameState.GAME;
        camera.centerOnObject(activePlayer);
        });

        optionButton2 = new Button("Double Strike", width / 2, buttonYStart + buttonSpacing, 30, () -> {
        println("Selected Double Strike");
        gameState = GameState.GAME;
        doubleStrike();
        });
    }

     void draw() {

         shopTitle.draw();
         optionButton1.draw();
         optionButton2.draw();

     }

     void doubleStrike() {
         Player currentActivePlayer = activePlayer;
         isDoubleStrikeActive = true;
         boolean playerHit = updatePlayerHealths();

         if (playerHit) {
             updatePlayerHealths();
         }

         camera.centerOnObject(activePlayer);
         gameState = GameState.GAME;
         isDoubleStrikeActive = false;
     }
}
