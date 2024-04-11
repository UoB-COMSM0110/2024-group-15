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

static final int screenWidth = 1024;
static final int screenHeight = 767;

static final String ASSETS_PATH = "../../game-assets/".replace("/", File.separator);
static final int SPACE=32, R=82, W=87, S=83;

GameState gameState = GameState.STARTPAGE;
HashMap<String, Settings> gameSettings = new HashMap<>();
HashMap<String, PImage> imgs = new HashMap<>();
HashMap<Integer, Boolean> keys = new HashMap<>();

Camera camera;
StartMenu startMenu;
Tutorial tutorial;
ArrayList<Planet> planets = new ArrayList<>();
ArrayList<Arrow> spentArrows = new ArrayList<>();
Player[] players = new Player[2];
Player activePlayer;
GameOverPage gameOverPage;

private int minDistanceBetweenPlanets;
private int maxXDistanceBetweenPlanets;
private int maxYDistanceBetweenPlanets;

PImage spaceBG, spaceTransparentBG;

int shopX, shopY, shopWidth, shopHeight;
Shop shop;

PointsSplash pointsSplash;


private int planetRadius = 1000;

int maxHealth = 3;


PShape HEART_SHAPE;

// The exact number is not final
//int arrowCount = 10;
// For debugging purpose
int arrowCount = 2;

public void settings() {
    size(screenWidth, screenHeight);    // P2D seems to be too slow
    smooth(8);                          // Anti aliasing
}

void loadIntoImages(String fileName) {
    loadIntoImages(fileName, "png");
}

void loadIntoImages(String fileName, String fileExtension) {
    imgs.put(fileName, requestImage(ASSETS_PATH+fileName+"."+fileExtension));
}

void hardLoadIntoImages(String fileName) {
    imgs.put(fileName, loadImage(ASSETS_PATH+fileName+".png"));
}

// Use this method for loading images (stored in the `game-assets` folder)
public void loadAssets() {
    hardLoadIntoImages("space-tiled");
    hardLoadIntoImages("transparent-stars");
    loadIntoImages("arrow");
    loadIntoImages("planet1");
    loadIntoImages("planet2");
    loadIntoImages("player-idle");
    loadIntoImages("player-draw");
    loadIntoImages("player-hit");
    loadIntoImages("planet3", "gif");
    loadIntoImages("bow-export");
    loadIntoImages("manLEFT");
    loadIntoImages("manRIGHT");

    spaceBG = imgs.get("space-tiled");
    spaceTransparentBG = imgs.get("transparent-stars");
}


public void setup()
{
    frameRate(60);
    loadAssets();

    keys.put(UP, false);
    keys.put(DOWN, false);
    keys.put(LEFT, false);
    keys.put(RIGHT, false);
    keys.put(SPACE, false);
    keys.put(R, false);
    keys.put(W, false);
    keys.put(S, false);

    HEART_SHAPE = createShape();
    HEART_SHAPE.beginShape();
    HEART_SHAPE.noStroke();
    float a = 0.5;
    float t = 0;
    while (t < TWO_PI) {
        float xCoord = (16 * pow(sin(t), 3)) * a;
        float yCoord = (13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t)) * a;
        HEART_SHAPE.vertex(xCoord, -yCoord);
        t += 0.01;
    }
    HEART_SHAPE.endShape(CLOSE);

    camera = new Camera();
    startMenu = new StartMenu();

    shopWidth = 400;
    shopHeight = 80;
    shopX = width/2-shopWidth;
    shopY = height/2-shopHeight;
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

    camera.setXY((planets.get(0).x+planets.get(1).x)/2, (planets.get(0).y+planets.get(1).y)/2);

    Collections.sort(planets, (p1, p2) -> Float.compare(p1.getX(), p2.getX()));

    players[0] = new Player(planets.get(0), 270, PlayerNum.ONE);
    players[1] = new Player(planets.get(1), 250, PlayerNum.TWO);
    activePlayer = players[0];

    gameState = GameState.GAME;
    gameOverPage = new GameOverPage();
    tutorial = new Tutorial();
    pointsSplash = new PointsSplash();
}

float backgroundImageX, backgroundImageY;
float stars1X, stars1Y;
float stars2X, stars2Y;
int prevCamX, prevCamY;
public void drawBackground() {
    int camX = (int)camera.getX();
    int camY = (int)camera.getY();
    if (prevCamX != camX || prevCamY != camY) {
        backgroundImageX = width/2 - (camera.getX()*0.3);
        backgroundImageY = height/2 - (camera.getY()*0.3);
        stars1X = backgroundImageX*1.1;
        stars1Y = backgroundImageY*1.1;
        stars2X = backgroundImageX*1.2;
        stars2Y = backgroundImageY*1.2;
        prevCamX = camX;
        prevCamY = camY;
    }

    image(spaceBG, backgroundImageX, backgroundImageY);
    image(spaceTransparentBG, stars1X, stars1Y, width*2, height*2);
    image(spaceTransparentBG, stars2X, stars2Y, width*3, height*3);
}


public void draw()
{
    background(0);      // background 0 makes text a bit sharper
    imageMode(CENTER);
    drawBackground();

    switch (gameState) {
        case STARTPAGE:
            startMenu.draw();
            return;
    }

    if (keys.get(R)) {
        camera.setZoom(camera.zoom + 0.1);
// =======
//         case GAME:

//             //Shop
//             for (Planet p : planets) {
//                 if (p.getNumberOfArrowsOnMe() >= arrowCount) {
//                     for (Player player : players) {
//                         if (player.planet.equals(p)
//                             && !player.equals(activePlayer)
//                             // Assuming each player can use this mode once for the time being
//                             && !player.hasUsedShop()) {
//                             gameState = GameState.SHOP;
//                             player.markAsUsedShop();
//                             break;
//                         }
//                     }
//                 }
//                 if (gameState == GameState.SHOP) {
//                     break;
//                 }
//             }
//             break;
//         case EASYGAMESET:
//             //camera.setZoom(0.65F);//zoom out
//             gameState = GameState.EASYGAME;
//             return;
//         case EASYGAME:
//             isPathFinderActive = true; //easy game with a default pathFinder
//             break;
//         case GAMEOVER:
//             gameOverPage.draw();
//             return;
//         case SHOP:
//             shopPage.draw();
//             return;
// >>>>>>> main
    }

    camera.apply();

    for (Arrow a : spentArrows) {
        a.draw();
    }
    for (Planet p : planets) {
        p.draw();
    }

    for (Player p: players) {
        if (!shop.isOpen()) {
            p.move();
        } else p.arrow.isMoving = false;

        p.draw();
    }

    pointsSplash.draw();


    shop.draw();

    tutorial.draw();        //The help message during gameplay

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


// public boolean updatePlayerHealths() {
//     for (Player p: players) {
//         if (activePlayer.getArrow().isCollidingWith(p)) {
//             p.removeHeart();
//             return true;
//         }
//     }
//     return false;
// }

public boolean updatePlayerHealths() {
    boolean playerHit = false;

    for (Player p : players) {
        if (activePlayer.getArrow().isCollidingWith(p)) {
            p.removeHeart();
            // TODO!!!
            // if (isDoubleStrikeActive) {
            //     p.removeHeart();
            //     isDoubleStrikeActive = false;
            // }
            playerHit = true;

            // if the player hits themself, they lose the amount they gained
            int pointsToAdd = p == activePlayer ? -activePlayer.roundPoints : activePlayer.roundPoints;
            activePlayer.updatePoints(activePlayer.points+pointsToAdd);
            break;
        }
    }
    return playerHit;
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
    activePlayer.items.clear();

    activePlayer.roundPoints = 0;

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
