public class Pathfinder extends Entity {
	 Pathfinder(float x, float y, PVector velocity) {
        super(x, y, 0, 0, velocity);
        velocity.mult(0.1F);
    }

    void draw() {
        for (int i=0; i<200; i++) {
        	move();
            ellipse(x, y, 10, 10);
        }
    }
}