class Tutorial {
    TutorialComponent helpMessage;
    
    Tutorial() {
        helpMessage = new TutorialComponent("Left click, drag the mouse", 0, height - 100, 70);
    }
    
    void draw() {
        pushStyle();

        fill(0, 255, 255);
        helpMessage.draw();

        popStyle();
    }
}

class TutorialComponent extends Obj {
    protected String content;
    protected int fontSize;
    PFont f;

    TutorialComponent(String content, float x, float y, int fontSize) {
        super(x, y);
        this.content = content;
        this.fontSize = fontSize;
        this.f = createFont(ASSETS_PATH+"OpenSans-Regular.ttf", fontSize);

        textFont(f);
        textSize(fontSize);
        setDimensions(textWidth(content), fontSize);
    }

    public void draw() {
        stroke(0);
        fill(0, 255, 255);
        textFont(f);
        text(content, x-objWidth/2, y);
    }
}
