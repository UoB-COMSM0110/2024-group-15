/*
*  Player health bars
*/

public class PointsBar extends GUIComponent {
    Player player;
    boolean isP1;


    PointsBar(Player player, PlayerNum playerNum) {
        super("0", 0, 85, SFPro);
        isP1 = player.playerNum == PlayerNum.ONE;
        setX(isP1 ? 20 : width-textWidth(content));

        this.player = player;
        this.center = false;
    }

    

    public void draw() {
        resetMatrix();
        pushStyle();

        textFont(SFPro);
        setX(isP1 ? 20 : width-textWidth(content)-20);
        
        super.draw();


        text(isP1 ? player1Name : player2Name, isP1 ? x-1 : (x+textWidth(content))-textWidth(player2Name), y-25);

        popStyle();
        resetMatrix();
        camera.apply();

    }
}
