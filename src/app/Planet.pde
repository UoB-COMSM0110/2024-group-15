

class Planet extends Entity {
    float mass;
    float r;
    PImage  sprite;
    int numberOfArrowsOnMe;      // used to count the number of arrows (cheating mode)

    Planet(int x, int y, int mass, PImage sprite) {
// =======


//     Planet(int x, int y, int mass) {
// >>>>>>> main
        super(x, y);
        this.mass = mass;
        this.r = mass/10F;

        setDimensions(r*2, r*2);
        setHitBox(r*2, r*2);
        this.sprite=sprite;

/*
        imageMode(CENTER);
        image(sprite, 0, 0, realWidth, realHeight);
*/

        numberOfArrowsOnMe = 0;
    }

    Planet(int x, int y, int mass, int radius) {
        this(x, y, mass, imgs.get("planet1"));
        this.r = radius;
    }

    public void increaseNumberOfArrowsHit(){   //(cheating point related)
        ++numberOfArrowsOnMe;
        //if (numberOfArrowOnMe == 10){ // Enter shop mode when arrow count reaches 10
        //    enterShopMode();
        //}
    }

    public int getNumberOfArrowsOnMe() {
        return numberOfArrowsOnMe;
    }




// >>>>>>> main

    void move() { /* planets don't move at the moment */ }


    void draw() {
        imageMode(CENTER);
        image(this.sprite, x, y, r * 2, r * 2);
    }
   

    public float getRadius() {
        return r;
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
