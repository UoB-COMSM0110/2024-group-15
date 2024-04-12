

class PlayerMover {
    Player player;
    Planet planet;
    boolean isMoving;
    boolean selecting;

    float targetAngle;
    boolean animationStarted = false;
    float angle;

    PlayerMover() { }

    void startMove(Player p) {
        isMoving = true;
        this.player = p;
        this.planet = p.planet;
        selecting = true;
    }

    void draw() {
        if (!isMoving) return;
        if (animationStarted) {
            player.movePlayerOnPlanet(lerp(player.planetAngle, targetAngle, 0.04));
            camera.animateCenterOnObject(player, 0);
            camera.cameraIsMoving = false;
            if (Math.abs(player.planetAngle-targetAngle) < 1) {
                animationStarted = false;
                isMoving = false;
                if (tutorialActive) {
                    tutorial.nextMessage();
                    gameMenu.open();
                    gameMenu.playerMoveButton.hide();
                }
            }
            return;
        }
        pushStyle();
        noFill();
        stroke(255);
        strokeWeight(4);
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
        // updatePlayerHitBox(targetAngle);
        if (clockwiseDistance > counterclockwiseDistance) {
            targetAngle += 360;
        }
        animationStarted = true;
        selecting = false;
        return true;
    }

    private boolean mouseIsOverSelector() {
        float realMouseX = camera.getRealMouseX();
        float realMouseY = camera.getRealMouseY();
        float distanceToCenter = sqrt(pow(realMouseX - planet.x, 2) + pow(realMouseY - planet.y, 2));
        return distanceToCenter <= planet.r+40;
    }
}
