public class Bow extends Entity {
    PImage sprite;
    Bow(float x, float y){
        super(x, y);
        sprite = imgs.get("bow");
        float scale = 1.05;
        setDimensions(sprite.width*scale, sprite.height*scale);
    }
    public void draw(){

    }
}
