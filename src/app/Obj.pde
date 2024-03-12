/*
*  The abstract class for all objects drawn to the screen
*/

abstract class Obj {
    float x, y, objWidth, objHeight;

    Obj(float x, float y) {
        this.x = x;
        this.y = y;
    }

    Obj(float x, float y, float width, float height) {
        this(x, y);
        setDimensions(width, height);
    }

    public void setDimensions(float width, float height) {
        this.objWidth = width;
        this.objHeight = height;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    abstract void draw();
}
