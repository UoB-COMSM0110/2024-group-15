/*
*  the main file where the program is run from
*/

import java.util.HashMap;
import java.util.Collections;
import java.util.List;
import java.io.File;
import java.util.HashSet;
import java.util.Set;

enum GameState {
  STARTPAGE,
  GAME,
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

static final private int planetRadius = 1000;
private int minDistanceBetweenPlanets;
private int maxXDistanceBetweenPlanets;
private int maxYDistanceBetweenPlanets;
float planetCenterX;
float planetCenterY;
static final int maxHealth = 3;
String player1Name = "";
String player2Name = "";

GameState gameState = GameState.STARTPAGE;
boolean tutorialActive;
HashMap<String, Settings> gameSettings = new HashMap<>();
HashMap<String, PImage> imgs = new HashMap<>();
HashMap<Integer, Boolean> keys = new HashMap<>();
static final Set<Button> activeButtons = new HashSet<>();

PGraphics pg0;
PShape HEART_SHAPE;
PFont SFPro; // TODO put the other ones here as well

Camera camera;
StartMenu startMenu;
Shop shop;
Tutorial tutorial;
PointsSplash pointsSplash;
ArrayList<Planet> planets;
ArrayList<Arrow> spentArrows;
Player[] players = new Player[2];
Player activePlayer;
Player winningPlayer;
GameOverPage gameOverPage;
PlayerMover playerMover;
GameMenu gameMenu;
OptionsMenu optionsMenu;

int shopX, shopY, shopWidth, shopHeight;    // TODO idk about this



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

    SFPro = createFont(ASSETS_PATH+"Pixellari.ttf", 24);
}


public void setup()
{
    frameRate(60);
    loadAssets();

    pg0 = createGraphics(
        width,
        height
    );

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
    tutorial = new Tutorial();
    optionsMenu = new OptionsMenu();

    shopWidth = 600;
    shopHeight = 400;
    shopX = 200;
    shopY = 250;
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
    resetMatrix();
    planets = new ArrayList<>();
    spentArrows = new ArrayList<>();

    planets.add(new Planet(0, 0, planetRadius, imgs.get("planet1")));
    planets.add(new Planet(0, 0, planetRadius, imgs.get("planet2")));

    randomisePlanetLocations();

    planetCenterX = (planets.get(0).x+planets.get(1).x)/2;
    planetCenterY = (planets.get(0).y+planets.get(1).y)/2;

    camera.setXY(planetCenterX, planetCenterY);


    Collections.sort(planets, (p1, p2) -> Float.compare(p1.getX(), p2.getX()));

    players[0] = new Player(planets.get(0), -90, PlayerNum.ONE);
    players[1] = new Player(planets.get(1), -90, PlayerNum.TWO);

    camera.animateCenterOnObject(players[0], 120);

    activePlayer = players[0];

    gameState = GameState.GAME;
    gameOverPage = new GameOverPage();

    pointsSplash = new PointsSplash();

    playerMover = new PlayerMover();
    gameMenu = new GameMenu();
    if (!tutorialActive) gameMenu.open();


    // players[0].points = 10000;
    // players[1].points = 10000;


    if (tutorialActive) {
        players[0].updatePoints(150);
    }
}

float backgroundImageX, backgroundImageY;
float stars1X, stars1Y;
float stars2X, stars2Y;
float prevCamX, prevCamY;

boolean haveCachedRecently = false;
boolean cacheNextDraw = true;
public void drawBackground() {
    float camX = camera.getX();
    float camY = camera.getY();
    if (cacheNextDraw) {
        pg0.beginDraw();
        pg0.imageMode(CENTER);
        pg0.image(imgs.get("space-tiled"), backgroundImageX, backgroundImageY);
        pg0.image(imgs.get("transparent-stars"), stars1X, stars1Y, width*2, height*2);
        pg0.image(imgs.get("transparent-stars"), stars2X, stars2Y, width*3, height*3);
        pg0.endDraw();
        haveCachedRecently = true;
        cacheNextDraw = false;
    }
    if (prevCamX == camX && prevCamY == camY) {
        if (haveCachedRecently) {
            image(pg0, width/2, height/2);
            return;
        }
        cacheNextDraw = true;
    }
    haveCachedRecently = false;
    backgroundImageX = width/2 - (camera.getX()*0.3);
    backgroundImageY = height/2 - (camera.getY()*0.3);
    stars1X = backgroundImageX*1.1;
    stars1Y = backgroundImageY*1.1;
    stars2X = backgroundImageX*1.2;
    stars2Y = backgroundImageY*1.2;
    image(imgs.get("space-tiled"), backgroundImageX, backgroundImageY);
    image(imgs.get("transparent-stars"), stars1X, stars1Y, width*2, height*2);
    image(imgs.get("transparent-stars"), stars2X, stars2Y, width*3, height*3);
    prevCamX = camX;
    prevCamY = camY;

}


public void draw()
{
    background(0);      // background 0 makes text a bit sharper
    imageMode(CENTER);
    drawBackground();

    if (gameState == GameState.STARTPAGE) {
        startMenu.draw();
        return;
    }

    camera.apply();

     if (gameState == GameState.GAMEOVER && camera.cameraEffectivelyAtTarget(100)) {
        pushStyle();
        fill(255);
        textFont(SFPro);
        String content = winningPlayer.playerNum == PlayerNum.ONE ? player1Name : player2Name;
        if (content.length() == 0) {
            content += "YOU WIN";
        }
        else {
            content += " WINS";
        }
        if (!optionsMenu.isOpen) optionsMenu.open(winningPlayer);

        text(content, winningPlayer.x-(textWidth(content)/2), winningPlayer.y-220);
        popStyle();
    }

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

    tutorial.draw();        // The help message during gameplay

    playerMover.draw();

    gameMenu.draw();
    optionsMenu.draw();
}

// Key press handling
public void keyPressed() {
    if (gameState == GameState.STARTPAGE) {
        if (keyCode == 9) {
            if (startMenu.p1Text.inFocus()) {
                startMenu.p1Text.inFocus = false;
                startMenu.p2Text.inFocus = true;
            }
            else if (startMenu.p2Text.inFocus()) {
                startMenu.p2Text.inFocus = false;
                startMenu.p1Text.inFocus = true;
            }
            else {
                startMenu.p1Text.inFocus = true;
            }
        }
        if (startMenu.p1Text.inFocus() || startMenu.p2Text.inFocus()) {
            TextBox tb = startMenu.p1Text.inFocus() ? startMenu.p1Text : startMenu.p2Text;
            tb.handleKey();
        }
    }
    else if (key == 'c' && activePlayer != null && activePlayer.aimer.aiming) {
        activePlayer.aimer.aiming = false;
        activePlayer.setSprite(PlayerStatus.IDLE);
        if (tutorialActive && tutorial.currentMessage == 1) tutorial.currentMessage = 0;
        else gameMenu.open();
    }

    if (keys.containsKey(keyCode)) keys.put(keyCode, true);

}
public void keyReleased() {

    if (keys.containsKey(keyCode)) keys.put(keyCode, false);
}


void mousePressed() {
    if (handleButtonClick()) return;
    if (gameState != GameState.GAME) return;
    if (playerMover.handleClick()) return;
    activePlayer.getAimer().handleMouseDown();

    if (tutorialActive) tutorial.handleClick();
}
void mouseReleased() {
    if (handleButtonClick()) return;
    if (gameState != GameState.GAME) return;
    activePlayer.getAimer().handleMouseUp();

     if (tutorialActive) tutorial.handleClick();
}

void mouseDragged() {
    if (gameState != GameState.GAME) return;
    activePlayer.getAimer().handleMouseMove();
}

boolean handleButtonClick() {
    for (Button b: activeButtons) {
        if (b instanceof TextBox) {
            b.handleClick();
        }
        else if (b.mouseHovering()) {
            b.handleClick();
            return true;
        }
    }
    return false;
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
    boolean playerHit = false;

    for (Player p : players) {
        if (p.isCollidingWith(activePlayer.getArrow())) {
            p.removeHeart();
            if (activePlayer.items.contains(PlayerItem.DOUBLESTRIKE)) {
                p.removeHeart();
            }
            playerHit = true;

            // if the player hits themself, they lose the amount they gained
            boolean hitThemself = p == activePlayer;

            if (activePlayer.playerNum == PlayerNum.ONE) pointsSplash.animateLeft = true;
            else pointsSplash.animateRight = true;
            pointsSplash.c = hitThemself ? color(255, 80, 90) : color(80, 255, 90);

            int pointsToAdd = p == activePlayer ? -activePlayer.roundPoints : activePlayer.roundPoints;
            activePlayer.updatePoints(activePlayer.points+pointsToAdd);
            break;
        }
    }
    if (!playerHit) pointsSplash.animateDown = true;
    return playerHit;
}

public void finishPlayerTurn()
{
    int frameWait = updatePlayerHealths() ? 120 : 60;
    spentArrows.add(new Arrow(activePlayer.getArrow()));
    activePlayer.getArrow().isMoving = false;

    Player deadPlayer = checkForPlayerDeaths();
    if (deadPlayer != null) {
        setWinnerAndGameOver(getOtherPlayer(deadPlayer));
        return;
    }

    activePlayer.getArrow().cannotBeCollidedWith = true;
    activePlayer.items.clear();

    activePlayer.roundPoints = 0;

    if (tutorialActive) {
        tutorial.handleFinishTurn();
        return;
    }

    handleSkipTurn();

    if(getOtherPlayer(activePlayer).roundsOfSkip == 0){
        activePlayer.skipTurn();
        activePlayer = getOtherPlayer(activePlayer);    
    } else {
        getOtherPlayer(activePlayer).skipTurn();    
    }
    camera.animateCenterOnObject(activePlayer, frameWait, () -> gameMenu.open());
    
}

public void handleSkipTurn(){
    int minSkipRoundsBetweenTwoPlayers = 0;
    for(Player p: players){
        minSkipRoundsBetweenTwoPlayers = (int)Math.min(minSkipRoundsBetweenTwoPlayers, p.getSkipTurns());
    }
    for(Player p: players){
        p.roundsOfSkip -= minSkipRoundsBetweenTwoPlayers;
    }
}

public void finishInvalidPlayerTurn() {
    println("[TODO] Arrow too slow!");
    finishPlayerTurn();
    spentArrows.remove(spentArrows.get(spentArrows.size()-1));
}


public void setWinnerAndGameOver(Player p) {
    gameState = GameState.GAMEOVER;
    gameOverPage.setWinner(p.getPlayerNum() == PlayerNum.ONE ? "1" : "2");
    winningPlayer = p;
    camera.animateCenterOnXY(p.getX(), p.getY()-90, 60);
    tutorial.hide = true;
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
