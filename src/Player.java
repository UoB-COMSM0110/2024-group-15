
public class Player extends Object {
    Arrow arrow;
    Aimer aimer;
    Planet planet;
    int planetAngle;

    HealthBar healthBar;

    Player(Planet planet, int planetAngle) {
        super(planet.app, planet.x, planet.y);
        this.planetAngle = planetAngle;
        this.planet = planet;

        double radians = Math.toRadians(planetAngle);

        // placeholder name; this should be generalized within object
        int valueThatShouldBeDependantUponSprite = 30;
        x += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.cos(radians));
        y += (float) ((planet.r+valueThatShouldBeDependantUponSprite)*Math.sin(radians));

        arrow = new Arrow(app, x, y);
        aimer = new Aimer(app, this, arrow);
        healthBar = new HealthBar(this, 20, 20);
    }

    void draw() {
        if (this == app.activePlayer) {
            if (arrow.isMoving) arrow.move();
            aimer.update();
        }
        app.pushStyle();
        app.fill(255, 255, 255);
        app.rect(x, y, 30, 60);
        app.popStyle();

        arrow.draw();
//        healthBar.draw();
    }

}
