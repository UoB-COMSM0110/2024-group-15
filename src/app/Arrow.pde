public class Arrow extends Obj {
    boolean isMoving = false;  // this gets set by the Aimer class when you fire an arrow
    PImage sprite;
    float realWidth, realHeight;        // TODO instead of this, use a hitbox width+height as well for Objs
    float normalizedX, normalizedY;

    Arrow(float x, float y) {
        super(x, y);
        sprite = imgs.get("arrow");
        float scale = 1.5;
        realWidth = sprite.width*scale;
        realHeight = sprite.height*scale;
        setDimensions(1, 1);    // set dimensions to 1, 1 so collision only occurs at the arrowhead
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
            return;
        }

        // planet collision detection
        // not perfect, as it doesn't let arrows fly sideways close to a planet
        for (Planet planet : planets) {
            if (planet.isCollidingWith(this)) {
                stopMovingAndFinishTurn();
                return;
            }
        }
        for (Player p: players) {
            if (p.isCollidingWith(this)) {
                stopMovingAndFinishTurn();
                return;
            }
        }        
        super.move();
        camera.updateXY(x-screenWidth/2F, y-screenHeight/2F);
    }

    void draw() {
        float angleRadians = (float)Math.atan2(velocity.x, -velocity.y);

        pushMatrix();

        translate(x, y);
        rotate(radians(270));
        rotate(angleRadians);
        imageMode(CENTER);
        image(sprite, 0, 0, realWidth, realHeight);

        popMatrix();

        float arrowHeadRadius = (realWidth/2)*0.8;

        normalizedX = x+arrowHeadRadius*cos(radians(270)+angleRadians);
        normalizedY = y+arrowHeadRadius*sin(radians(270)+angleRadians);
    }

    public float getX() {
        return normalizedX;
    }
    public float getY() {
        return normalizedY;
    }
}
