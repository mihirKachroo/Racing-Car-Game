/*
  Description: Processing Assignment One
 Author: Mihir Kachroo
 Date of last edit: October 25
 */


//Link to my image : https://www.shutterstock.com/video/clip-1010258582-retro-pixel-art-style-race-car-video

//Variables used to make the mountains in the background
float[] mountainElements = new float[72];
float mountainY;
float mountainXStart;
float mountainXEnd;
float mountainX;

//Variables used to make the racing tracks on the side of the road
float racingTrackY;
float racingTrackThickness;
float racingTrackYChange;

//Variables used to make the grey road in the middle
float roadLineYChange;
float roadLineX;
float roadLineY;
float roadLineWidth;
float roadLineHeight;

//Variable that changes where the X-axis of the car is
float carDirection;

//Variable to judge if the user uses the mouse or the arrow keys to control the car
boolean mouseControl;

//Variable to randomly choose which obstacle will appear
float obstacleChoice;

//Variables for the rock obstacles
float rockY;
float rockSize;
float rockX;
float rockSide;

//Variables for the cow obstacle
float cowY;
float cowSize;
float cowX;

//Variables used to make the first cloud
float cloudX;
float cloudY;
float cloudHorizontal;
float cloudXChange;
float cloudYChange;

//Variables used to make the second cloud
float cloud2X;
float cloud2Y;
float cloud2Horizontal;
float cloud2XChange;
float cloud2YChange;

//Variables for the sign that appears to show the number of laps
float signX;
float signY;
float signWidth;
float signHeight;
float signTextSize;

//Variable to decide if the sun is on or off
boolean flashingSun;

//Variable to decide if the flames are visible or not
boolean showFlames;

//Variable to control the activation of the start, game and ending
boolean startScreen;
boolean startGame;
boolean endGame;

//Variables to inform the user of their scores
int topScore;
int currentScore;
int lapNumber;
int lapCounter;
int speed;

//Variable to control the size of the explosion of the car
float explosionSize;

//Variable that counts the number of times that 'p' has been clicked so we know if the user wants to pause or resume
float pauseCounter;

//Variable for the ending line
String ending="You Lose";

//Variable used to change the size of the text on the "win" screen
float endingTextSize;

//Variable used to adjust the delay of the screen
int delay;

void settings() {
  size(950, 700);
}

void setup() {   
  background(90, 205, 249);

  //Outputs the game introduction for user into the console
  println("Welcome to the Game");
  println("Objective:");
  println("  Do not hit an obstacle or go off the road");
  println("  Get to lap 10 to win");
  println("Instructions:");
  println("  Use Mouse or Arrow Keys");
  println("  Press Space Bar for a speed boost but beware that the boost leads to less control over the car");
  println("  Click on the sun to change time of day");
  println("  Press p to pause and resume");
  println("  Press e to quit");

  startScreen = true; //Presets the start screen to on
  startGame = false; //Presets the game to off
  endGame = false; //Presets the end screen to off

  //Sets the coordinates of the mountain
  mountainXStart = random(-60, -30);
  mountainX = random(75, 120);
  mountainXEnd = mountainX+mountainXStart;
  mountainY = random(230, 260);

  //Adds random values for points in the mountain to an array which will be accessed later
  for (int i=0; i<72; i+=4) {
    mountainElements[i] = mountainXStart;
    mountainElements[i+1] = mountainX/2+mountainXStart;
    mountainElements[i+2] = mountainY;
    mountainElements[i+3] = mountainXEnd;
    mountainX = random(95, 120);
    mountainXStart = random(mountainXEnd-60, mountainXEnd-30);
    mountainXEnd = mountainX+mountainXStart;
    mountainY = random(230, 260);
  }

  //Sets the variables for the road
  roadLineX = width/2;  
  roadLineYChange = 8;  
  roadLineY = height/2.15;
  roadLineWidth = 2;
  roadLineHeight = 5.99999;

  //Sets the values for the race tracks at the side of the road
  racingTrackY = 300;
  racingTrackThickness = 2;
  racingTrackYChange = 0;

  //Sets values of the first cloud
  cloudX = random(10, 140);
  cloudY = random(50, 25);
  cloudHorizontal = random(47, 50);
  cloudXChange = random(0, 10);
  cloudYChange = random(-1, 1);

  //Sets values of the second cloud
  cloud2X = random(410, 540);
  cloud2Y = random(55, 25);
  cloud2Horizontal = random(50, 57);
  cloud2XChange = random(0, 10);
  cloud2YChange = random(-1, 1);

  //Sets the default scores
  currentScore = 0;
  lapCounter = 0;
  lapNumber = 0;
  speed = 90;

  //Sets the original x-value of the car
  carDirection = 0;

  //Randomly selects which obstacle shall appear
  obstacleChoice = random(0, 3);

  //Sets values for the first obstacle (the rock)
  rockX = 0;
  rockY = 0;
  rockSize = 1;

  //Sets values for the second obstacle (the cow)
  cowX = -10;
  cowY = 1;
  cowSize = 0.9;

  //Sets variable for the size of the explosion that will occur if the car crashes
  explosionSize = 3;

  //Presets the pause counter to 1
  pauseCounter = 1;

  //Sets the variables for the lap counter sign
  signX = 580;
  signY = height/2.15;
  signWidth = 2;
  signHeight = 5.99;
  signTextSize = 0.5;

  //Sets the boolean for the sun to shine to true
  flashingSun = true;

  //Sets the text size for the "win" screen
  endingTextSize = 10;

  //Sets the boolean for the flames to show to false
  showFlames = false;
}

void draw() {
  //Runs the starting screen if startScreen is true
  if (startScreen) {
    rectMode(RADIUS);
    //Highlights (by changing the colour) the option which the user is hovering over
    if (mouseX<398 && mouseX>100 && mouseY<503 && mouseY>196) {
      fill(49);
    } else {
      fill(0);
    }
    //Creates the left rectangle
    stroke(255);
    strokeWeight(5);
    rect( width/2-225, height/2, 150, 100);


    //Highlights (by changing the colour) the option which the user is hovering over
    if (mouseX<852 && mouseX>552 && mouseY<500 && mouseY>196) {
      fill(190);
    } else {
      fill(255);
    }
    //Creates the right rectangle
    stroke(0);
    rect( width/2+225, height/2, 150, 100);


    if (mousePressed) {
      //Starts game and turns mouse control off if user selects the left button
      if (mouseX<398 && mouseX>100 && mouseY<503 && mouseY>196) { 
        mouseControl = false;
        startScreen = false;
        startGame = true;
      }
      //Starts the game and turns mouse control on if the user selects the right button
      else if (mouseX<852 && mouseX>552 && mouseY<500 && mouseY>196) {
        mouseControl = true;
        startScreen = false;
        startGame = true;
      }
    }

    //Display the text that state the two options for playing
    textAlign(CENTER);
    fill(0, 102, 153);
    textSize(40);
    text("Arrow Keys", width/2-225, height/2+7);
    text("Mouse", width/2+225, height/2+7);
  }



  //Runs the game if the boolean startGame is true
  if (startGame) {

    //Creates the race tracks on the sides of the road
    noStroke();
    racingTrackY = 300;
    racingTrackThickness = 2;
    rectMode(RADIUS);
    //Creates stripes accross the tract that are growing in size
    for (int a = 1; a<25; a += 1) {
      //Alternates between creating a red and white stripe
      if (a%2==0) {    //If a is even, it creates a red stripe
        fill(220, 60, 48);
      } else {     //If a is odd, it creates a white stripe
        fill(255);
      }
      //Draws the stripes
      racingTrackY += racingTrackThickness;
      racingTrackThickness *= 1.19;
      rect(width/2, racingTrackY+racingTrackYChange, 325, racingTrackThickness);
    }

    //Shifts all of the stripes down to create a moving effect
    racingTrackYChange+=8;

    //Restarts the creation of the stripes if the stripes go over a certain value
    if (racingTrackY+racingTrackYChange>height+305) {
      racingTrackYChange = 2;
    }


    //Creates the green grass
    fill(65, 160, 75);
    quad(0, height, 0, height/2.15, 390, height/2.15, 150, height); //Makes grass on the left side of road
    quad(800, height, 560, height/2.15, width, height/2.15, width, height);//Makes grass on the right side of road

    //Creates the road itself
    fill(153, 152, 158);
    quad(195, height, 400, height/2.15, 550, height/2.15, 755, height); //Makes middle of road


    //Creates the painted white road lines that come down the middle of the road
    fill(247, 250, 255);
    for (int i = -3; i<6; i += 1) {
      rect(roadLineX, i*70+roadLineY, i*0.8+roadLineWidth, i*2+roadLineHeight);
    }
    //Shifts the lines down and makes them bigger to give the illusion of movement
    roadLineY = height/2.15+roadLineYChange;
    roadLineYChange += 8;
    roadLineWidth += 0.1;
    roadLineHeight += 0.285;

    //Resets the road values to restart the animation of the white line if it crosses a certain point
    if (3*70+roadLineY+roadLineHeight>=695.5814) {
      roadLineYChange = 8;  
      roadLineY = height/2.15+1;
      roadLineWidth = 2.05;
      roadLineHeight = 6.1;
    }


    //Turns the sky blue or dark blue depending on if the sun is shining
    rectMode(CORNER);
    if (flashingSun != true) {
      fill(5, 60, 90);
    } else {
      fill(90, 205, 249);
    }
    rect(0, 0, 950, 325.58);



    //Makes the sun orange or transparent depending on if flashingSun is true or false
    if (flashingSun) {
      fill(random(195, 220), random(20, 85), 30);
    } else {
      noFill();
    }
    ellipse(width/2, height/2.15-70, 130, 130);


    //Accesses the mountain array that was set in setup() to create the mountain
    for (int i = 0; i<72; i += 4) {
      fill(108, 62, 29);
      triangle(mountainElements[i], height/2.15, mountainElements[i+1], mountainElements[i+2], mountainElements[i+3], height/2.15);
    }

    //Creates the white road lines on the two sides of the road
    fill(247, 250, 255);
    quad(215, height, 404, height/2.15, 406, height/2.15, 236, height); //Left line
    quad(714, height, 544, height/2.15, 546, height/2.15, 735, height); //Right line


    //Uses the random obstacle choice that was set earlier to decide which obstacle to make appear
    noStroke();
    fill(69, 80, 90);
    if (obstacleChoice <= 2) { //Creates the rock obstacle
      if (obstacleChoice < 1) { //Creates a rock on the right side
        rockSide=500;   
        rockX+=1.2;
      } else { //Creates a rock on the left side
        rockSide = 450;
        rockX -= 1.2;
      }
      ellipse(rockSide+rockX, height/2.15+rockY, 10*rockSize, 5*rockSize);
      rockSize += 0.15;
      rockY += 10;

      //If the car hits the rock, trigger the end
      if (rockX+rockSide-25<445+carDirection && rockX+rockSide+25>290+carDirection && height/2.15+rockY<678 && height/2.15+rockY>618) {
        endGame=true;
      }
    } else if (obstacleChoice<=3) { //Creates the cow obstacle
      rectMode(RADIUS);
      stroke(0);
      strokeWeight(1);
      fill(30);
      rect(240+cowX, height/2.15+7+cowY, 1*cowSize*1.1, 4*cowSize*1.1, 10); //Cow left leg
      rect(260+cowX, height/2.15+7+cowY, 1*cowSize*1.1, 4*cowSize*1.1, 10); //Cow right leg
      rect(240+cowX, height/2.15+3+cowY, 9*cowSize, cowSize, 10); //Cow tail
      fill(250);
      rect(250+cowX, height/2.15+cowY, 12.5*cowSize*0.85, 6.5*cowSize*0.8, 10); //Cow Body
      fill(10);
      rect(250+cowX-cowSize, height/2.15-5+cowY, 1*cowSize, 1.5*cowSize, 6); //Cow left patch
      rect(241+cowX-cowSize, height/2.15+3+cowY, 2*cowSize, 1*cowSize, 6); //Cow right patch
      fill(255);
      rect(260+cowX, height/2.15-4+cowY, 7*cowSize*0.9, 7*cowSize*0.85, 1, 1, 6, 6); //Cow head
      fill(235, 152, 170);
      rect(260+cowX, height/2.15+cowY+cowSize, 5*cowSize*1.05, 2.5*cowSize*1.05, 10, 10, 60, 60); //Cow mouth
      stroke(10);
      strokeWeight(4);
      point(258.5+cowX, height/2.15-7.5+cowY); //Cow left eye
      point(265.5+cowX, height/2.15-7.5+cowY); //Cow right eye

      //If the cow comes onto the road, make the cow start to move down vertically
      if (cowX<150) {
        cowSize += 0.02;
        cowX += 25;
        cowY += 6;
      } 
      //Make the cow move right towards the road
      else {
        cowSize += 0.06;
        cowX += 0.06;
        cowY += 15;
      }

      //If the car hits the cow, trigger the end
      if (cowX+250-24<445+carDirection && cowX+250+30>290+carDirection && height/2.15+cowY<680 && height/2.15+cowY>618) {
        endGame=true;
      }
    }

    //Reset the obstacle variables and choose a new random obstacle if the annimation of one of the obstacles has exceeded the height
    if (cowY>height+20 || rockY>height+15) {
      obstacleChoice=random(0, 3);
      rockX = 0;
      rockY = 0;
      rockSize = 1;
      cowX =- 10;
      cowY = 1;
      cowSize = 0.9;
    }


    //The arrow key controls for the car
    if (!mouseControl) {
      if (keyPressed && keyCode == RIGHT) {
        carDirection+=15;
      } else if (keyPressed && keyCode==LEFT) {
        fill(255);
        carDirection-=15;
      }
    }

    //The mouse controls for the car
    else if (mouseControl) {
      carDirection = mouseX-367;
    }


    //When the boost is activated due to the Space Bar being pressed
    if (keyPressed && key==' ') {
      delay = 30;
      showFlames = true;
    }

    //When the boost is not used because the Space Bar is not being pressed
    if (keyPressed != true) {
      delay = 70;
      showFlames = false;
    }


    //If showFlames is true, create a smoke animation
    if (showFlames) {
      rectMode(RADIUS);
      noStroke();
      fill(random(180, 235), 89, 54);
      ellipse(368+carDirection+random(-2, 2), 663+random(-2, 2), 40+random(-4, 4), 55+random(-4, 4));
      fill(random(190, 210), 49, 9);
      ellipse(368+carDirection+random(-1, 1), 653+random(-1, 1), 15, 25);
    }


    //Creates the main red car
    fill(10);
    noStroke();
    rectMode(CORNER);
    rect(289+carDirection, 617, 26, 38, 8, 6, 1, 15); //Left tire
    rect(418+carDirection, 617, 26, 38, 6, 8, 15, 1); //Right tire
    fill(255);
    rect(296+carDirection, 626, 10, 4); //Left tire white reflection
    rect(427.5+carDirection, 626, 10, 4); //Right tire white reflection
    fill(211, 30, 39);
    rect(311+carDirection, 612.5, 112, 23, 4); //Rectangle rear
    rect(340+carDirection, 604, 54, 15); //Rectangle rear top
    rect(330+carDirection, 583, 74, -5); //Part above the shaded part of the wing
    rect(330+carDirection, 578, 20, -4); //Left part above the wing
    rect(404+carDirection, 578, -20, -4); //Right part above the wing
    rect(353+carDirection, 590, 24, 25); //Rectangle body-wing connector
    fill(10, 10, 10);
    rect(309+carDirection, 630, 116, 8.5); //Part above bumper
    rect(352+carDirection, 630, 30, 14); //Rear bumper
    fill(162, 15, 24);
    ellipse(367+carDirection, 625, 20, 20); //Shading for rear
    fill(190, 201, 208);
    rect(358+carDirection, 626, 18, 9); //Grey flash
    fill(255, 229, 68);
    rect(359+carDirection, 604, 12, -15); //Yellow light
    fill(173, 10, 14);
    rect(330+carDirection, 592, 74, -9); //Rectangular shaded wing
    stroke(250, 100, 0);
    strokeWeight(4);
    line(330+carDirection, 571, 330+carDirection, 619); //Verticle line left
    line(404+carDirection, 571, 404+carDirection, 619); //Verticle line right
    strokeWeight(2);
    line(330+carDirection, 619, 350+carDirection, 630); //Diagonal line left
    line(404+carDirection, 619, 384+carDirection, 630); //Diagonal line right


    //Creates the first cloud and makes it randomely move accross the screen
    fill(238, 241, 250);
    noStroke();
    ellipse(cloudX+25+cloudXChange, cloudY+cloudYChange-5, cloudHorizontal+10, cloudHorizontal+10);  // Developemental code used for getting x,y of a point
    ellipse(cloudX+cloudXChange, cloudY+cloudYChange, cloudHorizontal, cloudHorizontal);  // Developemental code used for getting x,y of a point
    ellipse(cloudX+50+cloudXChange, cloudY+cloudYChange, cloudHorizontal, cloudHorizontal);  // Developemental code used for getting x,y of a point
    cloudXChange += random(0, 20);
    cloudYChange += random(-1, 1);

    //Creates the second cloud and makes it randomely move accross the screen
    ellipse(cloud2X+cloud2XChange, cloud2Y+cloud2YChange, cloud2Horizontal+20, cloud2Horizontal+20);  // Developemental code used for getting x,y of a point
    ellipse(cloud2X+20+cloud2XChange, cloud2Y+cloud2YChange, cloud2Horizontal+20, cloud2Horizontal+20);
    cloud2XChange += random(5, 24);
    cloud2YChange += random(-3, 3);

    //Resets the positions of the first cloud if it goes over the width
    if (cloudX*1.4-80+cloudXChange>width) {
      cloudX =- 10;
      cloud2Y = random(55, 25);
      cloudHorizontal = random(35, 55);
      cloudXChange = random(0, 10);
      cloudYChange = random(-1, 1);
    }

    //Resets the positions of the second cloud if it goes over the width
    if (cloud2X-100+cloud2XChange>width) {
      cloud2X = -10;
      cloud2Y = random(55, 25);
      cloud2Horizontal = random(35, 55);
      cloud2XChange = random(0, 10);
      cloud2YChange = random(-2, 2);
    }

    //Triggers the end if the car goes off the road
    if (carDirection>465 || carDirection<-245) {
      endGame = true;
    }

    //Halts the code for a spefic amount of time so that it can create the ilusion of movement
    delay(delay);

    //Increses the current score of the user and lap counter by 10
    currentScore += 10;
    lapCounter += 10;

    //Sets the current score as the users top score if it is their highest
    if (currentScore>topScore) {
      topScore = currentScore;
    }

    //Creates a sign to show the number of laps completed
    if (lapCounter>500) {
      rectMode(CENTER);      
      noStroke();
      fill(86, 56, 45);
      rect(signX, signY+signHeight, signWidth/5, signHeight);
      fill(64, 91, 170);
      stroke(3, 2, 104);
      strokeWeight(3);
      rect(signX, signY, signWidth, signHeight);
      textAlign(CENTER, CENTER);
      textSize(signTextSize);
      fill(255);
      int currentLapNumber=lapNumber+1;
      text("Lap "+currentLapNumber, signX, signY);
      signX += 5.5;
      signY += 5.5;
      signWidth += 2;
      signHeight += 1;
      signTextSize += 0.53;

      //If the sign goes off the screen, increases the lapNumber by 1 and reset the lapCounter so it can be used again
      if (signY>height+20) {
        signX = 580;
        signY = height/2.15;
        signWidth = 8;
        signHeight = 4;
        signTextSize = 0.5;
        lapNumber += 1;
        lapCounter = 0;
      }
    }


    //Accelerates the speed by one if the car is in boost mode
    if (delay<50) {
      speed += 1;
      if (speed>=160) {
        speed = 160;
      }
    }

    //Decelerates the speed by one if the car is in boost mode
    if (delay>60) {
      speed -= 1;
      if (speed<=90) {
        speed = 100;
      }
    }

    speed+=random(-3, 3); //Lightly increases or decreases the speed by a random amount

    textAlign(RIGHT);
    textSize(20);

    //Shows the user their top score
    fill(200, 20, 20);
    text("TOP "+topScore, 170, 54);

    //Shows the user their current score
    fill(255);
    text("SCORE "+currentScore, 170, 81);

    //Shows the user their lap number
    fill(10, 249, 229);
    text("LAP "+lapNumber, 800, 54);

    //Shows the user their speed
    fill(255);
    text("SPEED "+ speed, 800, 81);
  }

  //If the user makes it to lap 10, they win
  if (lapNumber==10) {
    startGame = false; //Stop the game
    startScreen = false; //Stop the start screen
    background(27, 169, 8); //Change background to green

    //Create random confetti
    for ( int n = 0; n < 50; n++ ) {
      float x = random( width );
      float y = random( height );
      fill( random(255), random(255), random(255) );
      ellipse( x, y, 40, 40 );
    }

    delay(210);

    //Create an expanding "You Win!" text
    fill(255);
    textAlign(CENTER);
    textSize(endingTextSize);
    endingTextSize += 5;
    if (endingTextSize>=140) {
      endingTextSize = 140;
    }
    text("You Win!", width/2, height/1.8);
  }


  //If the ending is triggered, create an explosion
  if (endGame) {
    startGame = false;
    stroke(100, 10, 10);
    strokeWeight(2);
    fill(200, 10, 10);
    explosionSize *= 1.1;
    ellipse(width/2, height/2, explosionSize, explosionSize);

    //When the explosion reaches the width, print the ending and reset the program
    if (explosionSize>=1100) {
      println(ending);
      setup();
    }
  }
}

public void keyPressed() {
  //Button to quit game
  if (keyPressed && key=='e' || key=='E') {
    endGame = true;
  }

  //Button to pause and resume the game
  if (keyPressed && key=='p' || key=='P') {
    //If the pauseCounter is even, pause the game
    if (pauseCounter%2==0) {
      noLoop();
    } 
    //If the pauseCounter is odd, resume the game
    else {
      loop();
    }
    pauseCounter += 1;
  }


  //Developemental code to get point on screen...Not a part of game
  /*if (key=='x') {
   fill(255);
   ellipse (mouseX, mouseY, 2, 2);
   text("x: "+ mouseX+ "     y: "+ mouseY, mouseX, mouseY);
   }*/
}

public void mousePressed() {
  //Uses mouse X and Y values to check if it is within the radius of the sun
  if (mousePressed && dist(width/2, height/2.15, mouseX, mouseY) < 130) {
    flashingSun = !flashingSun; //Flips the boolean
  }
}
