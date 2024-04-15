class Audio {
    SoundFile wind;
    SoundFile fire;
    SoundFile hit;
    boolean start = false;
    boolean stop = false;
    float vol = 0;


    Audio(PApplet app) {
        wind = new SoundFile(app, ASSETS_PATH+"wind.wav");
        fire = new SoundFile(app, ASSETS_PATH+"fire.mp3");
        hit = new SoundFile(app, ASSETS_PATH+"hit.wav");
    }

    void playWind() {
        vol = 0;
        start = true;
        wind.play();
    }

    void stopWind() {
        stop = true;
    }

    void playFire() {
        fire.play();
        fire.amp(0.25);
    }

    void playHit() {
        hit.play();
        hit.amp(0.1);
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