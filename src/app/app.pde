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


    camera = new Camera();
//        camera.updateZoom(0.5F);

    imgs.put("arrow", loadImage(ASSETS_PATH+"arrow.png"));
    
    //add planets in random locations inside the screen
    int planetsLocationX = (int)(Math.random() * screenWidth);
    int planetsLocationY = (int)(Math.random() * screenHeight);
    //planets.add(new Planet(100, screenHeight-100, 1000));
    planets.add(new Planet(planetsLocationX, planetsLocationY, 1000));
    planets.add(new Planet(500, 100, 1000));
//        planets.add(new Planet(this, 300, 50, 10000, 20));

    players.add(new Player(planets.get(0), 270));
    players.add(new Player(planets.get(1), 250));
    activePlayer = players.get(0);
    
    
}

public void draw()
{    
    if(gameState == 0){
      InitialInterface deIt = new InitialInterface();
      deIt.draw();
    } else {
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

//random locations of planets
