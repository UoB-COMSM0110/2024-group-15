import processing.core.PVector;

public class Aimer {

    App app;
    Object obj;

    boolean aiming = false, fired = false;
    PVector initialLoc = new PVector();

    Aimer(App app, Object obj) {
        this.app = app;
        this.obj = obj;
    }

    void update() {
        if (!app.mousePressed) {
            if (aiming) {
                fired = true;
                aiming = false;
                obj.velocity = new PVector(initialLoc.x-app.mouseX, initialLoc.y-app.mouseY);
                obj.velocity.mult(0.1F);
            }
            return;
        }
        if (!aiming) {
            initialLoc.x = app.mouseX;
            initialLoc.y = app.mouseY;
            fired = false;
            aiming = true;
        }


        app.pushStyle();
        app.stroke(255, 255, 255);
        app.line(initialLoc.x, initialLoc.y, app.mouseX, app.mouseY);
        app.popStyle();
    }
}
