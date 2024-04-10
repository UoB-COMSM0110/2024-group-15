class ShopItemRow extends Obj {
    int COL_GAP = 160;

    Button button;
    GUIComponent name;
    GUIComponent description;
    Runnable callback;
    int cost;
    PlayerItem playerItem;

    ShopItemRow(
        int buttonIdx,
        PlayerItem item,
        String name,
        String description,

        int cost
    ) {
        super(shopX, shopY+buttonIdx*100, shopWidth, 60);
        this.cost = cost;
        this.playerItem = item;

        this.name = new GUIComponent(name, x, y, 24);
        this.name.setFont(SFPro);
        this.name.center = false;

        this.description = new GUIComponent(description, x + COL_GAP, y, 20);
        this.description.center = false;
        this.description.setFont(SFPro);
        this.button = new Button("$ "+cost, x + COL_GAP+350, y, 24, () -> activePlayer.addShopItem(this));
        button.center = false;
        button.setFont(SFPro);
    }

    void draw() {
        this.name.draw();
        this.description.draw();
        this.button.draw();
    }
}


class Shop extends Obj {
    boolean isOpen = false;
    Button shopCloseButton;
    List<ShopItemRow> shopItemRows = new ArrayList<>();

    Shop() {
        super(shopX, shopY, shopWidth, shopHeight);

        addShopItems();

        shopCloseButton = new Button(
            " X ",
            shopX+shopWidth,
            shopY-50,
            SFPro,
            () -> { open(false); }
        );
        shopCloseButton.center = false;
    }

    void draw() {
        if (!isOpen) return;

        resetMatrix();
        pushStyle();

        stroke(255);
        noFill();
        rect(x-20, y-40, shopWidth+20, shopHeight);
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

    void open(boolean val) {
        isOpen = val;
        for (ShopItemRow item: shopItemRows) {
            item.button.show(val);
        }
        shopCloseButton.show(val);
        gameState = val ? GameState.SHOP : GameState.GAME;
    }

    private void addShopItems() {
        shopItemRows.add(new ShopItemRow(
            0,
            PlayerItem.PATHFINDER,
            "Pathfinder",
            "lets you see a path to\nwhere you're firing.",
            100
        ));

        shopItemRows.add(new ShopItemRow(
            1,
            PlayerItem.DOUBLESTRIKE,
            "Double Strike",
            "if your next shot hits,\nit will damage the enemy 2 hearts.",
            50
        ));

        shopItemRows.add(new ShopItemRow(
            2,
            PlayerItem.HITSKIP,
            "Hit and Skip",
            "the next time you hit the\nenemy, you'll get another shot.",
            100
        ));

        shopItemRows.add(new ShopItemRow(
            3,
            PlayerItem.HEALTHPOTION,
            "Health Potion",
            "recover one of your hearts,\nbut the enemy gets three shots.",
            0
        ));
    }
}