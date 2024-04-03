public class Pathfinder extends Entity {
    ArrayList<Float> locationX;
    ArrayList<Float> locationY;
    float initialX;
    float initialY;
    float maxLengthOfPathfinder = screenWidth/2;
    
	 Pathfinder(float x, float y, PVector velocity) {
        super(x, y, 0, 0, velocity);
        velocity.mult(0.1F);
        initialX = x;
        initialY = y;
        locationX = new ArrayList<>();
        locationY = new ArrayList<>();
        locationX.add(x);
        locationY.add(y);
    }

    void getLocations(){
        //save locations
        // int numberOfMovements = 200;
        // float lengthOfPathfinder = maxLengthOfPathfinder;
        // while(maxLengthOfPathfinder > 0 && numberOfMovements > 0){
        //     move();
        //     lengthOfPathfinder -= dist(locationX.get(locationX.size() - 1), 
        //                                 locationY.get(locationY.size() - 1),
        //                                 x,
        //                                 y);
        //     locationX.add(x);
        //     locationY.add(y);
        //     numberOfMovements--;
        // }
        int numberOfMovements = 200;
        for(int i = 0; i < numberOfMovements; i++){
            move();
            if(dist(x, y, initialX, initialY) < maxLengthOfPathfinder){
                locationX.add(x);
                locationY.add(y);
            } else {
                break;
            }
            
        }
    }

    void draw() {

        getLocations();

        for (int i=0; i<locationX.size(); i++) {	
            ellipse(locationX.get(i), locationY.get(i), 10, 10);
        }

        // for (int i=0; i<200; i++) {
        // 	move();
        //     ellipse(x, y, 10, 10);
        // }
    }

    
}
