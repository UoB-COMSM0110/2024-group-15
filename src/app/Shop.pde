class ShopItemRow extends Obj {

    int ROW_GAP = 150;

    Button button;
    GUIComponent description;
    Runnable callback;

    ShopItemRow(int buttonIdx, String name, String description, Runnable callback) {
        super(shopX, shopY+buttonIdx*60, shopWidth, 60);

        this.button = new Button(
            name,
            (int)x,
            (int)y,
            24,
            callback
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



class Shop extends Obj {


    boolean isOpen = false;

    Button shopOpenButton = new Button("SHOP", width-40, 40, 20, () -> { isOpen = true; });

    Button shopCloseButton;

    List<ShopItemRow> shopItemRows = new ArrayList<>();

    Shop() {

        super(shopX, shopY, shopWidth, shopHeight);

        shopItemRows.add(new ShopItemRow(
            0,
            "Pathfinder",
            "lets you see a path to where you're firing.",
            () -> activePlayer.addShopItem(PlayerItem.PATHFINDER)
        ));
        shopItemRows.add(new ShopItemRow(
            1,
            "Hit and Skip",
            "the next time you hit the enemy, you'll get another shot.",
            null
        ));

        shopCloseButton = new Button(
            " X ",
            shopX+shopWidth+120,
            shopY-50,
            24,
            () -> { isOpen = false; }
        );
        shopCloseButton.center = false;
    }



    void draw() {
        resetMatrix();
        pushStyle();

        if (!isOpen) {
            shopOpenButton.draw();
            return;
        }
        for (ShopItemRow item: shopItemRows) {
            item.draw();
        }
        shopCloseButton.draw();
        popStyle();
        camera.apply();

    }

    boolean isOpen() {
        return this.isOpen;
    }

    // TODO implement this
    void doubleStrike() {
         Player currentActivePlayer = activePlayer;
         isDoubleStrikeActive = true;
         boolean playerHit = updatePlayerHealths();

         if (playerHit) {
             updatePlayerHealths();
         }

         camera.setXY(activePlayer.getX(), activePlayer.getY());
         gameState = GameState.GAME;
         isDoubleStrikeActive = false;
     }
}
