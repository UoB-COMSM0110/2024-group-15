# bowman prototype


## setup
* Add processing library as a jar (File -> Project Structure -> Libraries -> Plus icon -> Add the processing jar (located inside the processing app, named `core.jar`)
* you might need to set the `src` folder as a source folder to run `App`



## notes

* Everything is ran from the `App` class. Other classes (usually instantiated from App) will have access to a pointer of App (so they can call things like `app.rect`, `app.image` etc.)

* `resetMatrix` is used when drawing GUI (something which you don't want to be affected by the camera)

* `pushStyle/pullStyle` is useful when you want an object to have a different style, but don't want to affect any other objects

* I don't know if you guys have come across HashMaps/Dictionaries, but they are basically keypairs and are quite useful and are used in the App class