import java.util.Stack;

/*
*   Camera simulation based on scaling all drawings based on x, y and zoom
*/

public class Camera {
    float x, y, targetX, targetY;
    float zoom = 1.0F;
    float zoomXOffset = 0, zoomYOffset = 0;
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

    private boolean cameraEffectivelyAtTarget() {
        return abs(x-targetX) < ARRIVAL_THRESHOLD && abs(y-targetY) < ARRIVAL_THRESHOLD;
    }

    // the main camera function; called during App.draw()
    public void apply() {

        if (hasNotReachedTarget) {

            if (waitFrames > 0) {
                waitFrames--;
            }
            else if (x != targetX || y != targetY) {
                updateXY(lerp(x, targetX, interpolationAmount), lerp(y, targetY, interpolationAmount));
            }
            else {
                hasNotReachedTarget = false;
            }

            if (cameraIsMoving && cameraEffectivelyAtTarget()) {
                cameraIsMoving = false;
            }
        }
        applyXY();
        scale(zoom);
    }

    public void updateXY(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public void updateZoom(float zoom) {
        this.zoom = zoom;
        zoomXOffset = (1-zoom)*(width/2F);
        zoomYOffset = (1-zoom)*(height/2F);
    }

    public void centerOnObject(Obj obj)
    {
        x = obj.getX()-width/2;
        y = obj.getY()-height/2;
    }


    public void animateCenterOnObject(Obj obj, int waitFrames)
    {
        targetX = obj.getX()-width/2;
        targetY = obj.getY()-height/2;

        cameraIsMoving = true;
        hasNotReachedTarget = true;
        this.waitFrames = waitFrames;
        //image(backgroundImage, 0, 0, screenWidth, screenHeight);
    }

    public void keyMove() {
        if (keys.get(LEFT)) {
            updateXY(x-2, y);
        }
        else if (keys.get(RIGHT)) {
            updateXY(x+2, y);
        }
        else if (keys.get(UP)) {
            updateXY(x, y-2);
        }
        else if (keys.get(DOWN)) {
            updateXY(x, y+2);
        }
        else if (keys.get(W)) {
            updateZoom(zoom+0.01F);
        }
        else if (keys.get(S)) {
            updateZoom(zoom-0.01F);
        }
    }

    public void pushZoom() {
        zoomStack.push(zoom);
        updateZoom(1);
    }

    public void popZoom() {
        if (zoomStack.empty()) return;
        updateZoom(zoomStack.pop());
    }

    public void applyXY() {
        translate(-x+zoomXOffset, -y+zoomYOffset);
        //image(backgroundImage, 0, 0);
    }

    public boolean isMoving() {
        return cameraIsMoving;
    }
}
