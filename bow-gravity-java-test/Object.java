import processing.core.PVector;

public class Object {

    App app;

    PVector velocity;
    PVector acceleration = new PVector(0,0);
    PVector loc;

    Object(App app, int x, int y, PVector velocity) {
        this.app = app;
        loc = new PVector(x, y);
        this.velocity = velocity;
    }

    void move() {
//        velocity.y += app.gravity;

        for (Planet p : app.planets) {
            PVector pGrav = p.calculateGravity(this);
            pGrav.div(1);
            acceleration.add(pGrav);
            velocity.add(acceleration);
        }
        loc.x += velocity.x;
        loc.y += velocity.y;

        acceleration.mult(0);
    }

    void draw() {
        app.rect(loc.x, loc.y, 20, 20);
    }
}
