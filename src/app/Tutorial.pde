class Tutorial {
    TutorialComponent helpMessage;
    
    Tutorial() {
        helpMessage = new TutorialComponent("Fire: (L)Mouse; Cancel: (R)Mouse", 10, height, 27);      //Help message: content, x, y, fontsize
    }
    
    void draw() {
        resetMatrix();      //reset other camera moving so that the tutorial can be print on the lfet-button of the window
        pushStyle();

        fill(0, 255, 255);
        helpMessage.draw();

        popStyle();
        resetMatrix();
        camera.apply();
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
        fill(255, 255, 255);      //change tutorial's colour
        textFont(f);
        text(content, x, y - fontSize);
    }
}
