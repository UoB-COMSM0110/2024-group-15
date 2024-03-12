PFont f;


class InitialInterface{
  title t = new title("TITLE", 70);
  menuIcon p1 = new menuIcon("P1", screenWidth/2 - 50, screenHeight/2 + 100, 30);
  menuIcon p2 = new menuIcon("P2", screenWidth/2 - 50, screenHeight/2 + 200, 30);
  PImage img = loadImage("./start-menu-idea/start-button.png");
  PImage backgroundImage = loadImage("./start-menu-idea/background.jpg");
  

  
  void draw(){
    //we could use image, text or animation.
    image(backgroundImage, 0, 0, screenWidth, screenHeight);
    //The title
    fill(0, 255, 255);
    f = createFont("./start-menu-idea/OpenSans-Regular.ttf", t.getFontSize());
    textFont(f);
    text(t.getContent(), t.getPosX(), t.getPosY());
    
    //The Start button, 1P, 2P?
    fill(0, 255, 255);
    textFont(f);
    text(p1.getContent(), p1.getPosX(), p1.getPosY());
    text(p2.getContent(), p2.getPosX(), p2.getPosY());
    
    //The frames of p1 and p2
    p1.draw();
    p2.draw();
    image(img, 800,400);
    
    //press any button to start
    fill(255);
    textSize(25);
    //textAlign(CENTER, CENTER);
    text("Press Any Button To Start", screenWidth/2 - 130, screenHeight - 60);
    
  }
}

class startMenuComponent {
    private String content;
    private int posX;
    private int posY;
    private int fontSize;

    public startMenuComponent(String content, int posX, int posY, int fontSize) {
        this.content = content;
        this.posX = posX;
        this.posY = posY;
        this.fontSize = fontSize;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getPosX() {
        return posX;
    }

    public void setPosX(int posX) {
        this.posX = posX;
    }

    public int getPosY() {
        return posY;
    }

    public void setPosY(int posY) {
        this.posY = posY;
    }
    
    public int getFontSize() {
        return fontSize;
    }

    public void setFontSize(int fontSize) {
        this.fontSize = fontSize;
    }
}

class title extends startMenuComponent{
    public title(String name, int size){
        super(name, screenWidth / 2 - name.length()*20, size*2, size);
    }
}

class menuIcon extends startMenuComponent{
    public menuIcon(String name, int posX, int posY, int size){
        super(name, posX, posY, size);
    }
    
//class PressToStartText extends startMenuComponent {
//    PressToStartText(String content, int posX, int posY, int fontSize) {
//        super(content, posX, posY, fontSize);
//    }
    
    
    void draw(){
        stroke(0);
        noFill();
        rect(getPosX() - 10, getPosY() - getFontSize() * 2, 60 * getContent().length(), 60);
        
  
    }  
}

//------------------------------------------------------------
