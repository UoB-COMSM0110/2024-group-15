/*
* This class simulates a camera by scaling all drawings based on x, y and zoom
*/
import java.util.Stack;


public class Camera {
    float x, y, targetX, targetY;
    float zoom = 1.0F;
    float zoomXOffset = 0, zoomYOffset = 0;
    Stack<Float> zoomStack = new Stack<>();

    boolean cameraIsMoving = false;
    int waitFrames;
    float interpolationAmount = 0.02;   // speed with which the camera moves at


    Camera() {
        this.x = 0;
        this.y = 0;
    }

    // the main camera function; called during App.draw()
    public void apply() {
        if (cameraIsMoving) {
            if (waitFrames > 0) {
                waitFrames--;
            }
            else if (x != targetX && y != targetY) {
                updateXY(lerp(x, targetX, interpolationAmount), lerp(y, targetY, interpolationAmount));
            }
            else {
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
        this.waitFrames = waitFrames;
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
    }
}
