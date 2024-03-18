/*
*  handles the mouse aim tool and changes the velocity of the arrow
*/
int maxPower = 200;

public class Aimer {
    Arrow arrow;
    Player player;

    Aimer(Player player, Arrow arrow) {
        this.arrow = arrow;
        this.player = player;
    }
    float x1, y1;
    boolean aiming = false;

    void update() {
        if (arrow.isMoving || camera.isMoving()) {  //  if moving arrow OR camera is moving skip    TODO these should be a getters
            return;
        }
        if (!(mousePressed && mouseButton == LEFT) && !aiming) {     // skip if left mouse not pressed and not aiming
            return;
        }
        //stop aiming if right click the mouse
        if(mousePressed && mouseButton == RIGHT){
            aiming = false;
            return;
        }
        if (!mousePressed) {           // stop aiming and fire
            arrow.isMoving = true;
            //arrow.showBow=false;
            aiming = false;
            camera.pushZoom();
            return;
        }
        float x2 = mouseX;
        float y2 = mouseY;
        
        if (!aiming) {                      // start aiming
            arrow.x = player.x;
            arrow.y = player.y;

            player.animation.status = AnimationStatus.DRAW;
            player.animation.loadImages();
            player.animation.currentFrame = 0;

            x1 = mouseX;
            y1 = mouseY;

            arrow.isMoving = false;
            aiming = true;
            camera.centerOnObject(player);
            camera.popZoom();
        }
       
        float lengthOfLine = (float)Math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
        float angleRadians = (float)Math.atan2(y1-y2, x1-x2);
        //float angleRadians = (float)Math.atan2(arrow.velocity.y, arrow.velocity.x);

        // stop the line from growing in length past 200
        if (lengthOfLine > maxPower) {
            lengthOfLine = maxPower;
            x2 = x1 - maxPower * (float)Math.cos(angleRadians);
            y2 = y1 - maxPower * (float)Math.sin(angleRadians);
        }
        
        // get the vector of the 2 points made by mouse press
        arrow.velocity = new PVector(x1-x2, y1-y2);
        // scale it by 0.1 (to make the arrow travel at a fairly normal speed)
        arrow.velocity.mult(0.1F);
        
        //angle <- velocity, velocity <- x2, x2 <- angle(bug)

        // draw the line
        resetMatrix();
        pushStyle();

        textSize(20);
        fill(255);
        text(lengthOfLine, x1, y1);
        text(angleRadians*(180/(float)Math.PI), x2, y2);

        stroke(255, 255, 255);
        line(x1, y1, x2, y2);

        popStyle();
        camera.apply();


        // PATHFINDER TEST
        // Pathfinder path = new Pathfinder(arrow.x, arrow.y, new PVector(x1-x2, y1-y2));
        // path.draw();
    }
}
