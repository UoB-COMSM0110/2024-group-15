/*
*  The abstract class for all objects drawn to the screen
*  This isn't an actual 'abstract' class yet as it is used by the pathfinder test, but it should be!
*/

import processing.core.PVector;

public class Object {
    PVector velocity;
    float x, y;

    Object(float x, float y, PVector velocity) {
        this.x = x;
        this.y = y;
        this.velocity = velocity;
    }

    Object(float x, float y) {
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

    // TODO put these into an interface/abs class
    void draw() {}
}
