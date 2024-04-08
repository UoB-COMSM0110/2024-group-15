public class Arrow extends Entity {
    boolean isMoving = false;  // this gets set by the Aimer class when you fire an arrow
    PImage sprite;
    float normalizedX, normalizedY;
    boolean cannotBeCollidedWith = false;

    float startX, startY;

    boolean startedMoving = false;

    Arrow(float x, float y) {
        super(x, y);
        sprite = imgs.get("arrow");
        float scale = 1.5;
        setDimensions(sprite.width*scale,  sprite.height*scale);
        setHitBox(1, 1);
    }

    Arrow(Arrow a) {
        this(a.x, a.y);
        velocity.x = a.velocity.x;
        velocity.y = a.velocity.y;
    }

    void stopMovingAndFinishTurn() {
        isMoving = false;
        finishPlayerTurn();
    }

    void move() {
        if (!isMoving) {
            startedMoving = false;
            return;
        }
        if (startedMoving == false) {   // first frame of movement
            startX = x;
            startY = y;
            startedMoving = true;
            cannotBeCollidedWith = true;
        }
        else if (cannotBeCollidedWith && abs(startX-x) > 30 && abs(startY-y) > 60) {    // if arrow has moved out of player hitbox, start collisions
            cannotBeCollidedWith = false;
        }


        // collision detection
        for (Planet planet : planets) {
            if (planet.isCollidingWith(this)) {     // call overrided method in Planet
                stopMovingAndFinishTurn();
                return;
            }
        }
        
        for (Player p: players) {
            if (this.isCollidingWith(p)) {               // call overrided method in Arrow (this)
                stopMovingAndFinishTurn();
                return;
            }
        }        
        super.move();
        camera.updateXY(x-width/2, y-height/2);
    }

    void draw() {
        float angleRadians = (float)Math.atan2(velocity.x, -velocity.y);

        pushMatrix();

        translate(x, y);
        rotate(radians(270));
        rotate(angleRadians);
        imageMode(CENTER);          // TODO just have this at the start maybe
        image(sprite, 0, 0, objWidth, objHeight);

        popMatrix();

        float arrowHeadRadius = (objWidth/2)*0.8;

        normalizedX = x+arrowHeadRadius*cos(radians(270)+angleRadians);
        normalizedY = y+arrowHeadRadius*sin(radians(270)+angleRadians);
    }

    public float getX() {
        return normalizedX;
    }
    public float getY() {
        return normalizedY;
    }

    public float getHitBoxX() {
        return normalizedX;
    }

    public float getHitBoxY() {
        return normalizedY;
    }

    @Override
    public boolean isCollidingWith(Entity e) {
        return cannotBeCollidedWith ? false : super.isCollidingWith(e);
    }

    public boolean isMoving() {
        return isMoving;
    }
}
