class ModeSelectionInterface {
  title t = new title("SELECT MODE", 50);
  menuButton easyButton = new menuButton("EASY", screenWidth/2 - 50, screenHeight/2 + 100, 30);
  menuButton hardButton = new menuButton("HARD", screenWidth/2 - 50, screenHeight/2 + 200, 30);
  
  int selectionBoxX; 
  int selectionBoxY; 
  int selectionBoxWidth;
  int selectionBoxHeight;

  ModeSelectionInterface() {
    selectionBoxX = easyButton.getPosX() - 10;
    selectionBoxY = easyButton.getPosY() - easyButton.getFontSize() * 2;
    selectionBoxWidth = 60 * easyButton.getContent().length();
    selectionBoxHeight = 60;
  }

  void draw() {
    background(0);
    fill(0, 255, 255);
    textSize(25);
    float titleWidth = textWidth(t.getContent());
    float titleHeight = textAscent() + textDescent();
    text(t.getContent(), screenWidth/2 - titleWidth/2, titleHeight + 120);

    fill(0, 255, 255);
    text(easyButton.getContent(), easyButton.getPosX(), easyButton.getPosY());
    text(hardButton.getContent(), hardButton.getPosX(), hardButton.getPosY());

    easyButton.draw();
    hardButton.draw();
    
    //selectbox
    stroke(255);
    noFill();
    rect(selectionBoxX, selectionBoxY, selectionBoxWidth, selectionBoxHeight);
    
    keyDetected();
  }


  
 void keyDetected() {
    if (keyCode == UP) {
      // move to easy button
      selectionBoxX = easyButton.getPosX() - 10;
      selectionBoxY = easyButton.getPosY() - easyButton.getFontSize() * 2;
      
    } else if (keyCode == DOWN) {
      // move to hard button
      selectionBoxX = hardButton.getPosX() - 10;
      selectionBoxY = hardButton.getPosY() - hardButton.getFontSize() * 2;
    } else if (keyCode == ENTER) {
  
      if (selectionBoxY == easyButton.getPosY() - easyButton.getFontSize() * 2) {
        gameState = GameState.EASY;
      } else if (selectionBoxY ==  hardButton.getPosY() - hardButton.getFontSize() * 2) {
        gameState = GameState.HARD;
      }
     }
  }

  //void mousePressed() {
  //    if (gameState == GameState.MODEPAGE) {
  //      if (easyButton.isMouseOver()) {
  //        gameState = GameState.EASY;
  //      } else if (hardButton.isMouseOver()) {
  //        gameState = GameState.HARD;
  //      }
  //    }
  //  }
  
}

class menuButton extends startMenuComponent {
  public menuButton(String name, int posX, int posY, int size) {
    super(name, posX, posY, size);
  }
  
  int getWidth() {
    return 60 * getContent().length(); 
   }

  int getHeight() {
    return 60; 
  }

  void draw() {
    stroke(0);
    noFill();
    //rect(getPosX() - 10, getPosY() - getFontSize() * 2, 60 * getContent().length(), 60);
    rect(getPosX() - 10, getPosY() - getFontSize() * 2, getWidth(), getHeight());
  
  }

  //boolean isMouseOver() {
  //  return mouseX >= getPosX() - 10 && mouseX <= getPosX() - 10 + getWidth() &&
  //         mouseY >= getPosY() - getFontSize() * 2 && mouseY <= getPosY() - getFontSize() * 2 + getHeight();
  //}
}
