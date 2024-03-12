

class Planet extends Obj {
    float mass;
    float r;
    PImage  sprite;

    Planet(int x, int y, int mass) {
        super(x, y);
        this.mass = mass;
        this.r = mass/10F;
        //this.sprite=imgs.get("planet1");

/*
        imageMode(CENTER);
        image(sprite, 0, 0, realWidth, realHeight);
*/
    }

    Planet(int x, int y, int mass, int radius) {
        this(x, y, mass);
        this.r = radius;
        //this.sprite=imgs.get("planet2");
    }
    Planet(int x, int y, int mass, boolean imageflag) {
    super(x, y);
    this.mass = mass;
    this.r = mass/10F;
    if(imageflag==true){
      //sprite is null? why??
      sprite = imgs.get("planet1");
    }else if(imageflag==false){
        this.sprite=imgs.get("planet2");
    }

}


    void move() { }
    
    //image for the planet.
    void draw() {
        fill(0, 255, 0);
if (sprite != null) {
            // Check if sprite is not null before using it
            imageMode(CENTER);
            image(this.sprite, x, y, r * 2, r * 2);
    } else {
            // Handle the case when sprite is null (e.g., display a placeholder)
            fill(255, 0, 0); // Red color as a placeholder
            ellipse(x, y, r * 2, r * 2);
        }
    }
   

    public boolean isCollidingWith(Obj obj)
    {
        float dxsq = (obj.getX()-x)*(obj.getX()-x);
        float dysq = (obj.getY()-y)*(obj.getY()-y);

        double distance = Math.sqrt(dxsq + dysq);

        if (distance < r + (obj.objWidth)/2 - 5) {
            return true;
        }
        return false;
    }

    // Calculate gravitational force exerted by the planet on an object (maths which no one understands)
    PVector calculateGravity(Obj obj) {
        float G = 0.1F;
        PVector direction = new PVector(x-obj.x, y-obj.y);

        float distance = direction.mag();

        distance = constrain(distance, 5, 25);

        float objectMass = 1F;
        float forceMagnitude = (G * mass * objectMass) / (distance * distance);

        direction.normalize();
        direction.mult(forceMagnitude);

        return direction;
    }
}
