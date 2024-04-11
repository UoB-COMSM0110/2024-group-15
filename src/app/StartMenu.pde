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
    NAMES,
}

/*
*   the start menu class (holds buttons, text etc.)
*/
class StartMenu {
    StartMenuState state;
    GUIComponent gameTitle;
    Button vsHuman;
    Button vsComputer;
    Button tutorialButton;
    Button easyMode;
    Button hardMode;
    Button startButton;
    TextBox p1Text;
    TextBox p2Text;
    // PImage backgroundImage = loadImage("./start-menu-idea/background.jpg");


    StartMenu() {
        gameTitle = new GUIComponent("BOWMAN", 70*2, 70);

        vsHuman = new Button("vs Human", width/2, height/2+100, SFPro, () -> {
            gameSettings.put("player_mode", Settings.VSHUMAN);
            setState(StartMenuState.DIFFICULTY);
        });

        vsComputer = new Button("vs Computer", width/2, height/2+200, SFPro, () -> {
            gameSettings.put("player_mode", Settings.VSCOMPUTER);
            setState(StartMenuState.DIFFICULTY);
        });

        tutorialButton = new Button("TUTORIAL", width/2, height/2+300, SFPro, () -> {
            tutorial.enable();
            gameInit();
        });

        easyMode = new Button("Easy", width/2, height/2+100, SFPro, () -> {
            gameSettings.put("difficulty", Settings.EASY);
            setState(StartMenuState.NAMES);

        });

        hardMode = new Button("Hard", width/2, height/2+200, SFPro, () -> {
            gameSettings.put("difficulty", Settings.HARD);
            setState(StartMenuState.NAMES);
        });

        startButton = new Button("START", width/2, height/2+200, SFPro, () -> {
            player1Name = p1Text.get();
            player2Name = p2Text.get();
            close();
            gameInit();
        });

        p1Text = new TextBox("Player 1: ", width/2, height/2-100, SFPro);
        p2Text = new TextBox("Player 2: ", width/2, height/2, SFPro);

        setState(StartMenuState.VS);
    }
    

    void draw() {
        pushStyle();

        fill(255, 255, 255);
        gameTitle.draw();

        vsHuman.draw();
        vsComputer.draw();
        easyMode.draw();
        hardMode.draw();
        tutorialButton.draw();
        p1Text.draw();
        p2Text.draw();
        startButton.draw();

        
        // DEBUG draw cross for centering
        // stroke(255);
        // line(width/2, 0, width/2, height);
        // line(0, height/2, width, height/2);

        popStyle();
    }

    void setState(StartMenuState s) {
        close();
        switch (s) {
            case VS:
                tutorialActive = false;
                vsHuman.show();
                vsComputer.show();
                tutorialButton.show();
                break;
            case DIFFICULTY:
                easyMode.show();
                hardMode.show();
                break;
            case NAMES:
                p1Text.content = "";
                p2Text.content = "";
                p1Text.show();
                p2Text.show();
                startButton.show();
                break;
        }
    }

    void close() {
        vsHuman.show(false);
        vsComputer.show(false);
        tutorialButton.show(false);
        easyMode.show(false);
        hardMode.show(false);
        p1Text.show(false);
        p2Text.show(false);
        startButton.show(false);
    }
}