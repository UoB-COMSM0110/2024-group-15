/*
*  Player health bars
*/

import static processing.core.PApplet.*;

public class HealthBar {
    App app;
    int x, y;
    Player player;

    HealthBar(Player player, int x, int y) {
        this.app = player.app;
        this.player = player;
        this.x = x;
        this.y = y;
    }

    private void drawHeart(int x) {
        app.beginShape();
        int a = 1;
        float t = 0;
        while (t < app.TWO_PI) {
            float xCoord = 16 * pow(sin(t), 3) * a;
            float yCoord = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t) * a;
            app.vertex(x + xCoord, y - yCoord);
            t += 0.01;
        }
        app.endShape(app.CLOSE);

    }

    public void draw() {
        app.resetMatrix();
        app.pushStyle();

        app.fill(255, 100, 70);
        app.noStroke();

        app.scale(0.5F);
        for (int i=0; i<10; i++) {
            drawHeart(x+i*40);
        }

        app.popStyle();
        app.resetMatrix();

        app.camera.apply();
    }
}
