// in-game options where you can restart, play again, etc.

class OptionsMenu extends Obj {
    boolean isOpen = false;
    Button playAgainButton = new Button("PLAY AGAIN", 0, 0, SFPro,
        () -> {
            close();
            // gameState = GameState.GAME;
            gameInit();
        });
    Button mainMenuButton = new Button("MAIN MENU", 0, 0, SFPro,
        () -> {
            close();
            gameState = GameState.STARTPAGE;
            startMenu.setState(StartMenuState.VS);
        });
    Button exitButton = new Button("EXIT GAME", 0, 0, SFPro,
        () -> {
            close();
            exit();
        });

    OptionsMenu() {
        super(0, 0);
        // playAgainButton.center = false;
        // mainMenuButton.center = false;
        // exitButton.center = false;

        playAgainButton.realPositioning(true);
        mainMenuButton.realPositioning(true);
        exitButton.realPositioning(true);

    }

    void draw() {
        if (!isOpen) return;
        pushStyle();
        stroke(255);
        noFill();

        // rect(x-20, y-40, shopWidth+20, shopHeight);

        if (!tutorialActive) playAgainButton.draw();
        mainMenuButton.draw();
        exitButton.draw();

        popStyle();
    }

    void open(Player p) {
        isOpen = true;
        float x = p.x;
        float y = p.y-130;
        playAgainButton.setXY(x, y);
        mainMenuButton.setXY(x, y+40);
        exitButton.setXY(x, y+80);
        playAgainButton.show();
        mainMenuButton.show();
        exitButton.show();
    }

    void close() {
        isOpen = false;
        playAgainButton.hide();
        mainMenuButton.hide();
        exitButton.hide();

    }
}