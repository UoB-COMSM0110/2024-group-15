import java.text.DecimalFormat;

class PointsSplash {
    GUIComponent pointsText, multiplierText;

    PointsSplash() {
        pointsText = new GUIComponent("", width/2+30, height/2+30, 30);
        multiplierText = new GUIComponent("", width/2+60, height/2+60, 30);
        this.pointsText.center = false;
        this.multiplierText.center = false;
    }

    public void draw() {
        if (!activePlayer.getArrow().isMoving()) return;

        pointsText.setContent(activePlayer.getRoundPoints());
        DecimalFormat df = new DecimalFormat("0.00");
        multiplierText.setContent("x"+df.format(activePlayer.getMultiplier()));

        resetMatrix();
        pushStyle();

        pointsText.draw();
        multiplierText.draw();

        popStyle();
        resetMatrix();
        camera.apply();

    }
}
