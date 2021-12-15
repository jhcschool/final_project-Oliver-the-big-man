import processing.sound.*;
SoundFile file;
SoundFile file2;

Based_Balls[] good_balls;
Cringe_Balls[] bad_balls;
Player player;
//global variable used for color
int blue_color = 0;


void setup() {
  size(900, 750);
  run_game();
  player = new Player();
  //defining sounds used
  file = new SoundFile(this, "DarkSouls.mp3");
  file2 = new SoundFile(this, "FinalFantasy.mp3");
}
void run_game() {
  //randomizes blue color for good ball
  blue_color = (int)random(0, 255);
  //spawning good and bad balls using array and for loop
  bad_balls = new Cringe_Balls[4000];
  for (int ic=0; ic<bad_balls.length; ic++) {
    bad_balls[ic] = new Cringe_Balls((int)random(width), (int)random(height));
  }
  good_balls= new Based_Balls[1];
  for (int ib=0; ib<good_balls.length; ib++) {
    good_balls[0] = new Based_Balls((int)random(width), (int)random(height));
  }
}
//global variables for printed text, empty strings
String you_lost = "";
String you_won = "";
String directions = "";
String score_counter= "";
void draw() {
  //global, game starting is false moussed presse dmakes it true
  if (!game_starting) {
    starting_screen();
  } else {
    //setting up printing texts, strings are still empty
    background(100, 100, 100);
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(0, 255, 0);
    text(you_won, 450, 450 );
    fill(255, 0, 0);
    text(you_lost, (width/2)-250, (height/2)-250, 500, 500);
    fill(255, 255, 255);
    text(directions, 450, 600);
    text(score_counter, 450, 700);
    //run function defined in ball class, it defines position and color randomly
    for (int ic=0; ic<bad_balls.length; ic++) {
      bad_balls[ic].run();
    }
    for (int ib=0; ib<good_balls.length; ib++) {
      good_balls[ib].run();
    }
  }
}

boolean game_starting = false;
void mousePressed() {
  println(mouseX);
  println(mouseY);
//checking for colison, if collide with good ball fill strings mostly, same with else statement for not collidin 
  if (game_starting) {
    if (good_balls[0].position.dist(new PVector(mouseX, mouseY))<good_balls[0].diameter/2) {
      you_won = "YOU WON!";
      player.score++;
      directions = "Press R to replay";
      score_counter = "score: "+player.score;
      file2.play();
    } else {
      for (int i =0; i<bad_balls.length; i++) {
        if (bad_balls[i].position.dist(new PVector(mouseX, mouseY))<bad_balls[i].diameter/2) {
          you_lost = "YOU'RE SO STUPID YOU ABSOLUTE GOON YOU MORON";
          player.score--;
          directions = "Press R to replay" ;
          score_counter = "score: "+player.score;
          file.play();
        }
      }
    }
    //moves all ball off screen after click 
    for (int ib=0; ib<good_balls.length; ib++) {
      good_balls[ib].position.x = -50;
    }
    for (int ic=0; ic<bad_balls.length; ic++) {
      bad_balls[ic].position.x = -50;
    }
  }
  game_starting = true;
}
//what is used when game starting is false, defaults to this
void starting_screen() {
  background(100, 100, 100);
  textSize(45);
  textAlign(CENTER, 0);
  fill(255, 255, 255);
  text("find and click on the correct ball", 450, 100);
  text("Click to start", 450, 500);
  text("HINT: the ball will not be under any other balls", 450, 600);
  text("Press R to replay", 450, 700);
  fill(0, 0, blue_color);
  ellipse(450, 300, 200, 200);
}

void ending_screen() {
}
//is the reset function, emptys strings, sets game starting back to false, and reinitializes game (randomizes again)
void keyPressed() {
  if ( key == 'r') {
    run_game();
    game_starting = false;
    you_won = "";
    you_lost = "";
    directions = "";
    score_counter = "";
  }
}
