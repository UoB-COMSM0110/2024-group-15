/*
*  Player health bars
*/

public class PointsBar extends GUIComponent {
    Player player;
    int boxWidth = 10;

    PointsBar(Player player, PlayerNum playerNum) {
        super("", 0, 50, 24);
        setX(playerNum == PlayerNum.ONE ? 20 : width-20-boxWidth);
        this.player = player;
        this.center = false;
    }

    public void draw() {
        resetMatrix();
        pushStyle();
        
        super.draw();

        popStyle();
        resetMatrix();
        camera.apply();

    }
}
