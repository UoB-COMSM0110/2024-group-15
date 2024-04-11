import java.util.Stack;

/*
*   Camera simulation based on scaling all drawings on x, y and zoom
*/

public class Camera {
    float x, y, targetX, targetY;
    float zoom = 1;
    Stack<Float> zoomStack = new Stack<>();

    private final int ARRIVAL_THRESHOLD = 4; // The distance (in pixels) from the target when isMoving is changed to false
    boolean cameraIsMoving = false;
    private boolean hasNotReachedTarget = false;
    int waitFrames;
    float interpolationAmount = 0.02;   // speed with which the camera moves at
    Runnable animationFinishCallback = null;

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
            else if (!cameraEffectivelyAtTarget(1)) {       // these are floating points, so cant directly compare.
                setXY(lerp(x, targetX, interpolationAmount), lerp(y, targetY, interpolationAmount));
            }
            else {
                hasNotReachedTarget = false;
            }
            if (cameraEffectivelyAtTarget(20) && animationFinishCallback != null) {
                    animationFinishCallback.run();
                    animationFinishCallback = null;
            }
            if (cameraIsMoving && cameraEffectivelyAtTarget(10)) {
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
        animateCenterOnXY(obj.getX(), obj.getY(), waitFrames);
    }

    public void animateCenterOnXY(float x, float y, int waitFrames) {
        targetX = x;
        targetY = y;

        cameraIsMoving = true;
        hasNotReachedTarget = true;
        this.waitFrames = waitFrames;
    }

    public void animateCenterOnObject(Obj obj, int waitFrames, Runnable callback) {
        animateCenterOnObject(obj, waitFrames);
        animationFinishCallback = callback;
    }

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
        return cameraEffectivelyAtTarget(ARRIVAL_THRESHOLD);
    }

    private boolean cameraEffectivelyAtTarget(int threshold) {
        return abs(x-targetX) < threshold && abs(y-targetY) < threshold;
    }

    public float getRealMouseX() {
        return mouseX+x-width/2;
    }

    public float getRealMouseY() {
        return mouseY+y-height/2;
    }
}
