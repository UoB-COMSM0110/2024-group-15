/*
*  The abstract class for all objects drawn to the screen
*/

abstract class Obj {
    PVector velocity;
    float x, y;
    int objWidth, objHeight;

    Obj(float x, float y, PVector velocity) {
        this.x = x;
        this.y = y;
        this.velocity = velocity;
    }

    Obj(float x, float y) {
        this(x, y, new PVector(0, 0));
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public boolean isCollidingWith(Obj obj)
    {
        return  !(getX() + objWidth < obj.getX() ||
                obj.getX() + obj.objWidth < getX() ||
                getY() + objHeight < obj.getY() ||
                obj.getY() + obj.objHeight < getY());
    }

    public void setDimensions(float width, float height)
    {
        objWidth = (int)width;
        objHeight = (int)height;
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
