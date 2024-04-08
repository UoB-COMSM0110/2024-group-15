class GUIComponent extends Obj {
    protected String content;
    protected int fontSize;
    PFont f;
    boolean center = true;

    GUIComponent(String content, float x, float y, int fontSize) {
        super(x, y);
        this.content = content;
        this.fontSize = fontSize;
        this.f = createFont(ASSETS_PATH+"OpenSans-Regular.ttf", fontSize);

        textFont(f);
        textSize(fontSize);
        setDimensions(textWidth(content), fontSize);
    }

    GUIComponent(String content, float y, int fontSize) {
        this(content, 0, y, fontSize);
        x = width/2;
    }

    public void draw() {
        stroke(0);
        fill(0, 255, 255);
        textFont(f);
        if (center) {
            text(content, x-objWidth/2, y);
        }
        else {
            text(content, x, y);
        }

    }
}

class Button extends GUIComponent {
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
        if (center) {
           rect(x-objWidth/2, y-objHeight, objWidth, objHeight+YPAD);
        }
        else {
            rect(x, y-objHeight, objWidth, objHeight+YPAD);
        }
        super.draw();
    }

    private boolean mouseHovering() {
        if (center) {
            return (mouseX > x-objWidth/2 && mouseX < x+objWidth/2 && mouseY > y-objHeight && mouseY < y+YPAD);
        }
        else {
            return (mouseX > x && mouseX < x+objWidth && mouseY > y-objHeight && mouseY < y+YPAD);
        }
    }
}
