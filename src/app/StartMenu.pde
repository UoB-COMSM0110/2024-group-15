/** 
NOTES
 *  all imgs should load in app.pde
 *  all fonts should load in app.pde
 *  start button should just be text I think (not an img)
 *  class names and enums need a capital letter at the start
 *  indent 4 spaces
*/       


enum StartMenuState {
    VS,
    DIFFICULTY,
}

/*
*   the start menu class (holds buttons, text etc.)
*/
class StartMenu {
    StartMenuState state = StartMenuState.VS;
    StartMenuComponent gameTitle;
    Button vsHuman;
    Button vsComputer;
    Button easyMode;
    Button hardMode;
    // PImage backgroundImage = loadImage("./start-menu-idea/background.jpg");


    StartMenu() {
        gameTitle = new StartMenuComponent("BOWMAN", 350, 100);

        vsHuman = new Button("vs Human", width/2, height/2+100, 30, () -> {
            gameSettings.put("player_mode", Settings.VSHUMAN);
            state = StartMenuState.DIFFICULTY; 
        });

        vsComputer = new Button("vs Computer", width/2, height/2+200, 30, () -> {
            gameSettings.put("player_mode", Settings.VSCOMPUTER);
            state = StartMenuState.DIFFICULTY;
        });

        easyMode = new Button("Easy", width/2, height/2+100, 30, () -> {
            gameSettings.put("difficulty", Settings.EASY);
            gameState = GameState.EASYGAMESET;
        });

        hardMode = new Button("Hard", width/2, height/2+200, 30, () -> {
            gameSettings.put("difficulty", Settings.HARD);
            gameState = GameState.GAME;
        });
    }
    

    void draw() {
        pushStyle();

        fill(255, 255, 255);
        gameTitle.draw();

        switch(state) {
            case VS:
                vsHuman.draw();
                vsComputer.draw();
                break;
            case DIFFICULTY:
                easyMode.draw();
                hardMode.draw();
                break;
        }
        
        // DEBUG draw cross for centering
        // stroke(255);
        // line(width/2, 0, width/2, height);
        // line(0, height/2, width, height/2);

        popStyle();
    }
}


class StartMenuComponent extends Obj {
    protected String content;
    protected int fontSize;
    PFont f;

    StartMenuComponent(String content, float x, float y, int fontSize) {
        super(x, y);
        this.content = content;
        this.fontSize = fontSize;
        this.f = createFont(ASSETS_PATH+"OpenSans-Regular.ttf", fontSize);

        textFont(f);
        textSize(fontSize);
        setDimensions(textWidth(content), fontSize);
    }

    StartMenuComponent(String content, float y, int fontSize) {
        this(content, 0, y, fontSize);
        x = width/2;
    }

    public void draw() {
        stroke(0);
        fill(255, 255, 255);
        textFont(f);
        text(content, x-objWidth/2, y);
    }
}

class Button extends StartMenuComponent {
    final int YPAD = 10;
    Runnable callback;
    boolean mouseDownOnButton;

    Button(String name, int x, int y, int fontSize, Runnable callback){
        super(name, x, y, fontSize);
        this.callback = callback;
    }

    private void checkForHoverAndClick() {
        if (!mouseHovering()) {
            if (mousePressed) mouseDownOnButton = false;
            noFill();
            return;
        }
        fill(100, 100, 100);
        if (mousePressed) {
            mouseDownOnButton = true;
        }
        else if (mouseDownOnButton) {
            callback.run();
        }
    }
    
    void draw() {
        checkForHoverAndClick();
        stroke(255);
        rect(x-objWidth/2, y-objHeight, objWidth, objHeight+YPAD);
        super.draw();
    }

    private boolean mouseHovering() {
        return (mouseX > x-objWidth/2 && mouseX < x+objWidth/2 && mouseY > y-objHeight && mouseY < y+YPAD);
    }
}
