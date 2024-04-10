class GUIComponent extends Obj {
    protected String content;
    protected int fontSize;
    PFont font;
    boolean center = true;

    GUIComponent(String content, float x, float y, int fontSize) {
        super(x, y);
        this.content = content;
        this.fontSize = fontSize;
        this.font = createFont(ASSETS_PATH+"OpenSans-Regular.ttf", fontSize);
        this.updateDimensions();
    }

    GUIComponent(String content, float x, float y, PFont font) {
        super(x, y);
        this.content = content;
        this.fontSize = font.getSize();
        this.font = font;
        this.updateDimensions();
    }

    GUIComponent(String content, float y, int fontSize) {
        this(content, 0, y, fontSize);
        x = width/2;
    }

    public void setContent(String text) {
        this.content = text;
        this.updateDimensions();
    }
    public void setContent(int text) { setContent(String.valueOf(text)); }
    public void setContent(float text) { setContent(String.valueOf(text)); }

    private void updateDimensions() {
        pushStyle();
        textFont(font);
        textSize(fontSize);
        setDimensions(textWidth(content), fontSize);
        popStyle();
    }

    public void setFont(PFont font) {
        this.font = font;
        updateDimensions();
    }

    public void draw() {
        stroke(0);
        fill(0, 255, 255);
        textFont(font);
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
    boolean realPositioning = false;

    boolean active = false;
    boolean mouseDownOnButton = false;

    Button(String name, float x, float y, int fontSize, Runnable callback){
        super(name, x, y, fontSize);
        this.callback = callback;
    }

    Button(String name, float x, float y, PFont font, Runnable callback) {
        super(name, x, y, font);
        this.callback = callback;
    }

    public void handleClick() {
        if (!mousePressed && mouseHovering()) {
            callback.run();
        }
    }

    void draw() {
        if (!active) return;

        stroke(255);
        if (!mouseHovering()) noFill();
        else fill(100, 100, 100);

        if (center) {
           rect(x-objWidth/2-4, y-objHeight, objWidth+7, objHeight+YPAD);
        }
        else {
            rect(x, y-objHeight, objWidth, objHeight+YPAD);
        }
        super.draw();
    }

    boolean mouseHovering() {
        float mX = realPositioning ? camera.getRealMouseX() : mouseX;
        float mY = realPositioning ? camera.getRealMouseY() : mouseY;

        if (center) {
            return (mX > x-objWidth/2 && mX < x+objWidth/2 && mY > y-objHeight && mY < y+YPAD);
        }
        else {
            return (mX > x && mX < x+objWidth && mY > y-objHeight && mY < y+YPAD);
        }
    }

    public void realPositioning(boolean val) {
        this.realPositioning = val;
    }

    public void show() {
        active = true;
        activeButtons.add(this);
    }

    public void show(boolean active) {
        if (active) show();
        else hide();
    }

    public void hide() {
        active = false;
        activeButtons.remove(this);
    }

}
