import processing.core.PVector;

class Planet extends Object {
    float mass;  // Mass

    Planet(App app, int x, int y, int mass) {
        super(app, x, y, new PVector(0 ,0));
        this.mass = mass;
    }

    void move() {

    }

    void draw() {
        app.fill(0, 255, 0);
        app.ellipse(loc.x, loc.y, mass/10, mass/10);
    }

    // Calculate gravitational force exerted by the planet on a space object
    PVector calculateGravity(Object obj) {
        float G = 0.1F;  // Gravitational constant

        // Calculate direction vector
        PVector direction = new PVector(loc.x - obj.loc.x, loc.y - obj.loc.y);

        float distance = direction.mag();

        // Avoid division by zero
        distance = App.constrain(distance, 5, 25);

        // Calculate gravitational force magnitude

        float objectMass = 1F;
        float forceMagnitude = (G * mass * objectMass) / (distance * distance);

        // Normalize the direction vector and scale by force magnitude
        direction.normalize();
        direction.mult(forceMagnitude);

        return direction;
    }
}