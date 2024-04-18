class GUIComponent extends Obj {
    final int YPAD = 10;

    protected String content;
    protected int fontSize;
    PFont font;
    boolean center = true;
    boolean useStroke = false;
    boolean fillBackground = false;
    boolean useBackground = false;
    color textColor = color(255, 255, 255);

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
        setDimensions(textWidth(content), fontSize*(1+countNewLines()));
        popStyle();
    }

    public void setFont(PFont font) {
        this.font = font;
        updateDimensions();
    }

    private int countNewLines() {
        int count = 0;
        for (int i=0; i<content.length(); i++) {
            if (content.charAt(i) == '\n') count++;
        }
        return count;
    }

    public void draw() {
        stroke(useStroke ? 255 : 0);
        if (fillBackground) fill(255);

        if (useBackground) {
            if (center) {
               rect(x-objWidth/2-4, y-fontSize, objWidth+7, objHeight+YPAD);
            }
            else {
                rect(x, y-fontSize, objWidth, objHeight+YPAD);
            }
        }

        fill(textColor);
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
    Runnable callback;
    boolean realPositioning = false;

    boolean active = false;
    boolean mouseDownOnButton = false;

    Button(String name, float x, float y, int fontSize, Runnable callback){
        super(name, x, y, fontSize);
        this.callback = callback;
        useStroke = true;
        useBackground = true;
    }

    Button(String name, float x, float y, PFont font, Runnable callback) {
        super(name, x, y, font);
        this.callback = callback;
        useStroke = true;
        useBackground = true;
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


class TextBox extends Button {
    boolean inFocus;
    boolean active;
    String typed = "";

    TextBox(String content, float x, float y, PFont font) {
        super(content, x, y, font, null);

        pushStyle();
        textFont(font);
        textSize(fontSize);
        setDimensions(textWidth(content)+124, fontSize);
        popStyle();
    }

    public String get() {
        return typed;
    }


    public void draw() {
        if (!active) return;
            // if (center) {
            //    rect(x-objWidth/2-4, y-fontSize, objWidth+7, objHeight+YPAD);
            // }
            // else {
            //     rect(x, y-fontSize, objWidth, objHeight+YPAD);
            // }

        fill(textColor);
        textFont(font);
        if (center) {
            text(content, x-objWidth/2, y);
        }
        else {
            text(content, x, y);
        }

        if (inFocus) fill(255, 255, 255);
        else noFill();
        stroke(255);
        rect(x+textWidth(content)-objWidth/2+10, y-fontSize, 120, objHeight+YPAD);
        fill(inFocus ? 0 : 255);
        text(typed, x+textWidth(content)-objWidth/2+18, y);
    }

    public void handleClick() {
        if (mouseHovering()) {
            inFocus = true;
            println("true");
        }
        else {
            println("flase");
            inFocus = false;
        }
    }

    boolean inFocus() {
        return inFocus && active;
    }

    public void handleKey() {
        if (keyCode == 8) {
            if (typed.length() == 0) return;
            typed = typed.substring(0, typed.length()-1);
        }
        if (!Character.isLetter(key)) return;
        typed += Character.toUpperCase(key);
    }

    public void show(boolean active) {
        if (active) show();
        else hide();
    }

    public void show() {
        active = true;
        activeButtons.add(this);
    }

    public void hide() {
        active = false;
        activeButtons.remove(this);
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
}
