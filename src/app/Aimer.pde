/*
*  handles the mouse aim tool and changes the velocity of the arrow
*/

import processing.core.PVector;

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
        if (!mousePressed && !aiming) {     // skip
            return;
        }
        if (!mousePressed) {                // stop aiming and fire
            arrow.isMoving = true;
            aiming = false;
            camera.pushZoom();
            return;
        }
        float x2 = mouseX;
        float y2 = mouseY;

        if (!aiming) {                          // start aiming
            arrow.x = player.x;
            arrow.y = player.y;

            x1 = mouseX;
            y1 = mouseY;

            arrow.isMoving = false;
            aiming = true;
            camera.updateXY(0, 0);
            camera.popZoom();
        }

        // get the vector of the 2 points made by mouse press
        arrow.velocity = new PVector(x1-x2, y1-y2);
        // scale it by 0.1 (to make the arrow travel at a fairly normal speed)
        arrow.velocity.mult(0.1F);

        float lengthOfLine = (float)Math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
        float angleRadians = (float)Math.atan2(arrow.velocity.y, arrow.velocity.x);

        // stop the line from growing in length past 200
        if (lengthOfLine > 200) {
            lengthOfLine = 200;
            x2 = x1 - 200 * (float)Math.cos(angleRadians);
            y2 = y1 - 200 * (float)Math.sin(angleRadians);
        }

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


        // PATHFINDER TEST (this is just test code for pathfinding,
        // uncomment the below if statement to see it in action
       if (true) {
           return;
       }
        Object path = new Object(arrow.x, arrow.y, new PVector(x1-x2, y1-y2));

        path.velocity.mult(0.1F);
        for (int i=0; i<200; i++) {

            PVector totalGrav = new PVector(0, 0);
            for (Planet p : planets) {
                totalGrav.add(p.calculateGravity(path));
            }

            totalGrav.div(1);
            path.velocity.add(totalGrav);

            path.x += path.velocity.x;
            path.y += path.velocity.y;
            ellipse(path.x, path.y, 10, 10);
        }
    }
}
