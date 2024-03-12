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
    StartMenuComponent gameTitle;
    Button vsHuman;
    Button vsComputer;

    PImage backgroundImage = loadImage("./start-menu-idea/background.jpg");


    StartMenu() {
        gameTitle = new StartMenuComponent("BOWMAN", 70*2, 70);
        vsHuman = new Button("vs Human", screenHeight/2 + 100, 30);
        vsComputer = new Button("vs Computer", screenHeight/2 + 200, 30);


    }
  

    void draw() {

        pushStyle();
        // image(backgroundImage, 0, 0, screenWidth, screenHeight);
        fill(0, 255, 255);
        gameTitle.draw();
        vsHuman.draw();
        vsComputer.draw();


        // DEBUG draw cross for centering
        stroke(255);
        line(width/2, 0, width/2, height);
        line(0, height/2, width, height/2);

        popStyle();
    }
}

/*
*   
*/
class StartMenuComponent extends Obj {
    protected String content;
    protected int fontSize;
    PFont f;

    StartMenuComponent(String content, float x, float y, int fontSize) {
        super(x, y);
        this.content = content;
        this.fontSize = fontSize;
        this.f = createFont("./start-menu-idea/OpenSans-Regular.ttf", fontSize);

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
        fill(0, 255, 255);
        textFont(f);
        text(content, x-objWidth/2, y);
    }
}

class Button extends StartMenuComponent{
    final int YPAD = 10;

    Button(String name, int x, int y, int fontSize){
        super(name, x, y, fontSize);
    }

    Button(String content, int y, int fontSize) {
        super(content, y, fontSize);
    }
    
    void draw() {
        if (mouseHovering()) {
            fill(100, 100, 100);
        }
        else {
            noFill();
        }
        stroke(255);
        rect(x-objWidth/2, y-objHeight, objWidth, objHeight+YPAD);
        super.draw();
    }

    private boolean mouseHovering() {
        return (mouseX > x-objWidth/2 && mouseX < x+objWidth/2 && mouseY > y-objHeight && mouseY < y+YPAD);
    }
}
