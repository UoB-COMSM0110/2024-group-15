/*
*  handles the mouse aim tool and changes the velocity of the arrow
*/

public class Aimer {
    private final static int MAXPOWER = 200;
    Arrow arrow;
    Player player;
    float lengthOfLine = 0;
    float angleRadians = 0;

    float x1, y1, x2, y2;
    boolean aiming = false;

    Aimer(Player player, Arrow arrow) {
        this.arrow = arrow;
        this.player = player;
    }

    void handleMouseDown() {
        if (tutorialActive && !tutorial.canFire()) return;
        if (arrow.isMoving() || camera.isMoving()) return;          //  if moving arrow OR camera is moving skip
        if (playerMover.selecting) return;

        if (!aiming) {                     // start aiming
            gameMenu.close();


            player.setSprite(PlayerStatus.DRAW);

            x1 = x2 = mouseX;
            y1 = y2 = mouseY;
            arrow.isMoving = false;
            aiming = true;
            camera.setXY(player.x, player.y);
            camera.popZoom();
        }
    }


    void handleMouseUp() {
        if (!aiming || camera.isMoving()) return;
        arrow.x = player.x;
        arrow.y = player.y;
         // get the vector of the 2 points made by mouse press
        arrow.velocity = new PVector(x1-x2, y1-y2);
        // scale it by 0.1 (to make the arrow travel at a fairly normal speed)
        arrow.velocity.mult(0.1F);

        arrow.isMoving = true;      // stop aiming and fire
        aiming = false;
        lengthOfLine = 0;
        camera.pushZoom();
        audio.playFire();
        audio.playWind();

        player.setSprite(PlayerStatus.IDLE);
        return;
    }

    void handleMouseMove() {
        if (!aiming) return;
        x2 = mouseX;
        y2 = mouseY;
        lengthOfLine = (float)Math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
        angleRadians = (float)Math.atan2(y1-y2, x1-x2);

        // stop the line from growing in length past 200
        if (lengthOfLine > MAXPOWER) {
            lengthOfLine = MAXPOWER;
            x2 = x1 - MAXPOWER * (float)Math.cos(angleRadians);
            y2 = y1 - MAXPOWER * (float)Math.sin(angleRadians);
        }

    }


    void draw() {
        if (!aiming) return;

        resetMatrix();
        pushStyle();

        textFont(SFPro);
        textSize(20);
        fill(255);
        text(lengthOfLine, x1, y1);
        text(angleRadians*(180/(float)Math.PI), x2, y2);

        stroke(255, 255, 255);
        line(x1, y1, x2, y2);

        popStyle();
        camera.apply();
    }
}
