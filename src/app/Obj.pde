/*
*  The abstract class for all objects drawn to the screen
*/

abstract class Obj {
    PVector velocity;
    float x, y;
    float objWidth, objHeight, hitBoxWidth, hitBoxHeight;

    Obj(float x, float y, int width, int height, PVector velocity) {
        this.x = x;
        this.y = y;
        objWidth = hitBoxWidth = width;
        objHeight = hitBoxHeight = height;
        this.velocity = velocity;
    }

    Obj(float x, float y, int width, int height) {
        this(x, y, width, height, new PVector(0, 0));
    }

    Obj(float x, float y) {
        this(x, y, 0, 0);
    }

    public void setDimensions(float width, float height) {
        objWidth = width;
        objHeight = height;
    }

    public void setHitBox(float width, float height) {
        hitBoxWidth = width;
        hitBoxHeight = height;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public boolean isCollidingWith(Obj obj)
    {
        // for rectangles
        return  getX() + getHitBoxWidth() >= obj.getX()     &&
                obj.getX() + obj.getHitBoxWidth() >= getX() &&
                getY() + getHitBoxHeight() >= obj.getY()    &&
                obj.getY() + obj.getHitBoxHeight() >= getY();
    }

    public float getHitBoxWidth() {
        return hitBoxWidth;
    }
    public float getHitBoxHeight() {
        return hitBoxHeight;
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
