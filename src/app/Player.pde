
public class Player extends Obj {
  
  
    Arrow arrow;
    Aimer aimer;
    Planet planet;
    Animation animation;
    //int playerStatus; 
    int planetAngle;
   

    int health = 10;
    HealthBar healthBar;
    

    Player(Planet planet, int planetAngle, HeathBarPosition heathBarPosition) {
        super(planet.x, planet.y);
        this.planetAngle = planetAngle;
        this.planet = planet;
        //this.playerstatus=STANDBY;

        double radians = Math.toRadians(planetAngle);

        // placeholder name; this should be generalized within object
        int valueThatShouldBeDependantUponSprite = 35;
        x += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.cos(radians));
        y += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.sin(radians));

        arrow = new Arrow(x, y);
        aimer = new Aimer(this, arrow);

        setDimensions(30, 60);      // TODO placeholder until actual player sprite

        healthBar = new HealthBar(this, heathBarPosition);
        animation = new Animation(1);
        
         animation.status=1;
    }

    void draw() {
        if (this == activePlayer) {
            if (arrow.isMoving) arrow.move();
            aimer.update();
        }else{
          animation.status=1;
          animation.playAnimationLoop(this);
          
        //TODO play standby status;
        }
        pushStyle();
        //player standby
        fill(255, 255, 255);
        rect(x, y, objWidth, objHeight);
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

    public void removeHeart() {
      //TODO play a hit animation.
        health--;
        healthBar.animateHealthBarLoss();
    } 

    // TODO temporary overrides until we use an actual image
    public float getX() {
        return x+(objWidth/2);
    }
    public float getY() {
        return y+(objWidth/2);
    }
}
