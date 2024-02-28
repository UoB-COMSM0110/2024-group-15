/*
* This class simulates a camera by scaling all drawings based on x, y and zoom
*/
import java.util.Stack;


public class Camera {
    float x, y;
    float zoom = 1.0F;
    float zoomXOffset = 0, zoomYOffset = 0;
    Stack<Float> zoomStack = new Stack<>();

    Camera() {
        this.x = 0;
        this.y = 0;
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

    // the main camera function; called during App.draw()
    public void apply() {
        applyXY();
        scale(zoom);
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
