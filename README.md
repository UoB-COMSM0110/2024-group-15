# Software Engineering - Group 15

![](assets/readme/Title.png)

<p align="center">
  <a href = "https://youtu.be/Z4eMyTQEbB0">
Click here for our game video
  </a>
</p>



<details>
  <summary>Table of Contents</summary>

- <a href="#1">Team</a>
- <a href="#2">Introduction</a>
- <a href="#3">Requirements</a> 
  - <a href="#4">Ideation Process</a> 
  - <a href="#5">User Stories</a> 
  - <a href="#6">Use-case Diagram</a> 
  - <a href="#7">Use-case Specifications</a> 
  - <a href="#8">Early Stage Design</a> 
    - <a href="#9">Core Gameplay</a> 
    - <a href="#10">Obstacles</a> 
    - <a href="#11">Idea List</a> 
- <a href="#12">Design</a> 
  - <a href="#13">Class Diagram</a> 
  - <a href="#14">Communication Diagram</a> 
  - <a href="#15">Design Conclusion</a> 
- <a href="#16">Implementation</a> 
  - <a href="#17">Camera Movement</a> 
  - <a href="#18">Physics Engine</a> 
  - <a href="#19">Gameplay Additions</a> 
- <a href="#20">Evaluation</a> 
  - <a href="#21">Qualitative Analysis</a> 
    - <a href="#22">Stage 1: Heuristic Analysis</a> 
    - <a href="#23">Stage 2: Heuristic Analysis</a> 
  - <a href="#24">Quantitative Analysis</a> 
    - <a href="#25">Stage 1</a> 
    - <a href="#26">Stage 2 </a>
  - <a href="#27">Unit Testing</a> 
- <a href="#28">Process</a> 
  - <a href="#29">Teamwork</a> 
  - <a href="#30">Collaboration Tools and Techniques</a> 
  - <a href="#31">Role Distribution</a> 
- <a href="#32">Conclusion</a> 
- <a href="#33">Individual contribution</a>
  
</details>

<h2 id = "1">Team</h2>

Yining Xu, Li-Hshin Chien, Ada Liang, Louis Nutt-Wilson, Xinyu Hu

![](assets/Group%20Photo.png)
![](assets/readme/comic.png)

<h2 id = "2">Introduction</h2>

Our game is a two-player game based on a flash game named *Bowman*.
Originally, the game-play is that players drag the mouse to pull back the bow and shoot each other, then a camera will follow the arrow to check whether you have shot the target.

We've transformed the game into a space-themed version as out twist in game-play by introducing a gravity engine to calculate gravity between planets as well as points collected system and further shop system to trade for skills like *Pathfinder*. The point collection is calculated by arrow rotation count linked to the gravity after it hit somebody, we also have punishments of losing two hearts after the player hit himself.

Additionally, the players can also move around the planet for a better position, whether to hide or move for a better shot. So in each person's turn, he would have to choose between "move" and "shop" before fire, this adds to gameplay strategy.

Also we have implemented two difficulty levels, for "easy mode", the two players can easily see each other's position, while the "difficult mode" don't. Through evalution, there are significant differences in player performance and mental preparation between these two difficulty levels.

During the whole process, we have put many software engineering techniques into practice, including user-case diagrams, class diagrams and communication diagrams in the early design and ideation stage, and Agile workflow and Kanban board were used throughout the developing process, Github is also used for working branches and version control. Better comprehension of software engineering is gained after the group work.

<h2 id = "3">Requirements</h2>

<h3 id = "4">Ideation Process</h3>

We have two game ideas at the beginning proposed by two of our team members, which are the two-player bowman game with camera movement and gravity physical engine, and an RPG-like two-player game with storyline, interactions with the environment and boss fights.

Our team used paper prototype to mock the outline of these two game's workflow in class to grasp concepts of each. Soon after the mock and discussions, we collectively decided to pursue the *Bowman* game due to its more specified enhancement and requirements, and its solid gameplay foundation.

[![](./assets/thumbnails/Game2_pic.png)](https://drive.google.com/file/d/1X9CZkVwlnULj-P8qy6iIerfCmLlt9J-E/view?usp=sharing )

<h3 id = "5">User Stories</h3>

>"As a player, I want to have personalised choices at the start of the game so that I can choose the game's difficulty based on my preferences."  
>"As a player, I want to gain resources through some special behaviours in the game, and these resources can be able to trade for special skills, so it is a bit more fun."  
>"As a player, I want to know the force and the direction of my arrow, so I need a sign to acknowledge that."  
>"As a second player, I want to be able to play the game with my friends, so that I can have fun with two players other than play against the computer."  
>"As a player, I want to have cases or tutorial examples telling me some of special designs of the game."  
>"As a player, I want a skip function to skip the animation, so that I can get the result immediately."  
>"As a marker for this project, I want to see groups create engaging and well made games, with a strong process of development that utilises the techniques taught in this module."  
>"As a future group for this module, we want to see good examples of games which will inspire us when creating our own game."  

<h3 id = "6">Use-case diagram</h3>

![Diagram Image](assets/game-idea-imgs/Diagram%202024-02-19%2004-26-53.png)

<h3 id = "7">Use-case specifications</h3>



*Easy Mode*


| Use-Case Section     | vs Human                                                                                                                                                                    | vs Computer                                                                                                                                                                                                                                                                  |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Description**      | A run through of the game on easy mode                                                                                                                                      | A run-through of the game on easy mode, against a computer                                                                                                                                                                                                                   |
| **Basic Flow**       | Two players compete to get a higher score to win the game with no one losing all of his health points.                                                                      | The player and the computer compete to get a higher score to win the game, with neither losing all of their health points.                                                                                                                                                   |
| 1.                   | Each user presses the left mouse button, drags the mouse to determine the strength and direction, and releases the mouse to shoot. Each player can take one shot each turn. | The player presses the left mouse button, drags the mouse to determine the strength and direction, and releases the mouse to shoot. The player and the computer can take one shot each turn. The actions of the computer in these aspects are automated.                     |
| 2.                   | The user who is shot will lose his health points.                                                                                                                           | The player and the computer lose health points when shot.                                                                                                                                                                                                                    |
| 3.                   | The users can collect weapons and skills by shooting the stars.                                                                                                             | The player can collect weapons and skills by shooting the stars, while the computer's actions are automated.                                                                                                                                                                 |
| 4.                   | The users can adjust their position by pressing A and D.                                                                                                                    | The player can adjust position by pressing A and D, and the computer will automatically make adjustment of its position.                                                                                                                                                     |
| 5.                   | The number of rounds will decrease after each user takes a shot.                                                                                                            | The number of rounds will decrease after each side takes a shot.                                                                                                                                                                                                             |
| 6.                   | The number of rounds decrease to 0 and the result is shown with the option to try again.                                                                                    | The number of rounds decrease to 0 and the result is shown with the option to try again.                                                                                                                                                                                     |
| **Alternative Flow** |                                                                                                                                                                             |                                                                                                                                                                                                                                                                              |
| 1.                   | Each user presses the left mouse button, drags the mouse to determine the strength and direction, and releases the mouse to shoot. Each player can take one shot each turn. | The player presses the left mouse button, drags the mouse to determine the strength and direction, and releases the mouse to shoot. The actions of artificial intelligence in these areas are automated. The player and artificial intelligence can take one shot each turn. |
| 2.                   | The user who is shot will lose his health point.                                                                                                                            | The player and the computer lose health points when shot.                                                                                                                                                                                                                    |
| 3.                   | The users can collect weapons and skills by shooting the stars.                                                                                                             | The player can collect weapons and skills by shooting the stars, while the computer's actions are automated.                                                                                                                                                                 |
| 4.                   | The users can adjust their position by pressing A and D.                                                                                                                    | The player can adjust position by pressing A and D, and the computer will automatically make adjustment of its position.                                                                                                                                                     |
| 5.                   | The number of rounds will decrease after each user takes a shot.                                                                                                            | The number of rounds will decrease after each side takes a shot.                                                                                                                                                                                                             |
| 6.                   | The user has lost all of his health points within 10 rounds and the result is shown with the option to try again.                                                           | The player has lost all of the health points within 10 rounds and the result is shown with the option to try again.                                                                                                                                                          |

*Difficult Mode*


| Use-Case Section     | vs Human                                                                                                        | vs Computer                                                                                                     |
| -------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Description**      | A run through of the game on hard mode                                                                          | 1 player run through of the game on hard mode, against a computer                                               |
| **Basic Flow**       | Shoot your opponent until his/her HP becomes zero                                                               | Shoot the computer until its HP becomes zero, or your own becomes zero                                          |
| 1.                   | Players can choose their own planet, each planet has different gravity                                          | Players can choose their own planet, each planet has different gravity                                          |
| 2.                   | LEFT-CLICK and drag the mouse to control throwing power and angle (User can choose to hit the star or opponent) | LEFT-CLICK and drag the mouse to control throwing power and angle (User can choose to hit the star or opponent) |
| 3.                   | May appear strong wind and change the trajectory of the arrow                                                   | May appear strong wind and change the trajectory of the arrow                                                   |
| 4.                   | Hit opponent, their HP will be reduced [A1, A2, A3]                                                             | Hit opponent, their HP will be reduced [A1, A2, A3]                                                             |
| 5.                   | Change sides                                                                                                    | Change sides, computer will take their turn                                                                     |
|                      |                                                                                                                 |                                                                                                                 |
| **Alternative Flow** |                                                                                                                 |                                                                                                                 |
| A1                   | 1. Hit a star, skill points will increase                                                                       |                                                                                                                 |
|                      | 2. Back to Basic Flow 5.                                                                                        |                                                                                                                 |
| A2                   | 1. Hit a star, star becomes black hole                                                                          |                                                                                                                 |
|                      | 2. No skill points will be added                                                                                |                                                                                                                 |
|                      | 3. Back to Basic Flow 5.                                                                                        |                                                                                                                 |
| A3                   | 1. Hit the ground                                                                                               |                                                                                                                 |
|                      | 2. The ground breaks                                                                                            |                                                                                                                 |
|                      | 3. Back to Basic Flow 5.                                                                                        |                                                                                                                 |




<h2 id = "12">Design</h2>

<h3 id = "8">Early Stage Design</h3>

We sat down and brainstormed about additional content ideas beyond the original concept, as well as any potential problems that might arise during the game development progress.

Then we discussed about what to implement and used Kanban Board to assign tasks and track the progress of our work and timely updated information in our chat group.

<h4 id = "9">Core Gameplay</h4>

The core game flow will be, the game starts and players can choose from whether this is "VS Computer" mode or "VS Human" mode, and self-defined the rounds and HP that each player should have.

Users' input mainly comes from mouse move and click, including aiming, selecting in the shops and so on. So when it becomes this player's turn:

1. The player will select from *Move* and *Shop*. *Move* will allow the player to move around the whole planet, and *Shop* will provide skills like *pathfinder*, *double strike* for the player to select. 

2. After that, the player clicks and drags the mouse to control the bow's tension and direction, and then releases the mouse to fire. The camera will then focus on the arrow until it shot on any bounding shape.

Additionally, we want to introduce a points collection system to incorporate a shop system where players can buy some skills. How gravity works was also being discussed. There are proposals like whether to do a half and half screen where one side has negative gravity or use the escape velocity formula for planets, we chose the latter eventually.

<h4 id = "10">Obstacles</h4>

The first obstacle that might occur is the gravity calculation methods that involve physics. So we should take a look into the escape velocity formula for planets, luckily we only have two planets and one object to model.

Another barrier is the camera zoom in or zoom out function. The core design is that the other player's position is invisible in this player's turn. So the camera should keep this player at the center of the screen and move follows the arrow after firing.

<h4 id = "11">Idea List</h4>

After putting all the designs and concerns on the table, we wrote an idea list to guide the step-by-step development of the whole game.

The highest priority tasks include implementing the physics engine to calculate gravity and 2D bounding collision detection, and the camera movements as well. Then we will add the shop system, the HP detection, tutorials and any other things.

<h3 id = "13">Class diagram</h3>

We use the class diagram to help us understand the structures of the system at the very first stage. During the later development process, some methods and classes might be added or deleted but the main idea remains until the final stage.

We defined the *App* class as the main class that initialises and it is constantly being called and updated during the whole game process. Also, we used the *Obj* class as the parent class of *Arrow*, *Pathfinder*, *Planet*, *Player* and so on as they share the same position at some point.

The game end and reset is linked to the health in *Player*, after the player's health becomes zero, a reset game page will appear and allow players to choose from restart or exit.


 ![](assets/game-idea-imgs/file.png)

<h3 id = "14">Modelling behaviour: Communication diagram</h3>

To clarify the relationships between the classes of the system, we use the communication diagram to help us specify the interactions between classes. This diagram has given us more detailed insights into how classes communicate.

Normally, after the mouse drag and release, the *Aimer* will update the tension and direction to *Arrow*, then the *Camera* will move to follow wherever the arrow goes. Also, the position and movement of the arrow will update the *Planet* to calculate the gravity of the arrow to define its movement in the next frame. Ultimately all the information will be updated in the *App*, the main class, to pursue any further movements.

![](assets/game-idea-imgs/CD.png)

<h3 id = "15">Design Conclusion</h3>

Although the final product might be slightly different from our original design, we still find it really useful to introduce these two diagrams to help us understand the relationships and interactions of the entire system.

Furthermore, these design prototypes help us to focus on one function to implement, one class to code at a time, greatly simplifying the progress of coding and debugging in later development.

<h2 id = "16">Implementation</h2>

There were three challenges that we highlighted before the development stage:
1. Create a camera with functions of centering on specific objects.
2. Implement physics engine of gravity calculation and collision detection.
3. Add extra systems of points collection to trade for special skills in a shop system.

During the implementation process, we have also added animations, sound effects, dynamic background and user-specified name functions to further enhance users' experiences.


<h3 id = "17">1. Camera movement:</h3>
  
In bowman and raft wars, the camera moves with the projectile so the shooting player cannot see exactly where they need to hit.

To display the whole scene when entering the game to let the players know the approximate position of each other, just set the camera at the center of the two randomly-generated planets' positions. Then the camera will apply to the player's center position.

To place the player at the center of the screen in this person's turn, we used the status to track if the arrow is fired or not, if it is, the camera will update with the position of the arrow until the collision detection is true.

We also implemented zoom functions to dynamically adjust the camera's scale based on the game status using stack to push and pop zoom scale which allows the camera to switch from any game status. We also used *Linear Interpolation* and frames related functions to make the camera's movements smoother.

As bunded with the camera movements after firing, we added texts to display the distance that the arrow has flown and magnification related to the points system.

<p align="center">
	<img width="60%" src="assets/readme/camera.gif">
	<br />
	<em>Camera's movements during the game</em>
</p>

<h3 id = "18">2. Physics engine:</h3>

Gravity mechanics would need to be implemented for this idea (as it is set in space) and the balance between realism and difficulty would need to be found. Also, we need to set hit boxes to detect collision and change further status.

We used the *PVector* (a built-in class in Processing to handle operations on 2D and 3D dimensions' vectors) to handle the vector. In the *Planet* class the *Law of Universal Gravitation* is used to calculate the gravity vector of the arrow (with constraints avoiding any extreme situations), then update the acceleration of each planet and added it to the current velocity to modify any further movement of the arrow in the *Entity* class.

As for collision detection, we used self-defined hitboxes of planets, players and arrows and calculated the distance among objects to detect any collision.

<p align="center">
	<img width="60%" src="assets/readme/engine.gif">
	<br />
	<em>The demonstration of gravity calculation and collistion detection</em>
</p>

<h3 id = "19">3. Gameplay additions:</h3>

After the basic implementation we improved our game by adding extra content mentioned below:

1. Shops:  
 
Initially, we made a pathfinder for debugging which provides a dotted curve line of the arrow's detected movements. It stored every X and Y position at the maximum of 200 with pre-calculation of its movements with current velocity, mouse-controlled force and gravity vector of each planet, and printed them out with dots.

Moreover, we further broadened the shop system by adding "Health Potion", "Double Strike", "Hit and Skip" functions and its detailed messages. These functions related to players' turn and HP bar so it's quite easy to implement.

1. Points System:
  
At the outset, we used the arrow numbers on planets as "points" to trade for skills in the shop.
Then we thought about linking the magnification to the rotation of the arrow and multiple it to a score when the arrow hit the other player.

To implement this, we defined the *rotationAmount* in the *Arrow* Class, and updated the absolute value of the current degree minus the previous angle. Then we used the amount to calculate the magnification and updated it in every frame of the arrow's movements.

Additionally, we added the *PointsSplash* to add visual effects. It will have an animation to the right or left if the arrow is detected collision on players and adds to the current points, and move down if the arrow fails to hit anyone. This is implemented by setting the positions of magnificationText and pointsText.

3. Moving around the planets:

The *PlayerMover* class is added to let the player move around the planet. By clicking on the circular area with the same radius as the planet, we can then calculate the angle between the current and selected positions based on the mouse click.
Then the angle is used for animating the player's movement to the selected position.

<p align="center">
	<img width="60%" src="assets/readme/additions.gif">
	<br />
	<em>Player's move, points collection and shop system</em>
</p>

4. Tutorials:

During the first heuristic analysis we have received complaints about being confused about operations so we thought about adding some tutorial contents.

At first, we managed to add a tutorial content that is shown all the way during the gameplay at the left-down side of the screen.

Then we extended the tutorial mode at the game main page. An Arraylist was used to store all the tutorial messages and each box was selected and printed to inform the player what to do, and we created a class named *GUI* to draw any GUI-related contents on the screen.

<p align="center">
	<img width="60%" src="assets/readme/tutorials.gif">
	<br />
	<em>Tutorial demonstration</em>
</p>

<h2 id = "20">Evaluation</h2>

We segmented this section into two components: **Qualitative Analysis** and **Quantitative Analysis**. Employing these analyses throughout our development phase facilitated the identification and resolution of various issues such as user interface, user experience, and game logic.


<h3 id = "21">1. Qualitative Analysis</h3>

For this section, Heuristic Analysis was selected as the evaluation method. The analysis was conducted in two stages: Stage 1, during the early development phase, and Stage 2, during the later development stage following Easter. The dual-stage approach was implemented to capture shortcomings and subsequent improvements throughout the process.


<h4 id = "22">Stage 1: Heuristic Analysis (11/03/24)</h4>


| Interface        | Issue                                              | Heuristic(s) | Frequency (0-4) | Impact (0-4, easy-difficult) | Persistence (0-4, once-repeated) | Severity=AVG(Freq+Impact+Persistence) |
| ---------------- | -------------------------------------------------- | ------------ | --------------- | ---------------------------- | -------------------------------- | ------------------------------------- |
| UI               | visually unclear                                   | 1, 3, 10     | 4               | 3                            | 4                                | 3.66                                  |
| Game Logic (App) | game flow is unclear                               | 1, 3, 10     | 3               | 3                            | 1 (when learning)                | 2.33                                  |
| Arrow (Obj)      | arrow hitbox glitches sometimes                    | 2, 7         | 2               | 3                            | 2                                | 2.33                                  |
| Camera           | camera movement with arrow keys doesn't make sense | 4            | 1               | 4                            | 1                                | 2                                     |

In our early development stage, we identified the visual clarity of the user interface as the most prominent issue. This included a lack of indication for Player 1 and Player 2, unclear instructions on gameplay, and the absence of a start page and navigation page essential for a comprehensive gaming experience. 

Additionally, the unclearness in the game flow emerged as another significant issue. Players often get lost when learning how to play the game and the main cause of the issue is related to the UI design problem mentioned above. Both issues violated the principle of *visibility of system status*, *user control and freedom* and *help and documentation* in Heuristics Evaluation.

Moreover, issues with arrow mechanics and camera functionality also impacted usability. Arrows occasionally passed through players without inflicting damage, indicating glitches in the arrow hitbox, categorized under the principles of match between system and real world and flexibility and efficiency of use. Additionally, the camera movement via arrow keys was unnecessary. In our initial design, the random positioning of planets in each game meant that players might not always see their opponent. Allowing users to control the camera with arrow keys violated the principle of *consistency and standards*, as it disrupted established norms within the game environment.




<h4 id = "23">Stage 2: Heuristic Analysis (19/04/24)</h4>

| Interface  | Issue                                        | Heuristic(s) | Frequency (0-4) | Impact (0-4, easy-difficult) | Persistence (0-4, once-repeated) | Severity=AVG(Freq+Impact+Persistence) |
| ---------- | -------------------------------------------- | ------------ | --------------- | ---------------------------- | -------------------------------- | ------------------------------------- |
| Game Logic | cannot skip tutorial or exit during the game | 1, 3         | 1               | 1                            | 4                                | 2                                     |


During stage 1 and stage 2, we have solved all the issues occurred in stage 1 table. After the second Heuristic Analysis, one more issue related to game logic was found. During the game or tutorial, the system didn't provide any skip or exit button, which broke the principle of *visibility of system status* and *user control and freedom*. Given the relatively low severity, we intend to address the improvement of this issue in future work.

Overall, our experience with Heuristic Analysis proved invaluable to the development process. After pinpointing issues within the game, this method provided a comprehensive evaluation of usability, allowing us to concentrate our efforts on specific principles for improvement. Moreover, the severity indication, determined by frequency, impact, and persistence, enabled us to prioritize issues effectively, addressing those with the highest importance promptly.



<h3 id = "24">2. Quantitative Analysis</h3>

**NASA TLX** and **System Usablility Scale (SUS)** were conducted in this part. Each analysis was divided into two stages. For the NASA TLX, both the easy mode and hard mode were individually tested in each stage of development. However, for the SUS, we conducted only one test in each stage since there was minimal difference in the user interface between the two modes.

NASA TLX is a multi-dimensional rating tool used to measure the workload a person experienced when performing a task. On the other hand, SUS is a reliable tool used to measure usability.

In stage 1, the main difference between easy mode and hard mode is whether the *pathfinder* is opened. As for stage 2, we adjust the distance between two planets, easy mode would be closer and hard mode would be farther. In essence, this setting prevents players from seeing each other when playing in hard mode.



<h4 id = "25">Stage 1 (18/03/24)</h4>

**1. NASA TLX**

   * Easy mode
      > *Scores*
        >| Participant Number | Mental demand | Physical demand | Temporal demand | Performance | Effort | Frustration |
        >| ----------- | ------- | ------- | ------- | ------- | ------- | ------- |
        >| 1 | 60 | 40 | 20 | 70 | 75 | 25 |
        >| 2 | 60 | 0 | 0 | 100 | 60 | 80 |
        >| 3 | 75 | 25 | 10 | 90 | 60 | 75 |
        >| 4 | 65 | 25 | 40 | 75 | 50 | 60 |
        >| 5 | 50 | 20 | 25 | 0 | 0 | 0 |
        >| 6 | 50 | 25 | 5 | 50 | 75 | 35 |
        >| 7 | 50 | 50 | 15 | 60 | 65 | 50 |
        >| 8 | 55 | 30 | 15 | 50 | 60 | 25 |
        >| 9 | 60 | 40 | 10 | 65 | 70 | 30 |
        >| 10 | 50 | 30 | 20 | 50 | 20 | 35 |
        >
      > *Final Scores*
        >| Participant Number | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
        >| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
        >| score | 48 | 50 | 56 | 53 | 16 | 40 | 48 | 39 | 46 | 34 |
        >

   * Hard mode
     > *Scores*  
        >| Participant Number | Mental demand | Physical demand | Temporal demand | Performance | Effort | Frustration |
        >| ----------- | ------- | ------- | ------- | ------- | ------- | ------- |
        >| 1 | 65 | 40 | 20 | 65 | 70 | 30 |
        >| 2 | 60 | 0 | 0 | 0 | 40 | 40 |
        >| 3 | 75 | 25 | 10 | 90 | 60 | 75 |
        >| 4 | 65 | 25 | 40 | 75 | 50 | 60 |
        >| 5 | 45 | 15 | 25 | 0 | 5 | 0 |
        >| 6 | 50 | 30 | 10 | 50 | 80 | 35 |
        >| 7 | 50 | 50 | 10 | 60 | 60 | 55 |
        >| 8 | 60 | 30 | 25 | 50 | 60 | 35 |
        >| 9 | 60 | 50 | 10 | 70 | 70 | 30 |
        >| 10 | 55 | 40 | 30 | 50 | 30 | 45 |
        >
      >
       > *Final Scores*
        >| Participant Number | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
        >| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
        >| score | 48 | 23 | 56 | 53 | 15 | 43 | 48 | 43 | 48 | 43 |
        >

> **Analysis between easy and hard mode**
> 
> During the game's development, we aimed to ensure users experienced noticeable differences between the easy and hard modes. To achieve this objective, we employed the Wilcoxon signed-rank test to determine whether the difference is significant or not. This tool allowed us to analyze the final scores of the NASA TLX in a rigorous and statistical manner.
>
> *Wilcoxon sign-ranked test*  
>Step 1: calculate the difference between NASA TLX score
  >| Easy Score | Hard Score | Difference (easy - hard)|
  >| ----- | ----- | ----- |
  >| 48 | 48 | 0 |
  >| 50 | 23 | 27 |
  >| 56 | 56 | 0 |
  >| 53 | 53 | 0 |
  >| 16 | 15 | 1 |
  >| 40 | 43 | -3 |
  >| 48 | 48 | 0 |
  >| 39 | 43 | -4 |
  >| 46 | 48 | -2 |
  >| 34 | 43 | -9 |
  >
>
>Step 2: sort and rank previous table by "difference"
  >| Rank |  Difference | Rank (after) |
  >| ---- | ---- | ---- |
  >| 1 | 0 | 2.5 |
  >| 2 | 0 | 2.5 |
  >| 3 | 0 | 2.5 |
  >| 4 | 0 | 2.5 |
  >| 5 | 1 | 5 |
  >| 6 | -2 | -6 |
  >| 7 | -3 | -7 |
  >| 8 | -4 | -8 |
  >| 9 | -9 | -9 |
  >| 10 | 27 | 10 |
  >
> The sum of the positive signed rank is 25 and the absolute sum of negative signed rank is 30. We selected the smaller one, 25, as our 'W' to compare with critical value. Next, 0.1 was chosen as the "Two-Sided Test &alpha;" value. Referring to the critical values table provided [here](https://sphweb.bumc.bu.edu/otlt/mph-modules/bs/bs704_nonparametric/BS704_Nonparametric6.html), our 'W' needed to be smaller than 11 to indicate a significant difference between the easy and hard modes. However, our 'W' was 25, which exceeded the threshold of 11. In essence, this suggests minimal difference between the easy and hard modes. Therefore, the outcome was not as anticipated, and we intend to address this in the next stage of development.

  

**2. SUS**

 > *Scores*
   >| Participant Number | like to use frequently | unnecessarily complex | easy to use | need technical support | functions well integrated | too much inconsistency | learn to use quickly | cumbersome to use | confident to use | need to learn a lot before using |
   >| ----------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |
   >| 1 | 4 | 1 | 4 | 2 | 5 | 1 | 4 | 1 | 4 | 1 |
   >| 2 | 2 | 1 | 3 | 1 | 5 | 1 | 3 | 1 | 3 | 1 |
   >| 3 | 3 | 5 | 2 | 5 | 4 | 2 | 2 | 4 | 1 | 3 |
   >| 4 | 3 | 4 | 2 | 4 | 4 | 3 | 4 | 3 | 2 | 2 |
   >| 5 | 5 | 1 | 5 | 2 | 5 | 1 | 4 | 1 | 5 | 1 |
   >| 6 | 5 | 1 | 5 | 1 | 5 | 1 | 3 | 1 | 3 | 3 |
   >| 7 | 3 | 1 | 1 | 2 | 5 | 1 | 4 | 1 | 4 | 2 |
   >| 8 | 2 | 4 | 2 | 5 | 2 | 3 | 2 | 4 | 4 | 4 |
   >| 9 | 3 | 3 | 1 | 2 | 3 | 3 | 2 | 4 | 4 | 3 |
   >| 10 | 1 | 3 | 2 | 4 | 3 | 2 | 4 | 3 | 3 | 4 |
   >
 > *Score contribution*
   >| Participant Number | like to use frequently | unnecessarily complex | easy to use | need technical support | functions well integrated | too much inconsistency | learn to use quickly | cumbersome to use | confident to use | need to learn a lot before using |
   >| ----------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |
   >| 1 | 3 | 4 | 3 | 3 | 4 | 4 | 3 | 4 | 3 | 4 |
   >| 2 | 1 | 4 | 2 | 4 | 4 | 4 | 2 | 4 | 2 | 4 |
   >| 3 | 2 | 0 | 1 | 0 | 3 | 3 | 1 | 1 | 0 | 2 |
   >| 4 | 2 | 1 | 1 | 1 | 3 | 2 | 3 | 2 | 1 | 3 |
   >| 5 | 4 | 4 | 4 | 3 | 4 | 4 | 3 | 4 | 4 | 4 |
   >| 6 | 4 | 4 | 4 | 4 | 4 | 4 | 2 | 4 | 2 | 2 |
   >| 7 | 2 | 4 | 0 | 3 | 4 | 4 | 3 | 4 | 3 | 3 |
   >| 8 | 1 | 1 | 1 | 0 | 1 | 2 | 1 | 1 | 3 | 1 |
   >| 9 | 2 | 2 | 0 | 3 | 2 | 2 | 1 | 1 | 3 | 2 |
   >| 10 | 0 | 2 | 1 | 1 | 2 | 3 | 3 | 2 | 2 | 1 |
   >
 > *Final Scores*
   >|  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | Avg. |
   >| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
   >| Score | 87.5 | 77.5 | 32.5 | 47.5 | 95 | 85 | 75 | 30 | 45 | 42.5 | 61.8
   >
 
 > **Analysis**
>  
 > Based on the five different SUS score interpretation methods outlined [here](https://measuringu.com/interpret-sus-score/), we opted for the "Adjective" method proposed by [Bangor et al](https://uxpajournal.org/determining-what-individual-sus-scores-mean-adding-an-adjective-rating-scale/). This approach categorizes SUS scores into seven adjective scales: worst imaginable, awful, poor, OK, good, excellent, and best imaginable. The SUS score of our system falls into the "OK" category. While this is an acceptable score for us, we would like to have further improvement in the next stage of development.
 
 

<h4 id = "26">Stage 2 (20/04/24)</h4>

**1. NASA TLX**

 * Easy mode
    > *Scores*
      >| Participant Number | Mental demand | Physical demand | Temporal demand | Performance | Effort | Frustration |
      >| ----------- | ------- | ------- | ------- | ------- | ------- | ------- |
      >| 1 | 35 | 25 | 15 | 55 | 45 | 40 |
      >| 2 | 55 | 20 | 15 | 60 | 50 | 35 |
      >| 3 | 50 | 0 | 45 | 60 | 75 | 25 |
      >| 4 | 25 | 30 | 30 | 40 | 25 | 20 |
      >| 5 | 30 | 15 | 30 | 65 | 50 | 40 |
      >| 6 | 50 | 30 | 15 | 60 | 70 | 45 |
      >| 7 | 55 | 40 | 50 | 65 | 50 | 50 |
      >| 8 | 20 | 25 | 35 | 50 | 50 | 45 |
      >| 9 | 30 | 35 | 20 | 35 | 40 | 25 |
      >| 10 | 60 | 55 | 70 | 75 | 75 | 70 |
      >
    > *Final Scores*
      >| Participant Number | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 
      >| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
      >| score | 36 | 39 | 43 | 28 | 38 | 45 | 52 | 38 | 31 | 68 |
      >

 * Hard mode
    > *Scores*
      >| Participant Number | Mental demand | Physical demand | Temporal demand | Performance | Effort | Frustration |
      >| ----------- | ------- | ------- | ------- | ------- | ------- | ------- |
      >| 1 | 65 | 25 | 15 | 65 | 70 | 60 |
      >| 2 | 50 | 20 | 25 | 40 | 60 | 50 |
      >| 3 | 75 | 10 | 75 | 60 | 100 | 50 |
      >| 4 | 30 | 45 | 35 | 40 | 40 | 35 |
      >| 5 | 50 | 40 | 30 | 80 | 80 | 75 |
      >| 6 | 65 | 35 | 40 | 70 | 90 | 75 |
      >| 7 | 70 | 40 | 70 | 85 | 70 | 85 |
      >| 8 | 40 | 30 | 50 | 75 | 75 | 65 |
      >| 9 | 30 | 40 | 20 | 35 | 40 | 25 |
      >| 10 | 65 | 60 | 75 | 75 | 85 | 85 |
      >
    > *Final Scores*
      >| Participant Number | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
      >| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
      >| score | 51 | 41 | 62 | 38 | 59 | 63 | 70 | 56 | 32 | 74 |
      >

> **Analysis between easy and hard mode**  
> 
> *Wilcoxon sign-ranked test*  
  >Step 1: calculate the difference between NASA TLX score
   >| Easy Score | Hard Score | Difference (easy - hard)|
   >| ----- | ----- | ----- |
   >| 36 | 51 | -15 |
   >| 39 | 41 | -2 |
   >| 43 | 62 | -19 |
   >| 28 | 38 | -10 |
   >| 38 | 59 | -21 |
   >| 45 | 63 | -18 |
   >| 52 | 70 | -18 |
   >| 38 | 56 | -18 |
   >| 31 | 32 | -1 |
   >| 68 | 74 | -6 |
   >
>
  >Step 2: sort and rank previous table by "difference"  
   >| Rank |  Difference | Rank (after) |
   >| ---- | ---- | ---- |
   >| 1 | -1 | -1 |
   >| 2 | -2 | -2 |
   >| 3 | -6 | -3 |
   >| 4 | -10 | -4 |
   >| 5 | -15 | -5 |
   >| 6 | -18 | -7 |
   >| 7 | -18 | -7 |
   >| 8 | -18 | -7 |
   >| 9 | -19 | -9 |
   >| 10 | -21 | -10 |
   >
> The sum of the positive signed ranks is 0, and the absolute sum of the negative signed ranks is 55. We selected the smaller value, 0, as our 'W' for comparison with the critical value. Subsequently, a "Two-Sided Test α" value of 0.1 was chosen. Our 'W' needed to be smaller than 11 to indicate a significant difference between the easy and hard modes. In this case, our 'W' is smaller than the critical value, indicating a significant difference between the easy and hard modes. This result demonstrates a clear distinction between the two modes.


**2. SUS**

  > *Scores*
   >| Participant Number | like to use frequently | unnecessarily complex | easy to use | need technical support | functions well integrated | too much inconsistency | learn to use quickly | cumbersome to use | confident to use | need to learn a lot before using |
   >| ----------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |
   >| 1 | 5 | 1 | 4 | 1 | 4 | 1 | 4 | 2 | 5 | 1 |
   >| 2 | 4 | 1 | 5 | 1 | 5 | 1 | 5 | 2 | 4 | 1 |
   >| 3 | 3 | 2 | 4 | 1 | 4 | 3 | 5 | 3 | 3 | 1 |
   >| 4 | 3 | 2 | 4 | 2 | 4 | 2 | 4 | 1 | 4 | 1 |
   >| 5 | 4 | 2 | 5 | 1 | 5 | 2 | 5 | 1 | 5 | 1 |
   >| 6 | 3 | 1 | 5 | 2 | 4 | 2 | 4 | 1 | 3 | 2 |
   >| 7 | 4 | 2 | 4 | 1 | 4 | 3 | 4 | 1 | 5 | 2 |
   >| 8 | 3 | 1 | 4 | 3 | 4 | 2 | 4 | 2 | 3 | 1 |
   >| 9 | 4 | 2 | 4 | 1 | 5 | 2 | 5 | 1 | 5 | 1 |
   >| 10 | 2 | 2 | 3 | 2 | 5 | 1 | 3 | 2 | 3 | 2 |
   >
 > *Score contribution*
   >| Participant Number | like to use frequently | unnecessarily complex | easy to use | need technical support | functions well integrated | too much inconsistency | learn to use quickly | cumbersome to use | confident to use | need to learn a lot before using |
   >| ----------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |
   >| 1 | 4 | 4 | 3 | 4 | 3 | 4 | 3 | 3 | 4 | 4 |
   >| 2 | 3 | 4 | 4 | 4 | 4 | 4 | 4 | 3 | 3 | 4 |
   >| 3 | 2 | 3 | 3 | 4 | 3 | 2 | 4 | 2 | 2 | 4 |
   >| 4 | 2 | 3 | 3 | 3 | 3 | 3 | 3 | 4 | 3 | 4 |
   >| 5 | 3 | 3 | 4 | 4 | 4 | 3 | 4 | 4 | 4 | 4 |
   >| 6 | 2 | 4 | 4 | 3 | 3 | 3 | 3 | 4 | 2 | 3 |
   >| 7 | 3 | 3 | 3 | 4 | 3 | 2 | 3 | 4 | 4 | 3 |
   >| 8 | 2 | 4 | 3 | 2 | 3 | 3 | 3 | 3 | 2 | 4 |
   >| 9 | 3 | 3 | 3 | 4 | 4 | 3 | 4 | 4 | 4 | 4 |
   >| 10 | 1 | 3 | 2 | 3 | 4 | 4 | 2 | 3 | 2 | 3 |
   >
 > *Final Scores*
   >|  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | Avg. |
   >| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
   >| Score | 90 | 92.5 | 72.5 | 77.5 | 92.5 | 77.5 | 80 | 72.5 | 90 | 67.5 | 81.25 |
   >



> **Analysis**
> 
> Based on the "Adjective" method, the SUS score of our system falls into the "Excellent" category. Compared to the "OK" result we obtained in stage 1, the usability of our system has shown a noticeable improvement. Specifically, the latest score is almost 20 points higher than the previous SUS score, indicating that users feel more confident and comfortable while using our improved interface.

>
<h3 id = "27">3. Unit Testing</h3>

In our testing process, we employed Equivalence Partitioning (EP) to ensure that the system delivers the desired output based on the input. We categorized the core features of the game and created both valid and invalid conditions according to different input scenarios, enabling us to thoroughly test their behavior. These features cover UI text input, player health, attack actions, shopping actions and moving actions. By adopting this Black Box approach, we were able to achieve comprehensive coverage of the system's functionalities. The test case specification table below demonstrates the categories, partitions, and expected outputs for our testing.

| Category                | Partition                                 | Expected Output                            |
| ----------------------- | ----------------------------------------- | ------------------------------------------ |
| Valid Name Input        | Alphabetical character                    | Textfield shows text                       |
| Invalid Name Input      | Number                                    | Textfield no response                      |
| Invalid Name Input      | Special character                         | Textfield no response                      |
|                         |                                           |                                            |
| Valid Player Health     | 0 < Health <= 3                           | Game keeps going                           |
| Invalid Player Health   | Health > 3                                | Max health stays at 3                      |
| Invalid Player Health   | Health <= 0                               | Game over                                  |
|                         |                                           |                                            |
| Valid Shopping Action   | User's money >= item's price              | Successfully buy                           |
| Invalid Shopping Action | User's money < item's price               | Show "don't have enough money to buy"      |
|                         |                                           |                                            |
| Valid Moving Action     | User clicks on the path around the planet | User move to the direct spot               |
| Valid Moving Action     | User clicks inside the planet             | User move to the closest point on the path |
| Invalid Moving Action   | User clicks outside the planet            | User will not move                         |
|                         |                                           |                                            |
| Valid Attack            | User's arrow shoot on the hitbox          | Health decreases by 1                      |
| Invalid Attack          | User's arrow misses the hitbox            | Health remains the same                    |




<h2 id = "28">Process</h2>

<h3 id = "29">Teamwork</h3>

Initially, we had a rough idea of our requirements but were unsure about all the features to be implemented. The flexible and adaptable agile development style fits our needs. During the game development process, we adopted the Agile development methodology and followed some of the Agile principles. It enhances the efficiency of the development and offers us many opportunities for idea validation and incremental improvement.

We prioritise getting things done and delivering value, recognising that continuous improvement is better than striving for perfectionism. By breaking the development process into manageable parts, we develop each component of the game in short cycles. We continuously developed working features so that the codebase in the main branch always works. We then can receive timely feedback from the evaluators and make necessary adjustments to improve the quality of the game. Camera movement, the physics engine, collision detection, health damage, points systems, and shop items have been iteratively tested and refined over development. Meanwhile, we followed a consistent coding standard and wrote meaningful comments. Therefore, the code is easy to understand for all of us.

<h3 id = "30">Collaboration Tools and Techniques</h3>

We utilised the following tools to facilitate effective collaboration and project management.

Before each sprint, we used Kanban boards on GitHub to have a visual overview of all the tasks and their current status. We prefer to keep things simple and organised in a single workspace, so we do not use other project management platforms. It worked well for us. After each meeting, we updated the tasks on the Kanban board. The urgency of tasks differs, and we focused on the most critical tasks first. For instance, we implemented gravity calculation and camera movement before adding a tutorial and animation. We planned the workload we could commit to using story points to estimate the efforts. Once we reached a consensus and the sprint began, no additional tasks were added. It helps achieve manageable expectations and creates a less stressful and sustainable working pace. 

<p align="center">
	<img width="60%" src="assets/readme/process-1.png">
	<br />
	<em>Kanban board to keep track of all the tasks</em>
</p>

We primarily communicated through WhatsApp, which keeps everyone connected. We discussed ideas, shared updates and feedback, and sought assistance. Although daily stand-up meetings are part of the Agile development methodology, it is challenging to maintain that frequency. Instead, we opted for a more flexible approach. We held weekly meetings to discuss potential new features. Apart from that, we considered refactoring the code to make it more robust and maintainable, preventing issues and reducing potential bugs in an early stage. The highly effective code after refactoring facilitates a smoother integration of changes.

GitHub serves as our central platform for developing the game collaboratively. We created a separate branch when implementing the features. We could work on the repository simultaneously and avoid breaking the code. After thorough testing, we submitted a pull request. It then might be viewed by other team members. If team members are satisfied with the code and check that the build is stable, it will get merged into the main branch.

<p align="center">
	<img width="60%" src="assets/readme/process-2.png">
	<br />
	<em>Graph of workflow on GitHub</em>
</p>

Though we worked separately on our feature branch most of the time, pair programming is an integral part of our development strategy. Whenever we had a face-to-face programming session, we worked in pairs. It is handy in dealing with code that involves adjustments in multiple classes. We fostered a deep understanding of the code and improved the quality of our code through mutual review.

<h3 id = "31">Role Distribution</h3>

Each group member voluntarily takes on a specific role. While we had separate tasks, everyone in the group was involved in all phases of the game development and was ready to help with other tasks as needed.
- Ada contributed to the development of animation in the game. She focused on the game's aesthetics, which creates an appealing player experience.
- Li-Hshin(Janet) designed the difficulty level and implemented the winning page of the game.
- Louis contributed significantly to the game, handling code merges, coding the overall structure, and implementing crucial features such as camera movement and gravity engine.
- Xinyu created the start menu, and fixed errors throughout the development process of the game.
- Yining implemented the shop system in the game, which makes the game more engaging to play.

Our team collaborated effectively and gained valuable insights using the Agile development methodology. We acknowledged several good practices during the development of the game. Use of the Kanban board, concise and meaningful documentation of code, and creation of branches and pull requests in the version control system to coordinate tasks all facilitated the workflow and led to desirable outcomes.



<h3 id = "32">Conclusion</h3>
We have learned a great deal throughout the development process. In the early stages, we invested considerable effort in crafting user stories, creating use-case diagrams, and designing class diagrams. This allowed us to maintain a clear perspective and objectives while implementing functionalities.

Besides, we greatly benefited from the flexibility offered by the agile workflow when we recognized the complexity and the potential time investment required for certain functionalities were too substantial. By leveraging the agile methodology, we opted to prioritize other essential functionalities in the game rather than becoming entrenched in a single feature.

Moreover, throughout the development process, utilizing evaluations such as Heuristic Analysis, NASA TLX, SUS analysis and Equivalence Partitioning testing proved to be extremely beneficial. Conducting Heuristic Analysis ourselves allowed us to identify the severity and priority of the problems we encountered. For example, by identifying the user interface issue as the most serious problem after the initial stage of evaluation, we were able to focus on improving it first. This targeted approach helped us streamline our efforts and make the necessary adjustments to enhance the overall user experience.

On the other hand, NASA TLX and SUS analysis provided us with valuable feedback and insights from the players' perspective. Through the first stage of NASA TLX analysis, we noticed that the difference between the easy and hard modes was not noticeable enough. This allowed us to obtain statistical results on how different the hard and easy modes were, so that we can make timely adjustments. SUS analysis also provided us with invaluable information to check if our system is user-friendly enough, and this allowed us to make our game more integrated and easy to use (SUS score grew from 61 to 83). These evaluations not only helped us address issues promptly but also ensured that the final product met the expectations and needs of our players. Finally, Equivalence Partitioning enabled us to make thorough test cases by categorising the core features of our game, hence enhancing the testing process.

Overall, our team effectively communicated and collaborated, with each member fulfilling their role. Using Kanban boards and WhatsApp, we managed tasks and shared updates efficiently. Pair programming sessions and role distribution ensured all aspects of development were covered. Also, through consistent coding standards and meaningful comments, our code remained understandable and maintainable. Our teamwork and methodology led to a successful project.

In the future, we plan to implement features such as character customization, which will provide a series of different characters for players to choose from. Each character will possess unique skills and weapons, enhancing the diversity and strategy within the game. Additionally, we aim to introduce varying AI difficulty levels, offering players the option to challenge themselves at different skill levels. It's worth mentioning that some of the current designs like "Pathfinder", "player abstraction" and so on are actually the fundamental of the future AI implementation. Finally, we aspire to develop an online version of the game, allowing people to enjoy the gameplay experience with their friends even when they are physically apart.



<h2 id = "33">Individual contribution:</h2>

- Ada : 1.00
- Li-Hshin(Janet) : 1.00 
- Louis : 1.00 
- Xinyu : 1.00 
- Yining : 1.00 


