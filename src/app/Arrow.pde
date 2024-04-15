public class Arrow extends Entity {
  boolean isMoving = false;  // this gets set by the Aimer class when you fire an arrow
  PImage sprite;
  float normalizedX, normalizedY;
  boolean cannotBeCollidedWith = false;

  float startX, startY;

  boolean startedMoving = false;
  boolean spentArrow = false;

  float angleRadians = 0;

  float previousAngle = 0;
  float rotationAmount = 0;

  boolean speedIsChecked;
  int speedAboveThresholdCount;
  int startFrameCount;
  
  Arrow(float x, float y) {
    super(x, y);
    sprite = imgs.get("arrow");
    float scale = 1.5;
    setDimensions(sprite.width*scale, sprite.height*scale);
    setHitBox(1, 1);
  }

  Arrow(Arrow a) {
    this(a.x, a.y);
    this.spentArrow = true;
    velocity.x = a.velocity.x;
    velocity.y = a.velocity.y;
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
            rotationAmount = 0;
            speedAboveThresholdCount = 0;
            startFrameCount = 0;
            speedIsChecked = false;
        }
        else if (cannotBeCollidedWith && abs(startX-x) > 30 && abs(startY-y) > 60) {    // if arrow has moved out of player hitbox, start collisions
            cannotBeCollidedWith = false;
        }

        float arrowHeadRadius = (objWidth/2)*0.8;

        normalizedX = x+arrowHeadRadius*cos(radians(270)+angleRadians);
        normalizedY = y+arrowHeadRadius*sin(radians(270)+angleRadians);

        float degrees = degrees(angleRadians);
        if (!cannotBeCollidedWith) {
            rotationAmount += Math.abs(degrees-previousAngle);
        }
        previousAngle = degrees;


        // speed threshold
        if (!speedIsChecked) {
            startFrameCount += 1;
            if (startFrameCount > 240) {
                finishInvalidPlayerTurn();
                return;
            }
            float speed = sqrt((velocity.x*velocity.x)+(velocity.y*velocity.y));
            if (speed > 4) {
                speedAboveThresholdCount += 1;
                if (speedAboveThresholdCount > 20) {
                    speedIsChecked = true;
                }
            }
        }



        // collision detection

        if (!cannotBeCollidedWith) {
            for (Player p: players) {
                if (p.isCollidingWith(this)) {      // call overrided method in Arrow (this)
                    finishPlayerTurn();
                    return;
                }
            }
        }



        for (Planet planet : planets) {
            if (planet.isCollidingWith(this)) {     // call overrided method in Planet
                finishPlayerTurn();
                return;
            }
        }
        

        super.move();
        camera.setXY(x, y);
    }

    void draw() {
        angleRadians = (float)Math.atan2(velocity.x, -velocity.y);

        if (!isMoving && !spentArrow) return;

        pushMatrix();

        translate(x, y);
        rotate(radians(270));
        rotate(angleRadians);
        imageMode(CENTER);
        image(sprite, 0, 0, objWidth, objHeight);

        popMatrix();
    }

    public float getAmountRotated() {
        return rotationAmount;
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

    public boolean isMoving() {
        return isMoving;
    }
}
