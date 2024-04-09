/*
*  Player health bars
*/
public class HealthBar {
    int x, y;
    Player player;
    int animationFrame = 0;
    PlayerNum playerNum;

    HealthBar(Player player, PlayerNum playerNum) {
        this.player = player;

        this.x = playerNum == PlayerNum.ONE ? 20 : width-20*maxHealth;

        this.y = 20;
        this.playerNum = playerNum;
    }

    private void drawHeart(int x) {
        shape(HEART_SHAPE, x, y);
    }

    public void draw() {
        resetMatrix();
        pushStyle();

        for (int i=0; i<maxHealth; i++) {
            int threshold = playerNum == PlayerNum.ONE ? i : maxHealth-i-1;
            if (player.getHealth() > threshold) {
                HEART_SHAPE.setFill(color(255, 100, 70));
            }
            else {
                if (animationFrame > 0 && player.getHealth() == i) {
                    float normal = (1/(float)120)*animationFrame;
                    color fade = lerpColor(color(100, 100, 100), color(255, 255, 255), normal);
                    HEART_SHAPE.setFill(fade);
                    animationFrame--;
                    // scale(normal+1);
                    // translate(20*normal, -10*(1+normal));
                }
                else {
                    HEART_SHAPE.setFill(color(100, 100, 100));
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
