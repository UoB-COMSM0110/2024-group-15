// in-game menu that appears near the player

class GameMenu extends Obj {

    boolean isOpen = false;
    Button shopOpenButton = new Button("Shop", 0, 0, SFPro,
        () -> {
            close();
            shop.open(true);
        });
    Button playerMoveButton = new Button("Move", 0, 0, SFPro,
        () -> {
            close();
            playerMover.startMove(activePlayer);
            if (tutorialActive) {
                tutorial.nextMessage();
            }
        });

    GameMenu() {
        super(0, 0);
        if(audio.mainPage.isPlaying()){
            audio.stopmainPage();
        }
        shopOpenButton.center = false;
        playerMoveButton.center = false;

        shopOpenButton.realPositioning(true);
        playerMoveButton.realPositioning(true);

        shopOpenButton.blackBackground = true;
        playerMoveButton.blackBackground = true;
    }

    void draw() {
        if (!isOpen) return;
        pushStyle();
        stroke(255);
        noFill();

        // rect(x-20, y-40, shopWidth+20, shopHeight);

        shopOpenButton.draw();
        playerMoveButton.draw();

        popStyle();
    }

    void open() {
        isOpen = true;
        float x = activePlayer.x+50;
        float y = activePlayer.y-60;
        shopOpenButton.setXY(x, y);
        playerMoveButton.setXY(x, y+40);
        shopOpenButton.show();
        playerMoveButton.show();
    }

    void close() {
        isOpen = false;
        shopOpenButton.hide();
        playerMoveButton.hide();
    }

    private void menuCallback(Runnable func) {
        close();
        func.run();
    }

}