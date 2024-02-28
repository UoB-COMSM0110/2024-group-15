
public class Player extends Obj {
    Arrow arrow;
    Aimer aimer;
    Planet planet;
    int planetAngle;

    // HealthBar healthBar;

    Player(Planet planet, int planetAngle) {
        super(planet.x, planet.y);
        this.planetAngle = planetAngle;
        this.planet = planet;

        double radians = Math.toRadians(planetAngle);

        // placeholder name; this should be generalized within object
        int valueThatShouldBeDependantUponSprite = 30;
        x += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.cos(radians));
        y += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.sin(radians));

        arrow = new Arrow(x, y);
        aimer = new Aimer(this, arrow);
        // healthBar = new HealthBar(this, 20, 20);
    }

    void draw() {
        if (this == activePlayer) {
            if (arrow.isMoving) arrow.move();
            aimer.update();
        }
        pushStyle();
        fill(255, 255, 255);
        rect(x, y, 30, 60);
        popStyle();

        arrow.draw();
//        healthBar.draw();
    }

}
