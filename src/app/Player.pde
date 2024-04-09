enum PlayerStatus {
    IDLE,
    DRAW,
    HIT,
}

enum PlayerItem {
    PATHFINDER,
    HITSKIP,
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
    int planetAngle;

    Pathfinder pf;
    List<PlayerItem> items = new ArrayList<>();

    int health = maxHealth;
    HealthBar healthBar;

    int points = 0;
    int roundPoints = 0;
    float multiplier = 1;
    PointsBar pointsBar;

    private boolean hasUsedShop = false;

    Player(Planet planet, int planetAngle, PlayerNum playerNum) {
        super(planet.x, planet.y, 30, 60);
        this.planetAngle = planetAngle;
        this.planet = planet;

        this.playerNum = playerNum;

        setHitBox(getHitBoxWidth()-10, getHitBoxHeight()-15);


        double radians = Math.toRadians(planetAngle);

        // TODO placeholder name; this should be generalized within object
        int valueThatShouldBeDependantUponSprite = 35;
        x += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.cos(radians));
        y += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.sin(radians));

        arrow = new Arrow(x, y);
        aimer = new Aimer(this, arrow);

        healthBar = new HealthBar(this, playerNum);
        pointsBar = new PointsBar(this, playerNum);

        idleSprite = new Sprite(this, imgs.get("player-idle"), 102, 64, 13, AnimationType.LOOP);
        drawSprite = new Sprite(this, imgs.get("player-draw"), 102, 64, 8, AnimationType.FIRSTLAST);
        hitSprite = new Sprite(this, imgs.get("player-hit"), 102, 64, 6, AnimationType.FIRSTLAST);
        holdSprite = new Sprite(this, imgs.get("manLEFT"), 102, 64, 1, AnimationType.FIRSTLAST);

        bowSprite = new Sprite(this, imgs.get("bow-export"), 100, 39, 1, AnimationType.FIRSTLAST);
    }

    void move() {
        if (this == activePlayer) {
            arrow.move();
            aimer.update();
            if (arrow.isMoving()) {
                multiplier = 1+(arrow.getAmountRotated()/360);
                roundPoints += (1*multiplier);
            }
        }

        for (PlayerItem i: items) {
            switch (i) {
                case PATHFINDER:
                    if (aimer.aiming) {
                        pf = new Pathfinder(arrow.x, arrow.y, new PVector(aimer.x1-mouseX, aimer.y1-mouseY));
                        pf.draw();
                    }
                    break;
            }
        }
    }

    void draw() {
        pushStyle();

        switch(status) {
            case IDLE:
                idleSprite.draw();
                break;
            case DRAW:
                float degs = degrees(arrow.angleRadians);
                if (drawSprite.animationHasFinished()) {

                    holdSprite.flip(degs > 0 ? true : false);
                    holdSprite.draw();
                    bowSprite.setRotation(arrow.angleRadians);
                    bowSprite.draw();
                } else{
                    drawSprite.flip(degs < 0 ? true : false);
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

        // rect(getHitBoxX(), getHitBoxY(), hitBoxWidth, hitBoxHeight);

        popStyle();

        if (this == activePlayer) {
            arrow.draw();
        }

        healthBar.draw();
        pointsBar.draw();
    }

    Arrow getArrow() {
        return arrow;
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
        health--;
        healthBar.animateHealthBarLoss();

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
        return y-hitBoxHeight/2+12;
    }

    public void addShopItem(PlayerItem i) {
        items.add(i);
    }

    public boolean hasUsedShop() {
        return this.hasUsedShop;
    }

    public void markAsUsedShop() {
        this.hasUsedShop = true;
    }
}
