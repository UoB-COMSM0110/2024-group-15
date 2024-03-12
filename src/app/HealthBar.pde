/*
*  Player health bars
*/


public class HealthBar {
    int x, y;
    Player player;
    int animationFrame = 0;

    HealthBar(Player player, PlayerNum playerNum) {
        this.player = player;
        this.x = playerNum == PlayerNum.ONE ? 20 : width-200;
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
                if (animationFrame > 0 && player.getHealth() == i) {
                    fill(255, 255, 255);
                    animationFrame--;
                }
                else {
                    fill(100, 100, 100);
                }
            }
            drawHeart(x+i*20);
        }

        popStyle();
        resetMatrix();

        camera.apply();


    }

    public void animateHealthBarLoss() {
        animationFrame = 120;

    }
}
