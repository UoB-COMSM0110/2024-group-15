    /** 
    * sprite class for animated images
    *   LOOP ->         looping animation
    *   FIRSTLAST ->    animate from first to last frame, and stay at the last frame
    */      


    enum AnimationType {
        LOOP,              
        FIRSTLAST,
    }

    public class Sprite {
        private PImage spriteSheet;
        private int spriteWidth;
        private int spriteHeight;
        private int numFrames;

        private int currentFrame = 0;
        private int frameDuration = 5;
        AnimationType animationType;
        Entity parent;

        Sprite(Entity parent, PImage spriteSheet, int spriteWidth, int spriteHeight, int numFrames, AnimationType animationType) {
            this.parent = parent;
            this.spriteSheet = spriteSheet;
            this.spriteWidth = spriteWidth;
            this.spriteHeight = spriteHeight;
            this.numFrames = numFrames;
            this.animationType = animationType;
        }

        void setAnimationType(AnimationType type) {
            this.animationType = type;
        }

        void draw() {
            imageMode(CENTER);
            PImage frame = spriteSheet.get(currentFrame*spriteWidth, 0, spriteWidth, spriteHeight);
            image(frame, parent.getX(), parent.getY(), spriteWidth, spriteHeight);
            if (frameCount % frameDuration == 0) {
                currentFrame++;
            }

            switch(animationType) {
                case LOOP:
                    currentFrame = currentFrame % numFrames;
                    break;
                case FIRSTLAST:
                    if (currentFrame >= numFrames) {
                        currentFrame = numFrames-1;
                    }
                    break;
            }
        }

        public boolean animationHasFinished() {
            return currentFrame >= numFrames;
        }

        public void resetToFirstFrame() {
            currentFrame = 0;
        }
    }
