

class ShopItem extends Obj {

    int ROW_GAP = 150;

    Button button;
    GUIComponent description;

    ShopItem(int buttonIdx, String name, String description) {
        super(width/2-300, height/2-80+buttonIdx*60, 100, 60);

        this.button = new Button(
            name,
            (int)x,
            (int)y,
            24,
            () -> { }
        );
        button.center = false;

        this.description = new GUIComponent(
            description,
            (int)x + ROW_GAP,
            (int)y,
            20
        );
        this.description.center = false;
    }

    void draw() {
        this.button.draw();
        this.description.draw();
    }
}



class Shop {
    boolean isOpen = false;

    Button shopOpenButton = new Button("SHOP", width-40, 40, 20, () -> {
                isOpen = true;
    });

    List<ShopItem> shopItems = new ArrayList<>();

    Shop() {
        shopItems.add(new ShopItem(
            0,
            "Pathfinder",
            "lets you see a path to where you're firing."
        ));
        shopItems.add(new ShopItem(
            1,
            "Hit and Skip",
            "the next time you hit the enemy, you'll get another shot."
        ));
    }



    void draw() {
        resetMatrix();
        pushStyle();

        if (!isOpen) {
            shopOpenButton.draw();
            return;
        }

        for (ShopItem item: shopItems) {
            item.draw();
        }

        // drawButtonWithShadow(startX, startY, "Path Finder",
        //                             color(colorRedCode,colorGreenCode, colorBlueCode));
        // drawButtonWithShadow(startX, startY + buttonHeight + buttonGap, "Double Strike",
        //                             color(colorRedCode,colorGreenCode, colorBlueCode));

        popStyle();
        camera.apply();

    }

    // void mousePressed() {
    //     if (mouseX > startX && mouseX < startX + buttonWidth &&
    //          mouseY > startY && mouseY < startY + buttonHeight) {
    //         // TODO
    //         // Enable path finder
    //         println("Select path finder");
    // }
    //     if (mouseX > startX && mouseX < startX + buttonWidth &&
    //          mouseY > startY + buttonHeight + buttonGap && mouseY < startY + 2 * buttonHeight + buttonGap) {
    //         // TODO
    //         println("Select double strike");
    // }
    // }

    // void drawButtonWithShadow(int x, int y, String text, color buttonColour) {
    //     fill(40,40,40);
    //     rect(x + shadowOffset, y + shadowOffset, buttonWidth, buttonHeight);
    //     fill(buttonColour);
    //     rect(x, y, buttonWidth, buttonHeight);
    //     fill(textColor);
    //     textSize(25);
    //     text(text, x + buttonWidth/2, y + buttonHeight/2);
    //  }
}
