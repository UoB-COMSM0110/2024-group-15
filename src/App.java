/*
*  the main class where the program is run from
*/

import processing.core.*;

import java.util.ArrayList;
import java.util.HashMap;

public class App extends PApplet {
    int screenWidth = 700;
    int screenHeight = 500;

    HashMap<String, PImage> imgs = new HashMap<>();

    static final int SPACE=32, R=82, W=87, S=83;
    HashMap<Integer, Boolean> keys = new HashMap<>();

    Camera camera;
    ArrayList<Planet> planets = new ArrayList<>();
    ArrayList<Player> players = new ArrayList<>();
    Player activePlayer;


    public void settings() {
        size(screenWidth, screenHeight);
        // Anti aliasing
        smooth(8);
    }

    public void setup()
    {
        keys.put(UP, false);
        keys.put(DOWN, false);
        keys.put(LEFT, false);
        keys.put(RIGHT, false);

        keys.put(SPACE, false);
        keys.put(R, false);
        keys.put(W, false);
        keys.put(S, false);


        camera = new Camera(this);
//        camera.updateZoom(0.5F);

        imgs.put("arrow", loadImage("game-assets/arrow.png"));

        planets.add(new Planet(this, 100, screenHeight-100, 1000));
        planets.add(new Planet(this, 500, 100, 1000));
//        planets.add(new Planet(this, 300, 50, 10000, 20));

        players.add(new Player(planets.get(0), 270));
        players.add(new Player(planets.get(1), 250));
        activePlayer = players.get(0);

    }

    public void draw()
    {
        camera.keyMove();  // for debug moving/zooming the camera
        camera.apply();

        background(0);
        for (Planet p : planets) {
            p.draw();
        }
        for (Player p : players) {
            p.draw();
        }
    }

    // Key press handling
    public void keyPressed()
    {
        if (keys.containsKey(keyCode)) keys.put(keyCode, true);
    }
    public void keyReleased()
    {
        if (keys.containsKey(keyCode)) keys.put(keyCode, false);
    }

    // Boilerplate processing
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "App" };
        if (passedArgs != null) {
            PApplet.main(concat(appletArgs, passedArgs));
        } else {
            PApplet.main(appletArgs);
        }
    }
}
