/*
*  the main file where the program is run from
*/

import java.util.HashMap;
import java.util.Collections;
import java.io.File;

enum GameState {
  STARTPAGE,
  GAME,
  POPMENU, 
  SHOP,
  GAMEOVER,
}

enum Settings {
    VSCOMPUTER,
    VSHUMAN,
    EASY,
    HARD,
}

enum PlayerNum {
    ONE,
    TWO,
}

static final String ASSETS_PATH = "../../game-assets/".replace("/", File.separator);
static final int SPACE=32, R=82, W=87, S=83;

GameState gameState = GameState.STARTPAGE;
HashMap<String, Settings> gameSettings = new HashMap<>();

HashMap<String, PImage> imgs = new HashMap<>();
HashMap<Integer, Boolean> keys = new HashMap<>();

Camera camera;
StartMenu startMenu;
ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Arrow> spentArrows = new ArrayList<>();
Player[] players = new Player[2];
Player activePlayer;
GameOverPage gameOverPage;

int planetRadius = 1000;
int minDistanceBetweenPlanets = 300;
int maxDistanceBetweenPlanets = 800;


public void settings() {
    size(1280, 720);
    // Anti aliasing
    smooth(8);
}



// Use this method for loading images (stored in the `game-assets` folder)
public void loadAssets() {
    imgs.put("arrow", loadImage(ASSETS_PATH+"arrow.png"));

}


public void setup()
{
    loadAssets();

    keys.put(UP, false);
    keys.put(DOWN, false);
    keys.put(LEFT, false);
    keys.put(RIGHT, false);
    keys.put(SPACE, false);
    keys.put(R, false);
    keys.put(W, false);
    keys.put(S, false);

    camera = new Camera();

    //fixed positions
    planets.add(new Planet(100, height-100, 1000));
    planets.add(new Planet(500, 100, planetRadius));
    randomisePlanetLocations();


    //generate random locations of planets
    // for(Planet p : planets){
    //     generateRandomLocations(p);
    // }

    

    Collections.sort(planets, (p1, p2) -> Float.compare(p1.getX(), p2.getX()));

    //set the left and right planet
    // Planet leftPlanet, rightPlanet;
    // if(planets.get(0).x < planets.get(1).x){
    //     leftPlanet = planets.get(0);
    //     rightPlanet = planets.get(1);
    // } else {
    //     leftPlanet = planets.get(1);
    //     rightPlanet = planets.get(0);
    // }


    startMenu = new StartMenu();
    
    players[0] = new Player(planets.get(0), 270, PlayerNum.ONE);
    players[1] = new Player(planets.get(1), 250, PlayerNum.TWO);
    activePlayer = players[0];
    
    gameOverPage = new GameOverPage();

}


public void draw()
{    
    background(0);

    switch (gameState) {
        case STARTPAGE:
            startMenu.draw();
            return;
        case GAME:
            break;
        case GAMEOVER:
            gameOverPage.draw();
            return;
    }
    camera.apply();

    for (Arrow a : spentArrows) {
        a.draw();
    }
    for (Planet p : planets) {
        p.draw();
    }
    for (Player p: players) {
        p.draw();
    }
    
   

    // debugging code which removes health when pressing R
    // if (keys.get(R) == true) {
    //   activePlayer.removeHeart();
    // }
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


public Player checkForPlayerDeaths() {
    for (Player p: players) {
        if (p.getHealth() <= 0) {
            return p;
        } 
    }
    return null;
}


public boolean updatePlayerHealths() {
    for (Player p: players) {
        if (activePlayer.getArrow().isCollidingWith(p)) {
            p.removeHeart();
            return true;
        }
    }
    return false;
}

public void finishPlayerTurn()
{
    int frameWait = updatePlayerHealths() ? 120 : 60;

    spentArrows.add(new Arrow(activePlayer.getArrow()));

    Player deadPlayer = checkForPlayerDeaths();
    if (deadPlayer != null) {
        setWinnerAndGameOver(getOtherPlayer(deadPlayer));
   
        return;
    }

    activePlayer.getArrow().cannotBeCollidedWith = true;

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
    gameState = GameState.GAMEOVER;
    gameOverPage.setWinner(p.getPlayerNum() == PlayerNum.ONE ? "1" : "2");
    
    camera.animateCenterOnObject(p, 60);
    println("PLAYER" + (p.getPlayerNum() == PlayerNum.ONE ? "1 " : "2 ") +"WINS!");
}



//random locations of planets
public void randomisePlanetLocations() {
    boolean areSuitableLocations = false;

    while (!areSuitableLocations) {
        // generate random positions
        for (Planet p: planets) {
            p.setX(random(width));
            p.setY(random(height));
        }
        // Test whether this position will be duplicated by other planets' positions
        for (Planet p: planets) {
            Planet nextPlanet = planets.get((planets.indexOf(p)+1) % planets.size());

            float distance = sqrt( 
                    (p.getX() - nextPlanet.getX()) * (p.getX() - nextPlanet.getX()) +
                    (p.getY() -nextPlanet.getY()) * (p.getY() - nextPlanet.getY()));

            if( distance <= (p.getRadius() + nextPlanet.getRadius() + minDistanceBetweenPlanets) ||
                distance > (p.getRadius() + nextPlanet.getRadius() + maxDistanceBetweenPlanets)) {
                areSuitableLocations = true;
                break;
            }
        }
    }


    // while(true) {
    //      boolean isSuitableLocation = true;
         
    //      float x = (float)(Math.random()*width);
    //      float y = (float)(Math.random()*height);
         
    //      for(Planet p : planets){
    //          float distance = (float)Math.sqrt((p.x - x) * (p.x - x) + (p.y -y) * (p.y - y));
    //          if(distance <= (p.r + planet.r + minDistanceBetweenPlanets) || distance > (p.r + planet.r + maxDistanceBetweenPlanets)){
    //              isSuitableLocation = false;
    //              break;
    //          }
    //      }
    //      if(isSuitableLocation){
    //          planet.x = x;
    //          planet.y = y;
    //          break;
    //      }
    // }
}
