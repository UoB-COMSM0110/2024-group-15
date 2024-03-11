/*
*  Player health bars
*/


enum HeathBarPosition {
    LEFT,
    RIGHT,
}


public class HealthBar {
    int x, y;
    Player player;

    HealthBar(Player player, HeathBarPosition pos) {
        this.player = player;
        this.x = pos == HeathBarPosition.LEFT ? 20 : width-200;
        this.y = 20;
    }

    private void drawHeart(int x) {
        beginShape();
        float a = 0.5;
        float t = 0;
        while (t < TWO_PI) {
            float xCoord = (16 * pow(sin(t), 3)) * a;
            float yCoord = (13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t)) * a;
            vertex(x + xCoord, y - yCoord);
            t += 0.01;
        }
        endShape(CLOSE);

    }

    public void draw() {
        resetMatrix();
        pushStyle();

        noStroke();
        for (int i=0; i<10; i++) {
            if (player.getHealth() > i) {
                fill(255, 100, 70);
            }
            else {
                fill(100, 100, 100);
            }
            drawHeart(x+i*20);
        }

        popStyle();
        resetMatrix();

        camera.apply();
    }
}
