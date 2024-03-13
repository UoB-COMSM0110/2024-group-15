<<<<<<< HEAD
public class Player extends Entity {
    PlayerNum playerNum;
=======

public class Player extends Obj {
  
  
>>>>>>> Ada
    Arrow arrow;
    Aimer aimer;
    Planet planet;
    Animation animation;
    //int playerStatus; 
    int planetAngle;
   

    int health = 10;
    HealthBar healthBar;
    


    Player(Planet planet, int planetAngle, PlayerNum playerNum) {
        super(planet.x, planet.y, 30, 60);   // TODO this will change when we use an image instead of a rect
        this.planetAngle = planetAngle;
        this.planet = planet;
<<<<<<< HEAD
        this.playerNum = playerNum;
=======
        //this.playerstatus=STANDBY;
>>>>>>> Ada

        double radians = Math.toRadians(planetAngle);

        // TODO placeholder name; this should be generalized within object
        int valueThatShouldBeDependantUponSprite = 35;
        x += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.cos(radians));
        y += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.sin(radians));

        arrow = new Arrow(x, y);
        aimer = new Aimer(this, arrow);

<<<<<<< HEAD
        healthBar = new HealthBar(this, playerNum);
    }

    void draw() {
        if (this == activePlayer) {
            if (arrow.isMoving) arrow.move();
            aimer.update();
        }
        pushStyle();
        fill(255, 255, 255);
        rect(x, y, objWidth, objHeight);
        popStyle();

        if (this == activePlayer) {
            arrow.draw();
        }
=======
        setDimensions(30, 60);      // TODO placeholder until actual player sprite

        healthBar = new HealthBar(this, heathBarPosition);
        animation = new Animation(1);
>>>>>>> Ada
        

    }

void draw() {
    if (this == activePlayer) {
        if (arrow.isMoving) arrow.move();
        aimer.update();
        if (animation.status != 2) {
            animation.status = 2;
            animation.loadImages();
        }
        animation.playAnimationStatic(this);
    } else {
        if (animation.status != 1) {
            animation.status = 1;
            animation.loadImages();
        }
        animation.playAnimationLoop(this);
        // TODO play standby status;
    }

    pushStyle();
    //player standby
    //fill(255, 255, 255);
    //rect(x, y, objWidth, objHeight);
    if (animation.status == 1) {
           // animation.loadImages();
            animation.playAnimationLoop(this);
        }else{
         // animation.loadImages();
          animation.playAnimationStatic(this);
          
        }
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
      //TODO play a hit animation.
        health--;
        healthBar.animateHealthBarLoss();
    } 

    // TODO temporary overrides until we use an actual image
    public float getX() {
        return x;
    }
    public float getY() {
        return y;
    }
}
