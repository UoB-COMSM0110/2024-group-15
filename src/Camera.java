/*
* This class simulates a camera by scaling all drawings based on x, y and zoom
*/

import java.util.Stack;

public class Camera {
    App app;
    float x, y;
    float zoom = 1.0F;
    float zoomXOffset = 0, zoomYOffset = 0;
    Stack<Float> zoomStack = new Stack<>();

    Camera(App app) {
        this.app = app;
        this.x = 0;
        this.y = 0;
    }

    public void updateXY(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public void updateZoom(float zoom) {
        this.zoom = zoom;
        zoomXOffset = (1-zoom)*(app.width/2F);
        zoomYOffset = (1-zoom)*(app.height/2F);
    }

    public void keyMove() {
        if (app.keys.get(app.LEFT)) {
            updateXY(x-2, y);
        }
        else if (app.keys.get(app.RIGHT)) {
            updateXY(x+2, y);
        }
        else if (app.keys.get(app.UP)) {
            updateXY(x, y-2);
        }
        else if (app.keys.get(app.DOWN)) {
            updateXY(x, y+2);
        }
        else if (app.keys.get(app.W)) {
            updateZoom(zoom+0.01F);
        }
        else if (app.keys.get(app.S)) {
            updateZoom(zoom-0.01F);
        }
    }

    // the main camera function; called during App.draw()
    public void apply() {
        applyXY();
        app.scale(zoom);
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
        app.translate(-x+zoomXOffset, -y+zoomYOffset);
    }
}
