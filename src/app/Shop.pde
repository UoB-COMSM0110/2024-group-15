enum ShopInterfaceState{
   CLOSED,
   OPEN,
}


class ShopInterface {
   int buttonWidth = 300;  
   int buttonHeight = 70; 
   int startX = 490; 
   int startY = 250; 
   int buttonGap = 30; 
   int shadowOffset = 10; 
   int colorRedCode = 64;
   int colorGreenCode = 224;
   int colorBlueCode = 208;
   int textColor = 0;


   Button shopButton = new Button("SHOP", width-40, 40, 20, () -> {
            state = ShopInterfaceState.OPEN;
   });

   ShopInterfaceState state = ShopInterfaceState.CLOSED;

   void draw() {

      // textAlign(CENTER, CENTER);

      resetMatrix();
      pushStyle();

      if (state == ShopInterfaceState.CLOSED) {
         shopButton.draw();
         return;
      }



      // background(0);
      

      drawButtonWithShadow(startX, startY, "Path Finder", 
                           color(colorRedCode,colorGreenCode, colorBlueCode));
      drawButtonWithShadow(startX, startY + buttonHeight + buttonGap, "Double Strike", 
                           color(colorRedCode,colorGreenCode, colorBlueCode));

      popStyle();
      camera.apply();

   }

   void mousePressed() {
      if (mouseX > startX && mouseX < startX + buttonWidth && 
          mouseY > startY && mouseY < startY + buttonHeight) {
         // TODO
         // Enable path finder
         println("Select path finder");
   }
      if (mouseX > startX && mouseX < startX + buttonWidth && 
          mouseY > startY + buttonHeight + buttonGap && mouseY < startY + 2 * buttonHeight + buttonGap) {
         // TODO
         println("Select double strike");
   }
   }

   void drawButtonWithShadow(int x, int y, String text, color buttonColour) {
      fill(40,40,40); 
      rect(x + shadowOffset, y + shadowOffset, buttonWidth, buttonHeight); 
      fill(buttonColour);
      rect(x, y, buttonWidth, buttonHeight); 
      fill(textColor); 
      textSize(25); 
      text(text, x + buttonWidth/2, y + buttonHeight/2);
    }
}
