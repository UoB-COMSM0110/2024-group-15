

class PlayerMover {
    Player player;
    Planet planet;
    boolean isMoving;

    float targetAngle;
    boolean animationStarted = false;
    float angle;

    PlayerMover() { }

    void startMove(Player p) {
        isMoving = true;
        this.player = p;
        this.planet = p.planet;
    }

    void draw() {
        if (!isMoving) return;
        if (animationStarted) {
            player.movePlayerOnPlanet(lerp(player.planetAngle, targetAngle, 0.04));
            println(player.planetAngle);
            if (Math.abs(player.planetAngle-targetAngle) < 1) {
                animationStarted = false;
                isMoving = false;
            }
            return;
        }
        pushStyle();
        noFill();
        stroke(255);
        strokeWeight(6);
        ellipse(planet.x, planet.y, planet.r*2 + 20, planet.r*2 + 20);

        if (!mouseIsOverSelector()) {
            popStyle();
            return;
        }

        float realMouseX = camera.getRealMouseX();
        float realMouseY = camera.getRealMouseY();

        angle = atan2(realMouseY - planet.y, realMouseX - planet.x);
        float x = planet.x + cos(angle) * (planet.r+10);
        float y = planet.y + sin(angle) * (planet.r+10);
        ellipse(x, y, 10, 10);
        popStyle();
    }

    boolean handleClick() {
        if (!isMoving || !mouseIsOverSelector()) return false;
        float clockwiseDistance = radians(player.planetAngle)-angle;
        float counterclockwiseDistance = 2 * PI - clockwiseDistance;

        targetAngle = degrees(angle);
        updatePlayerHitBox(targetAngle);
        if (clockwiseDistance > counterclockwiseDistance) {
            targetAngle += 360;
        }
        animationStarted = true;
        return true;
    }

    private boolean mouseIsOverSelector() {
        float realMouseX = camera.getRealMouseX();
        float realMouseY = camera.getRealMouseY();
        float distanceToCenter = sqrt(pow(realMouseX - planet.x, 2) + pow(realMouseY - planet.y, 2));
        return distanceToCenter <= planet.r+40;
    }


    private void updatePlayerHitBox(float angle) {
        if (angle > -135 && angle <= -45) {
            // player.hitboxWidth =
            // player.hitBoxHeight =
        } else if (angle > -45 && angle >= 45 ) {

        } else if (angle > 45 && angle >= 135 ) {

        } else if (angle > 135 && angle >=  123) {

        } else if (angle > 135 || angle <= -135) {

        }
    }
}