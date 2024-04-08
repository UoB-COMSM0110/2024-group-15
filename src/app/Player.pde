enum PlayerStatus {
    IDLE,
    DRAW,
    HIT,
}


public class Player extends Entity {
    PlayerNum playerNum;
    Arrow arrow;
    Aimer aimer;
    Planet planet;
    Sprite idleSprite;
    Sprite drawSprite;
    Sprite hitSprite;
    PlayerStatus status = PlayerStatus.IDLE; 
    int planetAngle;
   

    int health = maxHealth;
    HealthBar healthBar;
    


    Player(Planet planet, int planetAngle, PlayerNum playerNum) {
        super(planet.x, planet.y, 30, 60);   // TODO this will change when we use an image instead of a rect
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


        idleSprite = new Sprite(this, imgs.get("player-idle"), 102, 64, 13, AnimationType.LOOP);
        drawSprite = new Sprite(this, imgs.get("player-draw"), 102, 64, 8, AnimationType.FIRSTLAST);
        hitSprite = new Sprite(this, imgs.get("player-hit"), 102, 64, 6, AnimationType.FIRSTLAST);
    }

void draw() {
    if (this == activePlayer) {
        if (arrow.isMoving) arrow.move();
        aimer.update();
    }

    pushStyle();

    switch(status) {
        case IDLE:
            idleSprite.draw();
            break;
        case DRAW:
            drawSprite.draw();
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
}

    Arrow getArrow() {
        return arrow;
    }

    public int getHealth() {
        return health;
    }

    public PlayerNum getPlayerNum() {
        return playerNum;
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
}
