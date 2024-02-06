
import processing.core.*;

import java.util.ArrayList;
import java.util.HashMap;

public class App extends PApplet {
    int screenWidth = 700;
    int screenHeight = 500;

    // stores which keys are currently pressed
    static final int SPACE = 32, R = 82;
    HashMap<Integer, Boolean> keys = new HashMap<>();

    ArrayList<Planet> planets = new ArrayList<>();

    Object square;

    Aimer aim;

    public void settings() { size(screenWidth, screenHeight); }

    public void setup()
    {
        keys.put(UP, false);
        keys.put(DOWN, false);
        keys.put(LEFT, false);
        keys.put(RIGHT, false);

        keys.put(SPACE, false);
        keys.put(R, false);

        square = new Object(this, 80, 400, new PVector(0, 0));
        planets.add(new Planet(this, 50, screenHeight-100, 1000));
        planets.add(new Planet(this, 500, 200, 1000));
        aim = new Aimer(this, square);
    }

    public void draw()
    {

        if (aim.fired) {
            square.move();
        }

        if (keys.get(R)) {
            square.loc.x = 80;
            square.loc.y = 400;
            aim.fired = false;
        }

        background(0);
        for (Planet p : planets) {
            p.draw();
        }
        square.draw();

        aim.update();

    }

    public void keyPressed()
    {
        k(true);
    }
    public void keyReleased()
    {
        k(false);
    }

    public void k(boolean b)
    {
        if (keys.containsKey(keyCode)) {
            keys.put(keyCode, b);
        }
    }


    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "App" };
        if (passedArgs != null) {
            PApplet.main(concat(appletArgs, passedArgs));
        } else {
            PApplet.main(appletArgs);
        }
    }
}
