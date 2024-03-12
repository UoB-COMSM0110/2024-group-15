/*
*  the main file where the program is run from
*/


final String ASSETS_PATH = "../../game-assets/";

int screenWidth = 1280;
int screenHeight = 720;
int gameState = 0;
int planetRadius = 1000;
int minDistanceBetweenPlanets = 200;
int maxDistanceBetweenPlanets = 500;

HashMap<String, PImage> imgs = new HashMap<>();

static final int SPACE=32, R=82, W=87, S=83;
HashMap<Integer, Boolean> keys = new HashMap<>();

Camera camera;
ArrayList<Planet> planets = new ArrayList<>();

Player activePlayer;
Player[] players = new Player[2];

ArrayList<Arrow> spentArrows = new ArrayList<>();


public enum PlayerNum {
    ONE,
    TWO,
}


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

    //fixed positions
    planets.add(new Planet(100, screenHeight-100, 1000));
    planets.add(new Planet(500, 100, planetRadius));
//        planets.add(new Planet(this, 300, 50, 10000, 20));
    
    //generate random locations of planets
    for(Planet p : planets){
        generateRandomLocations(p);
    }
    

    players[0] = new Player(planets.get(0), 270, PlayerNum.ONE);
    players[1] = new Player(planets.get(1), 250, PlayerNum.TWO);
    activePlayer = players[0];

}

public void draw()
{    
    background(0);

    if(gameState == 0){
      InitialInterface deIt = new InitialInterface();
      deIt.draw();
      //a simple and shit control of gameState
      //if(mousePressed && mouseX >= 800 && mouseY >= 400 && mouseY <= 528 && mouseX <= 928){
      //  gameState = 1;
      //}
      if(keyPressed){
        gameState = 1;
      }
    } else {
      camera.apply();

      // debugging code which removes health when pressing R
      // if (keys.get(R) == true) {
      //   activePlayer.removeHeart();
      // }

      for (Arrow a : spentArrows) {
        a.draw();
      }
      for (Planet p : planets) {
          p.draw();
      }
      for (Player p: players) {
        p.draw();
      }
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


private Player getOtherPlayer(Player p) {
    switch (p.getPlayerNum()) {
        case ONE: 
            return players[1];
        case TWO: 
            return players[0];
        default:
            return null;
    }
}


public void checkForPlayerDeath(Player p) {
    if (p.getHealth() <= 0) {
        setWinnerAndGameOver(getOtherPlayer(p));
    } 
}


public boolean updatePlayerHealths() {
    for (Player p: players) {
        if (activePlayer.getArrow().isCollidingWith(p)) {
            p.removeHeart();
            checkForPlayerDeath(p);
            return true;
        }
    }
    return false;
}

public void finishPlayerTurn()
{
    int frameWait = updatePlayerHealths() ? 120 : 60;

    spentArrows.add(new Arrow(activePlayer.getArrow()));

    activePlayer = getOtherPlayer(activePlayer);
    camera.animateCenterOnObject(activePlayer, frameWait);
}


public void setWinnerAndGameOver(Player p)
{
    /** TODO
     *      New game state
     *      Show winner screen (PLAYER X WINS!)
     *      Play again button? exit button? etc.
    */
    println("PLAYER" + (p.getPlayerNum() == PlayerNum.ONE ? "1 " : "2 ") +"WINS!");
}




//random locations of planets
public void generateRandomLocations(Planet planet){
    while(true) {
         boolean isSuitableLocation = true;
         //generate random positions
         float x = (float)(Math.random()*screenWidth);
         float y = (float)(Math.random()*screenHeight);
         // Test whether this position will be duplicated by other planets' positions
         for(Planet p : planets){
             float distance = (float)Math.sqrt((p.x - x) * (p.x - x) + (p.y -y) * (p.y - y));
             if(distance <= (p.r + planet.r + minDistanceBetweenPlanets) || distance > (p.r + planet.r + maxDistanceBetweenPlanets)){
                 isSuitableLocation = false;
                 break;
             }
         }
         if(isSuitableLocation){
             planet.x = x;
             planet.y = y;
             break;
         }
    }
}
