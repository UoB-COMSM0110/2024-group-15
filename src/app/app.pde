/*
*  the main file where the program is run from
*/

import java.util.HashMap;
import java.util.Collections;
import java.util.List;
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

int screenWidth = 1024;
int screenHeight = 767;


PImage backgroundImage, transparentStars;


HashMap<String, PImage> imgs = new HashMap<>();
HashMap<Integer, Boolean> keys = new HashMap<>();

Camera camera;
StartMenu startMenu;
ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Arrow> spentArrows = new ArrayList<>();
Player[] players = new Player[2];
Player activePlayer;

private int minDistanceBetweenPlanets;
private int maxXDistanceBetweenPlanets;
private int maxYDistanceBetweenPlanets;

Shop shop;


private int planetRadius = 1000;

int maxHealth = 3;


public void settings() {
    size(screenWidth, screenHeight);
    // Anti aliasing
    smooth(8);
}


void loadIntoImages(String fileName) {
    imgs.put(fileName, loadImage(ASSETS_PATH+fileName+".png"));
}

// Use this method for loading images (stored in the `game-assets` folder)
public void loadAssets() {
    loadIntoImages("arrow");
    loadIntoImages("planet1");
    loadIntoImages("planet2");
    loadIntoImages("player-idle");
    loadIntoImages("player-draw");
    loadIntoImages("player-hit");
    loadIntoImages("space1");
    loadIntoImages("transparent-stars");
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
    startMenu = new StartMenu();
    shop = new Shop();
}

public void gameInit() {
    
    
    if (gameSettings.get("difficulty") == Settings.EASY) {
        minDistanceBetweenPlanets = 200;
        maxXDistanceBetweenPlanets = 600;
        maxYDistanceBetweenPlanets = 300;
    }
    else {
        minDistanceBetweenPlanets = 400;
        maxXDistanceBetweenPlanets = 900;
        maxYDistanceBetweenPlanets = 500;
    }
   
    planets.add(new Planet(0, 0, planetRadius, imgs.get("planet1")));
    planets.add(new Planet(0, 0, planetRadius, imgs.get("planet2")));

    randomisePlanetLocations();

    Collections.sort(planets, (p1, p2) -> Float.compare(p1.getX(), p2.getX()));

    players[0] = new Player(planets.get(0), 270, PlayerNum.ONE);
    players[1] = new Player(planets.get(1), 250, PlayerNum.TWO);
    activePlayer = players[0];

    gameState = GameState.GAME;
}


public void draw()
{    
    background(0);      // background 0 makes text a bit sharper
    imageMode(CENTER);

    float backgroundImageX = width/2 - (camera.getX()*0.3);
    float backgroundImageY = height/2 - (camera.getY()*0.3);
    image(imgs.get("space1"), backgroundImageX, backgroundImageY);

    image(imgs.get("space1"), backgroundImageX-width, backgroundImageY);
    image(imgs.get("space1"), backgroundImageX-width, backgroundImageY-height);
    image(imgs.get("space1"), backgroundImageX, backgroundImageY-height);
    image(imgs.get("space1"), backgroundImageX+width, backgroundImageY-height);
    image(imgs.get("space1"), backgroundImageX+width, backgroundImageY);
    image(imgs.get("space1"), backgroundImageX+width, backgroundImageY+height);
    image(imgs.get("space1"), backgroundImageX, backgroundImageY+height);
    image(imgs.get("space1"), backgroundImageX-width, backgroundImageY+height);


    image(imgs.get("transparent-stars"), backgroundImageX*1.1, backgroundImageY*1.1, width*2, height*2);
    image(imgs.get("transparent-stars"), backgroundImageX*1.2, backgroundImageY*1.2, width*3, height*3);

    switch (gameState) {
        case STARTPAGE:
            startMenu.draw();
            return;
    }

    if (keys.get(R)) {
        camera.setZoom(camera.zoom + 0.1);
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

    shop.draw();

    // debugging code which removes health when pressing R
    // if (frameCount % (60*3) == 0) {
      // activePlayer.removeHeart();
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
        for (Planet p: planets) {
            Planet nextPlanet = planets.get((planets.indexOf(p)+1) % planets.size());

            float dx = abs(p.getX()-nextPlanet.getX());
            float dy = abs(p.getY()-nextPlanet.getY());
            if (dx > maxXDistanceBetweenPlanets || dy > maxYDistanceBetweenPlanets) {
                break;
            }
            float distance = sqrt((dx*dx)+(dy*dy));
            if (distance <= (p.getRadius() + nextPlanet.getRadius() + minDistanceBetweenPlanets)) {
                break;
            }
            areSuitableLocations = true;
        }
    }
}
