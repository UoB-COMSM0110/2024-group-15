import java.util.Stack;

/*
*   Camera simulation based on scaling all drawings on x, y and zoom
*/

public class Camera {
    float x, y, targetX, targetY;
    float zoom = 1;
    Stack<Float> zoomStack = new Stack<>();

    private final int ARRIVAL_THRESHOLD = 4; // The distance (in pixels) from the target when isMoving is changed to false
    private boolean cameraIsMoving = false;
    private boolean hasNotReachedTarget = false;
    int waitFrames;
    float interpolationAmount = 0.02;   // speed with which the camera moves at

    Camera() {
        this.x = 0;
        this.y = 0;
    }

    /**
     *  the main camera function; called during App.draw()
     */
    public void apply() {
        if (hasNotReachedTarget) {

            if (waitFrames > 0) {
                waitFrames--;
            }
            else if (x != targetX || y != targetY) {
                setXY(lerp(x, targetX, interpolationAmount), lerp(y, targetY, interpolationAmount));
            }
            else {
                hasNotReachedTarget = false;
            }
            if (cameraIsMoving && cameraEffectivelyAtTarget()) {
                cameraIsMoving = false;
            }
        }
        applyXY();
    }

    public void setXY(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public void setZoom(float zoom) {
        this.zoom = zoom;
    }

    public void animateCenterOnObject(Obj obj, int waitFrames)
    {
        targetX = obj.getX();
        targetY = obj.getY();

        cameraIsMoving = true;
        hasNotReachedTarget = true;
        this.waitFrames = waitFrames;
    }

    // public void keyMove() {
    //     if (keys.get(LEFT)) {
    //         setXY(x-2, y);
    //     }
    //     else if (keys.get(RIGHT)) {
    //         setXY(x+2, y);
    //     }
    //     else if (keys.get(UP)) {
    //         setXY(x, y-2);
    //     }
    //     else if (keys.get(DOWN)) {
    //         setXY(x, y+2);
    //     }
    //     else if (keys.get(W)) {
    //         setZoom(zoom+0.01F);
    //     }
    //     else if (keys.get(S)) {
    //         setZoom(zoom-0.01F);
    //     }
    // }

    public void pushZoom() {
        zoomStack.push(zoom);
        setZoom(1);
    }

    public void popZoom() {
        if (zoomStack.empty()) return;
        setZoom(zoomStack.pop());
    }

    public void applyXY() {
        translate(width/2, height/2);
        scale(zoom);
        translate(-x, -y);
    }

    public boolean isMoving() {
        return cameraIsMoving;
    }

    private boolean cameraEffectivelyAtTarget() {
        return abs(x-targetX) < ARRIVAL_THRESHOLD && abs(y-targetY) < ARRIVAL_THRESHOLD;
    }
}
