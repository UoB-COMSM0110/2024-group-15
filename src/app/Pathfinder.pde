public class Pathfinder extends Entity {
	 Pathfinder(float x, float y, PVector velocity) {
        super(x, y, 0, 0, velocity);
        velocity.mult(0.1F);
    }

    void draw() {
        //save locations
        ArrayList<Float> locationX = new ArrayList<>();
        ArrayList<Float> locationY = new ArrayList<>();
        float initialX = x;
        float initialY = y;
        int numberOfMovements = 200;
        for(int i = 0; i < numberOfMovements; i++){
            if(dist(x, y, initialX, initialY) < 200){
                locationX.add(x);
                locationY.add(y);
            } else {
                break;
            }
            move();
        }

        for (int i=0; i<locationX.size(); i++) {
        	
            ellipse(locationX.get(i), locationY.get(i), 10, 10);
        }

        // for (int i=0; i<200; i++) {
        // 	move();
        //     ellipse(x, y, 10, 10);
        // }
    }

    
}
