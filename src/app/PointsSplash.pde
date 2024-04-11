import java.text.DecimalFormat;

class PointsSplash {
    GUIComponent pointsText, multiplierText;
    boolean animateDown;
    boolean animateLeft;
    boolean animateRight;
    color c = color(255);

    PointsSplash() {
        pointsText = new GUIComponent("", width/2+30, height/2+30, SFPro);
        multiplierText = new GUIComponent("", width/2+60, height/2+60, SFPro);
        this.pointsText.center = false;
        this.multiplierText.center = false;
    }

    void animateDown() {
        animateDown = true;
    }


    void resetPositions() {
        animateDown = animateLeft = animateRight = false;
        pointsText.textColor = color(255);
        pointsText.setXY(width/2+30, height/2+30);
        multiplierText.textColor = color(255);
        multiplierText.setXY(width/2+60, height/2+60);
    }

    boolean animate() {
        if (animateDown) {
            pointsText.y += 6;
            pointsText.textColor = color(255, 255, 255, ((pointsText.y/2)/height/2)*600);
            multiplierText.y += 7;
            multiplierText.textColor = color(255, 255, 255, ((pointsText.y/2)/height/2)*600);
            if (pointsText.y > height) {
                resetPositions();
                return false;
            }
            return true;
        }
        else if (animateLeft || animateRight) {
            pointsText.x += animateLeft ? -8 : 8;
            pointsText.y -= 6;
            pointsText.textColor = c;
            multiplierText.x += animateLeft ? -7 : 7;
            multiplierText.y -= 6;
            multiplierText.textColor = c;
            if (multiplierText.y < 0) {
                resetPositions();
                return false;
            }
            return true;
        }
        return false;
    }

    public void draw() {
        if (!animate() && !activePlayer.getArrow().isMoving()) return;

        if (activePlayer.getRoundPoints() > 0) pointsText.setContent(activePlayer.getRoundPoints());
        DecimalFormat df = new DecimalFormat("0.00");
        multiplierText.setContent("x"+df.format(activePlayer.getMultiplier()));

        resetMatrix();


        pointsText.draw();
        multiplierText.draw();


        resetMatrix();
        camera.apply();

    }
}
