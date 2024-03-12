

class Planet extends Entity {
    float mass;
    float r;

    Planet(int x, int y, int mass) {
        super(x, y);
        this.mass = mass;
        this.r = mass/10F;
        setDimensions(r*2, r*2);
        setHitBox(r*2, r*2);
    }

    Planet(int x, int y, int mass, int radius) {
        this(x, y, mass);
        this.r = radius;
    }

    void move() { /* planets don't move at the moment */ }

    void draw() {
        fill(0, 255, 0);
        ellipse(x, y, r*2, r*2);
    }

    public boolean isCollidingWith(Entity e)
    {
        float dxsq = (e.getX()-x)*(e.getX()-x);
        float dysq = (e.getY()-y)*(e.getY()-y);

        double distance = Math.sqrt(dxsq + dysq);

        if (distance < r + (e.getHitBoxWidth())/2 - 5) {
            return true;
        }
        return false;
    }

    // Calculate gravitational force exerted by the planet on an object (maths which no one understands)
    PVector calculateGravity(Obj obj) {
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