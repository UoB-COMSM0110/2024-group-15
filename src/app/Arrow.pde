public class Arrow extends Entity {
  boolean isMoving = false;  // this gets set by the Aimer class when you fire an arrow
  PImage sprite;
  //PImage bowSprite;
  float normalizedX, normalizedY;
  boolean cannotBeCollidedWith = false;
  //boolean showBow = true;

  float startX, startY;

  boolean startedMoving = false;

  Arrow(float x, float y) {
    super(x, y);
    sprite = imgs.get("arrow");
    //bowSprite = imgs.get("bow");
    float scale = 1.5;
    setDimensions(sprite.width*scale, sprite.height*scale);
    //setDimensions(bowSprite.width*1.05, bowSprite.height*1.05);
    setHitBox(1, 1);
  }

  Arrow(Arrow a) {
    this(a.x, a.y);
    velocity.x = a.velocity.x;
    velocity.y = a.velocity.y;
  }

  void stopMovingAndFinishTurn() {
    isMoving = false;
    //boolean showBow = false;
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
      //showBow = true;
    } else if (cannotBeCollidedWith && abs(startX-x) > 30 && abs(startY-y) > 60) {    // if arrow has moved out of player hitbox, start collisions
      cannotBeCollidedWith = false;
      //bowSprite = null;
      //showBow = false;
    }


    // collision detection
    for (Planet planet : planets) {
      if (planet.isCollidingWith(this)) {     // call overrided method in Planet
        stopMovingAndFinishTurn();
        //showBow=false;
        return;
      }
    }

    for (Player p : players) {
      if (this.isCollidingWith(p)) {               // call overrided method in Arrow (this)
        stopMovingAndFinishTurn();
        return;
      }
    }
    super.move();
    camera.updateXY(x-width/2, y-height/2);
    //redraw();
  }

  void draw() {
    float angleRadians = (float)Math.atan2(velocity.x, -velocity.y);

    pushMatrix();

    translate(x, y);
    rotate(radians(270));
    rotate(angleRadians);
    imageMode(CENTER);
    image(sprite, 0, 0, objWidth, objHeight);
    //if (showBow) { 
    //  image(bowSprite, 0, 0, objWidth, objHeight);
    //}
    //image(bowSprite, 0, 0, objWidth, objHeight);

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

  @Override
    public boolean isCollidingWith(Entity e) {
    return cannotBeCollidedWith ? false : super.isCollidingWith(e);
  }
}
