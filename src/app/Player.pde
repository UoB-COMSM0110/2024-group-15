enum PlayerStatus {
    IDLE,
    DRAW,
    HIT,
}

enum PlayerItem {
    PATHFINDER,
    HITSKIP,
    DOUBLESTRIKE,
    HEALTHPOTION,
}

class Point {
    float x, y;
    Point(float x, float y) {
        this.x = x;
        this.y = y;
    }
}


public class Player extends Entity {
    PlayerNum playerNum;
    Arrow arrow;
    Aimer aimer;
    Planet planet;
    Sprite idleSprite;
    Sprite drawSprite;
    Sprite hitSprite;
    Sprite holdSprite;
    Sprite bowSprite;
    PlayerStatus status = PlayerStatus.IDLE;
    float planetAngle;

    Pathfinder pf;
    List<PlayerItem> items = new ArrayList<>();

    int health = maxHealth;
    HealthBar healthBar;

    int points = 0;
    int roundPoints = 0;
    float multiplier = 1;
    PointsBar pointsBar;

    int roundsOfSkip = 0;

    Player(Planet planet, int planetAngle, PlayerNum playerNum) {
        super(planet.x, planet.y, 30, 60);
        this.planetAngle = planetAngle;
        this.planet = planet;

        this.playerNum = playerNum;
        setHitBox(getHitBoxWidth()-10, getHitBoxHeight()-13);

        arrow = new Arrow(x, y);
        aimer = new Aimer(this, arrow);

        healthBar = new HealthBar(this, playerNum);
        pointsBar = new PointsBar(this, playerNum);

        idleSprite = new Sprite(this, imgs.get("player-idle"), 102, 64, 13, AnimationType.LOOP);
        drawSprite = new Sprite(this, imgs.get("player-draw"), 102, 64, 8, AnimationType.FIRSTLAST);
        hitSprite = new Sprite(this, imgs.get("player-hit"), 102, 64, 6, AnimationType.FIRSTLAST);
        holdSprite = new Sprite(this, imgs.get("manLEFT"), 102, 64, 1, AnimationType.FIRSTLAST);
        bowSprite = new Sprite(this, imgs.get("bow-export"), 100, 39, 1, AnimationType.FIRSTLAST);

        setPlayerAngleOnPlanet(planetAngle);

    }


    void setPlayerAngleOnPlanet(float planetAngle) {
        this.planetAngle = planetAngle;
        float radians = radians(planetAngle);
        int playerHeight = 35;
        x = planet.x+(planet.r+playerHeight)*cos(radians);
        y = planet.y+(planet.r+playerHeight)*sin(radians);
        idleSprite.setRotation(radians(planetAngle-180));
        drawSprite.setRotation(radians(planetAngle-180));
        hitSprite.setRotation(radians(planetAngle-180));
        holdSprite.setRotation(radians(planetAngle-180));
        bowSprite.setRotation(radians(planetAngle-180));

    }

    void movePlayerOnPlanet(float planetAngle) {
        setPlayerAngleOnPlanet(planetAngle);
    }

    void move() {
        if (this == activePlayer) {
            arrow.move();
            // aimer.update();
            if (arrow.isMoving()) {
                multiplier = 1+(arrow.getAmountRotated()/360);
                roundPoints += (1*multiplier);
            }
        }

        int indexOfHealthPotion = -1;

        for (PlayerItem i: items) {
            switch (i) {
                case PATHFINDER:
                    if (aimer.aiming) {
                        pf = new Pathfinder(x, y, new PVector(aimer.x1-mouseX, aimer.y1-mouseY));
                        pf.draw();
                    }
                    break;
                case HEALTHPOTION:
                    indexOfHealthPotion = items.indexOf(i);
                    break;
            }
        }

        if(indexOfHealthPotion != -1){
            useHealthPotion(indexOfHealthPotion);
        }
    }

    void draw() {
        pushStyle();

        switch(status) {
            case IDLE:
                idleSprite.draw();
                break;
            case DRAW:
                boolean flipDirection = ((degrees(aimer.angleRadians)+180) - planetAngle+360) % 360 - 180 > 0;
                if (drawSprite.animationHasFinished()) {
                    holdSprite.flip(flipDirection);
                    holdSprite.draw();
                    bowSprite.setRotation(aimer.angleRadians+(PI/2));
                    bowSprite.draw();
                } else {
                    drawSprite.flip(!flipDirection);
                    drawSprite.draw();
                }
                break;
            case HIT:
                hitSprite.draw();
                if (hitSprite.animationHasFinished()) {
                    setSprite(PlayerStatus.IDLE);
                }
                break;
        }

        // if (frameCount % 2 == 0) {           // debug code to draw hitbox
        // stroke(255);
        // for (int x=0; x<width; x++) {
        //         for (int y=0; y<height; y++) {
        //             if (collidingWithTest(x, y)) {
        //                 rect(x, y, 1, 1);
        //             }
        //         }
        //     }
        // }

        popStyle();

        // rect(getHitBoxX(), getHitBoxY(), hitBoxWidth, hitBoxHeight);

        if (this == activePlayer) {
            arrow.draw();
            aimer.draw();
        }

        healthBar.draw();
        pointsBar.draw();
    }

    Arrow getArrow() {
        return arrow;
    }

    Aimer getAimer() {
        return aimer;
    }

    public int getHealth() {
        return health;
    }

    public int getRoundPoints() {
        return roundPoints;
    }
    public float getMultiplier() {
        return multiplier;
    }

    public PlayerNum getPlayerNum() {
        return playerNum;
    }

    public void updatePoints(int points) {
        this.points = points;
        if (this.points < 0) this.points = 0;
        this.pointsBar.setContent(String.valueOf(this.points));
    }

    public void removeHeart() {
        if(health == 0){
            return; 
        }
        health--;
        healthBar.animateHealthBarLoss();

        audio.playPlayerHit();

        if (status != PlayerStatus.HIT) {
            setSprite(PlayerStatus.HIT);
        }
    }

    public void setSprite(PlayerStatus status) {
        this.status = status;
        switch(status) {
            case HIT:
                hitSprite.resetToFirstFrame();
                break;
            case DRAW:
                drawSprite.resetToFirstFrame();
                break;
        }
    }
    public float getHitBoxX() {
        return x-hitBoxWidth/2;
    }
    public float getHitBoxY() {
        return y-hitBoxHeight/2;
    }
    public int getSkipTurns(){
        return roundsOfSkip;
    }
    public void setRoundsOfSkip(int num){
        roundsOfSkip = num;
    }

    public void addShopItem(ShopItemRow item) {
        if (item.cost > this.points) {
            //println("You don't have enough money to buy");
            shop.setHintMessageOpen(true);
        } else {
            this.updatePoints(this.points-item.cost);
            items.add(item.playerItem);
            shop.open(false);
            shop.setHintMessageOpen(false);
        }
    }

    public boolean isCollidingWith(float x, float y) {
        float halfWidth = getHitBoxWidth()/2;
        float halfHeight = getHitBoxHeight()/2;

        float translated_x = x - this.x;
        float translated_y = y - this.y;

        float angle = radians(-planetAngle+90);

        float rotated_x = translated_x * cos(angle) - translated_y * sin(angle);
        float rotated_y = translated_x * sin(angle) + translated_y * cos(angle);

        rotated_y += 10;
        rotated_x -= 2;

        return -halfWidth <= rotated_x && rotated_x <= halfWidth && -halfHeight <= rotated_y && rotated_y <= halfHeight;
    }

    private void useHealthPotion(int index){
        if(health < maxHealth){
            health++;
        }
        items.remove(index);
        roundsOfSkip = 3;
        finishPlayerTurn();
    }

    public void skipTurn(){
        if(roundsOfSkip <= 0){
            return;
        }
        roundsOfSkip--;
    }
}
