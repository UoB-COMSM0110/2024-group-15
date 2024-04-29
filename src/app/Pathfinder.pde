public class Pathfinder extends Entity {
    ArrayList<Float> locationX;
    ArrayList<Float> locationY;
    float initialX;
    float initialY;
    float maxLengthOfPathfinder = width/2;
    
	 Pathfinder(float x, float y, PVector velocity) {
        super(x, y, 0, 0, velocity);
        velocity.mult(0.1F);
        initialX = x;
        initialY = y;
        locationX = new ArrayList<>();
        locationY = new ArrayList<>();
    }

    void getLocations(){
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
        pushStyle();
        fill(255);

        for (int i=0; i<locationX.size(); i++) {	
            ellipse(locationX.get(i), locationY.get(i), 10, 10);
        }

        popStyle();
    }
}
