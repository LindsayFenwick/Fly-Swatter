import ddf.minim.*;
PFont font;

// Create constants to make things easier in the future
final boolean down = true;
final boolean up = false;
final int numberOfFlies = 100;
final int fliesToKill = 50;
final int collisionThreshold = 20;
final int maximumTime = 60;

// Create array to hold the Fly objects we will create
Fly[] flies = new Fly[numberOfFlies];

// Use this variable to control what happens with each state of the game
// 0 = Start Screen, 1 = playing, 2 = bad ending, 3 = good ending
int gameState;

// Variables to track time
int initialTime;
int displayTimer;

// How many flies have I swatted?
int fliesKilled;

// Create a variable to hold the Hand object we will create
Hand theHand;

// Audio setup
Minim minim;
AudioSample buzz;
AudioSample slap;

void setup()
{
  size(800, 700);
  gameState = 0; // Start at the start screen

  // Set everything else to zero
  initialTime = 0;
  displayTimer = 0;
  fliesKilled = 0;

  // Load the font file that I create to make it available to the sketch
  // This file needs to be in the sketch's data folder (much like images and
  // audio files that you use in your sketch)
  font = loadFont("SourceSansPro-Light-48.vlw");
  textFont(font);

  // Allow the position of ellipses and images to be the center instead of top-left corner
  // Makes for ease and consistency in calculating collisions
  ellipseMode(CENTER);
  imageMode(CENTER);

  // Initialize the hand, creating an object/instance that we can manipulate
  // as the sketch runs
  theHand = new Hand(50);

  // Initialize my flies
  for (int i = 0; i < numberOfFlies; i++)
  {
    flies[i] = new Fly((int)random(width), (int)random(height));
  }

  // Setup Sound
  minim = new Minim(this);
  // load mp3s from the data folder
  buzz = minim.loadSample("buzz.wav", 512); // Filename, Buffer Size
  slap = minim.loadSample("slap.mp3", 512); // Filename, Buffer Size
}

void draw()
{ 
  // Start Screen
  if (gameState == 0)
  {
    text("Press the Enter key to start", 10, height/2);
    if (keyPressed)
    {
      if (key == ENTER) 
      {
        gameState = 1;
        initialTime = millis();
        displayTimer = maximumTime;
      }
    }
  }
  else if (gameState == 1) // Gameplay
  {
    background(255, 0, 0);

    // Has 1 second passed?
    if (millis() - initialTime > 1000)
    {
      displayTimer = displayTimer - 1;
      initialTime = millis();
      // End the game if displayTimer is zero
      if (displayTimer == 0)
      {
        gameState = 2; //END
      }
    }

    // Use dot-notation to call the draw function for each fly
    for (int i = 0; i < numberOfFlies; i++)
    {
      flies[i].draw();
    }

    // Use dot-notation to call the hand's draw function
    theHand.draw();

    // Draw the timer last so that it shows on top of everything
    text(displayTimer, 10, 50);

    if (fliesKilled == fliesToKill)
    {
      gameState = 3;
    }
  }
  else if (gameState == 2) // Bad End
  {
    background(0);
    fill(255);
    text("Game Over, You Suck", width/8, height/2);
  }
  else if (gameState == 3) // Good End
  {
    background(0);
    fill(255);
    text("Game Over, You Rock", width/8, height/2);
  }
}

// If the mouse was pressed:
void mousePressed()
{
  // Start the swat motion and collision checking
  theHand.startSwat();
}

// For testing
void keyPressed()
{
  if ( key == 'b' ) buzz.trigger();
  if ( key == 's' ) slap.trigger();
}

