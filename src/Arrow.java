import processing.core.PApplet;
import processing.core.PImage;

public class Arrow extends Object {
    boolean isMoving = false;  // this gets set by the Aimer class when you fire an arrow
    PImage sprite;

    Arrow(App app, float x, float y) {
        super(app, x, y);
        sprite = app.imgs.get("arrow");
    }

    void move() {
        if (!isMoving) {
            return;
        }

        // planet collision detection
        // not perfect, as it doesn't let arrows fly sideways close to a planet
        for (Planet planet : app.planets) {
            float dxsq = (x-planet.x)*(x-planet.x);
            float dysq = (y-planet.y)*(y-planet.y);

            double distance = Math.sqrt(dxsq + dysq);

            if (distance < planet.r + (sprite.width*1.5F)/2 - 5) {
                isMoving = false;
                return;
            }
        }
        super.move();

        app.camera.updateXY(x-app.screenWidth/2F, y-app.screenHeight/2F);
    }

    void draw() {
        float angleRadians = (float)Math.atan2(velocity.x, -velocity.y);
        app.pushMatrix();
        app.translate(x, y);
        app.rotate(PApplet.radians(270));
        app.rotate(angleRadians);
        app.imageMode(app.CENTER);
        app.image(sprite, 0, 0, sprite.width*1.5F, sprite.height*1.5F);
        app.popMatrix();
    }
}
