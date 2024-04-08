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
    GUIComponent gameTitle;
    Button vsHuman;
    Button vsComputer;
    Button easyMode;
    Button hardMode;
    // PImage backgroundImage = loadImage("./start-menu-idea/background.jpg");


    StartMenu() {
        gameTitle = new GUIComponent("BOWMAN", 70*2, 70);

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
            gameInit();

        });

        hardMode = new Button("Hard", width/2, height/2+200, 30, () -> {
            gameSettings.put("difficulty", Settings.HARD);
            gameInit();
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