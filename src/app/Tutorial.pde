class Tutorial {
    List<GUIComponent> messages = new ArrayList<>();
    int currentMessage = 0;
    boolean hide = false;
    
    Tutorial() {
        messages.add(new GUIComponent("Click and drag to aim (press 'C' to cancel aim)", 100, 100, SFPro));
        messages.add(new GUIComponent("Release to fire", 100, 100, SFPro));
        messages.add(new GUIComponent("Click 'MOVE' to move around the planet", 100, 100, SFPro));
        messages.add(new GUIComponent("Click on the planet at the desired location", 100, 100, SFPro));
        messages.add(new GUIComponent("Click 'SHOP' to open the shop", 100, 100, SFPro));
        messages.add(new GUIComponent("Click the cost to buy an item", 100, 100, SFPro));
        messages.add(new GUIComponent("You gain points when you shoot.\n              Kill the enemy!", 100, 100, SFPro));
        for (GUIComponent msg: messages) {
            msg.fillBackground = true;
            msg.useBackground = true;
            msg.textColor = color(0);
        }
    }

    void enable() {
        currentMessage = 0;
        tutorialActive = true;
        gameSettings.put("difficulty", Settings.EASY);
        hide = false;
    }

    void setXY(float x, float y, int offset) {
        for (GUIComponent msg: messages) {
            msg.setXY(x, y-offset);
        }
    }

    boolean canFire() {
        return currentMessage == 0 || currentMessage == 1 || currentMessage == 6;
    }

    void handleClick() {
        if (mousePressed && currentMessage == 0) nextMessage();
    }

    void handleFinishTurn() {
        camera.animateCenterOnObject(activePlayer, 120, () -> {
            nextMessage();
            if (currentMessage == 2) {
                gameMenu.open();
                gameMenu.shopOpenButton.hide();
            }
            else if (currentMessage == 6) {
                gameMenu.open();
            }
        });
        // give the player pathfinder
        if (currentMessage == 6) activePlayer.items.add(PlayerItem.PATHFINDER);
    }

    void nextMessage() {
        if (currentMessage >= messages.size()-1) {
            return;
        }
        currentMessage++;
    }
    
    void draw() {
        if (!tutorialActive || hide) return;
        int offset = currentMessage == 5 ? 300 : 150;
        setXY(activePlayer.x, activePlayer.y, offset);
        pushStyle();

        fill(0, 255, 255);
        messages.get(currentMessage).draw();

        popStyle();
    }
}


class AnimatedArrow extends Obj {
    AnimatedArrow() {
        super(0, 0);
    }

    void moveTo(float x, float y) {

    }

    void draw() { }
}