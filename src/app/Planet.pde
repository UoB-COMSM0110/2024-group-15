import processing.core.PVector;

class Planet extends Object {
    float mass;
    float r;

    Planet(int x, int y, int mass) {
        super(x, y);
        this.mass = mass;
        this.r = mass/10F;
    }

    Planet(int x, int y, int mass, int radius) {
        this(x, y, mass);
        this.r = radius;
    }

    void move() {

    }

    void draw() {
        fill(0, 255, 0);
        ellipse(x, y, r*2, r*2);
    }

    // Calculate gravitational force exerted by the planet on an object (maths which no one understands)
    PVector calculateGravity(Object obj) {
        float G = 0.1F;
        PVector direction = new PVector(x-obj.x, y-obj.y);

        float distance = direction.mag();

        distance = constrain(distance, 5, 25);

        float objectMass = 1F;
        float forceMagnitude = (G * mass * objectMass) / (distance * distance);

        direction.normalize();
        direction.mult(forceMagnitude);

        return direction;
    }
}