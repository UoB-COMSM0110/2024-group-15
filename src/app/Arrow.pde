public class Arrow extends Object {
    boolean isMoving = false;  // this gets set by the Aimer class when you fire an arrow
    PImage sprite;

    Arrow(float x, float y) {
        super(x, y);
        sprite = imgs.get("arrow");
    }

    void move() {
        if (!isMoving) {
            return;
        }

        // planet collision detection
        // not perfect, as it doesn't let arrows fly sideways close to a planet
        for (Planet planet : planets) {
            float dxsq = (x-planet.x)*(x-planet.x);
            float dysq = (y-planet.y)*(y-planet.y);

            double distance = Math.sqrt(dxsq + dysq);

            if (distance < planet.r + (sprite.width*1.5F)/2 - 5) {
                isMoving = false;
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
        image(sprite, 0, 0, sprite.width*1.5F, sprite.height*1.5F);
        popMatrix();
    }
}
