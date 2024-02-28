/*
*  The abstract class for all objects drawn to the screen
*/

abstract class Obj {
    PVector velocity;
    float x, y;

    Obj(float x, float y, PVector velocity) {
        this.x = x;
        this.y = y;
        this.velocity = velocity;
    }

    Obj(float x, float y) {
        this(x, y, new PVector(0, 0));
    }

    void move() {
        // calculates the velocity based on planet gravity (only used by the arrows at the moment)
        PVector acceleration = new PVector(0, 0);
        for (Planet p : planets) {
            acceleration.add(p.calculateGravity(this));
        }
        acceleration.div(1);
        velocity.add(acceleration);
        x += velocity.x;
        y += velocity.y;
    }

    abstract void draw();
}
