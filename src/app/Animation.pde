import java.io.File;

public class Animation {
  final String animatePath = "./art-img/Animation";
  int status;
  PImage[] images;
  //int playerStatus; 
  
   private int currentFrame = 0;
  private int frameDuration = 50; 
  private int lastFrameChange = 0;
  private boolean isLooping = false;

  Animation(int status) {
    this.status = status;
    loadImages();
  }

  private void loadImages() {
    switch (this.status) {
      //stand by: not this person's turn or the arrow has been shoot 
      case 1:
        images = loadAnimationImages("idle",0, 12);
        break;
     //aiming:2_atk,1-8 frame
      case 2:
        images = loadAnimationImages("2_atk", 1,8);
        break;
       //fire:2_atk,8-12 frames
      case 3:
        images = loadAnimationImages("2_atk",8, 10);
        break;
      //fire(cheat mode)
       case 4:
        images = loadAnimationImages("3_atk",0, 10);
        break;
       //heath bar get down
       case 5:
        images = loadAnimationImages("take_hit",0, 10);
        break;
        
    }
  }

private PImage[] loadAnimationImages(String subfolder, int startframe, int count) {
    PImage[] animationImages = new PImage[count];
    animationImages[0] = null; 
    for (int i = startframe; i < count; i++) {
        String filename = animatePath + File.separator + subfolder + File.separator + subfolder + "_" + i + ".png";
        PImage loadedImage = loadImage(filename);
        if (loadedImage == null) {
            System.err.println("Error loading image: " + filename);
        } else {
            animationImages[i] = loadedImage;
        }
    }
    return animationImages;
}

public void playAnimationLoop(Player player) {
    float x = player.getX();
    float y = player.getY();
    int currentTime = millis(); 
    if (currentTime - lastFrameChange > frameDuration) {
      currentFrame = (currentFrame + 1) % images.length; 
      lastFrameChange = currentTime;
    }
        if (images[currentFrame] != null) {
        image(images[currentFrame], x+3, y-30);
    }
    //image for the postion
    //image(images[currentFrame], x, y); 
  }
   public void playAnimationStatic(Player player) {
    float x = player.getX();
    float y = player.getY();
    if (!isLooping) {
      int currentTime = millis();
      if (currentTime - lastFrameChange > frameDuration) {
        currentFrame++;  
        if (currentFrame >= images.length) {
          currentFrame = images.length - 1;  
          isLooping = false;  
        }
        lastFrameChange = currentTime;
      }
          if (images[currentFrame] != null) {
        image(images[currentFrame], x+3, y-30);
    }
     // image(images[currentFrame], x, y); 
      
    }
   }
}
