/*
*  The abstract class for entity (typically moving) objects drawn to the screen
*/


abstract class Entity extends Obj {
    PVector velocity = new PVector(0, 0);
    float hitBoxWidth = 0;
    float hitBoxHeight = 0;

    Entity(float x, float y) {
        super(x, y);
    }

    Entity(float x, float y, int width, int height) {
        super(x, y, width, height);
        hitBoxWidth = width;
        hitBoxHeight = height;
    }

    Entity(float x, float y, int width, int height, PVector velocity) {
        this(x, y, width, height);
        this.velocity = velocity;
    }

    public void setHitBox(float width, float height) {
        hitBoxWidth = width;
        hitBoxHeight = height;
    }

    public boolean isCollidingWith(Entity e)
    {
        // for rectangles
        return  getHitBoxX() + getHitBoxWidth() >= e.getHitBoxX()       &&
                e.getHitBoxX() + e.getHitBoxWidth() >= getHitBoxX()     &&
                getHitBoxY() + getHitBoxHeight() >= e.getHitBoxY()      &&
                e.getHitBoxY() + e.getHitBoxHeight() >= getHitBoxY();
    }

    public float getHitBoxWidth() {
        return hitBoxWidth;
    }
    public float getHitBoxHeight() {
        return hitBoxHeight;
    }
    public float getHitBoxX() {
        return x;
    }
    public float getHitBoxY() {
        return y;
    }

    void move() {
        // calculates the velocity based on planet gravity (only used by the arrows at the moment, maybe players in the future?)
        PVector acceleration = new PVector(0, 0);
        for (Planet p : planets) {
            acceleration.add(p.calculateGravity(this));
        }
        acceleration.div(1);
        velocity.add(acceleration);
        x += velocity.x;
        y += velocity.y;
    }
}
