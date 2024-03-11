/*
*  the main file where the program is run from
*/


final String ASSETS_PATH = "../../game-assets/";

int screenWidth = 1280;
int screenHeight = 720;
int gameState = 0;

HashMap<String, PImage> imgs = new HashMap<>();

static final int SPACE=32, R=82, W=87, S=83;
HashMap<Integer, Boolean> keys = new HashMap<>();

Camera camera;
ArrayList<Planet> planets = new ArrayList<>();

Player p1, p2, activePlayer;


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


    camera = new Camera();
//        camera.updateZoom(0.5F);

    imgs.put("arrow", loadImage(ASSETS_PATH+"arrow.png"));

    planets.add(new Planet(100, screenHeight-100, 1000));
    planets.add(new Planet(500, 100, 1000));
//        planets.add(new Planet(this, 300, 50, 10000, 20));

    p1 = new Player(planets.get(0), 270, HeathBarPosition.LEFT);
    p2 = new Player(planets.get(1), 250, HeathBarPosition.RIGHT);
    activePlayer = p1;
}

public void draw()
{    
    background(0);

    if(gameState == 0){
      InitialInterface deIt = new InitialInterface();
      deIt.draw();
    } else {
      camera.apply();

      for (Planet p : planets) {
          p.draw();
      }

      p1.draw();
      p2.draw();
    }
    //a simple and shit control of gameState
    if(mousePressed && mouseX >= 800 && mouseY >= 400 && mouseY <= 528 && mouseX <= 928){
      gameState = 1;
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

public void finishPlayerTurn()
{
    Player oldActivePlayer = activePlayer;
    activePlayer = activePlayer == p1 ? p2 : p1;

    if (oldActivePlayer.getArrow().isCollidingWith(oldActivePlayer)) {
        oldActivePlayer.setHealth(oldActivePlayer.getHealth()-1);
    }

    camera.animateCenterOnObject(activePlayer, 60);
}
