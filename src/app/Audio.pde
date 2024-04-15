class Audio {
    SoundFile wind;
    SoundFile fire;
    SoundFile hit;
    SoundFile button;
    SoundFile mainPage;
    SoundFile success;
    SoundFile scream;
    boolean start = false;
    boolean stop = false;
    float vol = 0;
    float currentVolume = 0.05;
    float transitionSpeed = 0.01;


    Audio(PApplet app) {
        wind = new SoundFile(app, ASSETS_PATH+"wind.wav");
        fire = new SoundFile(app, ASSETS_PATH+"fire.mp3");
        hit = new SoundFile(app, ASSETS_PATH+"hit.wav");
        button= new SoundFile(app, ASSETS_PATH+"button.mp3");
        mainPage= new SoundFile(app, ASSETS_PATH+"mainPage.mp3");
        success= new SoundFile(app, ASSETS_PATH+"success.mp3");
        scream= new SoundFile(app, ASSETS_PATH+"scream.mp3");
        
    }

    void playWind() {
        vol = 0;
        start = true;
        wind.play();
    }

    void stopWind() {
        stop = true;
    }

    void playmainPage() {
        mainPage.loop();
        mainPage.amp(0.05);
    }

    void stopmainPage() {
        mainPage.stop();
    }

    void playFire() {
        fire.play();
        fire.amp(0.25);
    }

    void playHit() {
        hit.play();
        hit.amp(0.1);
    }

    void playButton(){
        button.play();
        button.amp(0.2);
    }

    void playSuccess(){
        success.play();
        success.amp(0.3);
    }

    void playScream(){
        scream.play();
        scream.amp(0.4);
    }

    void render() {
        if (start) {
            vol += 0.01;
            if (vol >= 0.3) {
                start = false;
                return;
            }
            wind.amp(vol);
        }
        else if (stop) {
            vol -= 0.1;
            if (vol <= 0) {
                stop = false;
                wind.stop();
                return;
            }
            wind.amp(vol);
        }
    }
}
