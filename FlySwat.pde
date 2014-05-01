import ddf.minim.*;
PFont font;

// Create array to hold the Fly objects we will create
Fly[] flies = new Fly[10];

// The font must be located in the sketch's 
// "data" directory to load successfully


// Create constants for ease of coding
final boolean down = true;
final boolean up = false;
final int fliesToKill = 10;
final int collisionThreshold = 50;

// Game State variables
// 0 = Start Screen, 1 = playing, 2 = end
int gameState;
int initialTime;
int finalTime;
int displayTimer;
int fliesKilled;

// Create a variable to hold the Hand object we will create
Hand theHand;



// Audio setup
Minim minim;
AudioSample buzz;
AudioSample slap;

void setup()
{
  size(600, 400);
  gameState = 0; // Start Screen
  initialTime = 0;
  finalTime = 0;
  displayTimer = 0;
  fliesKilled = 0;

  font = loadFont("SourceSansPro-Light-48.vlw");
  textFont(font, 48);

  // Allow the position of ellipses and images to be the center instead of top-left corner
  // Makes for ease and consistency in calculating collisions
  ellipseMode(CENTER);
  imageMode(CENTER);

  // Initialize the hand, creating an object/instance that we can manipulate
  // as the sketch runs
  theHand = new Hand(50);

  // Initialize my flies
  for (int i = 0; i < 100; i++)
  {
    flies[i] = new Fly((int)random(width), (int)random(height));
  }

  // Setup Sound
  minim = new Minim(this);
  // load mp3s from the data folder
  buzz = minim.loadSample( "buzz.wav", 512 ); // Filename, Buffer Size
  slap = minim.loadSample( "slap.mp3", 512 ); // Filename, Buffer Size
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
        finalTime = millis() + 30000;
        displayTimer = 5;
      }
    }
  }
  else if (gameState == 1) // Gameplay
  {
    background(255, 0, 0);
    text(displayTimer, 10, 50);

    // Has 1 second passed
    if (millis() - initialTime > 1000)
    {
      displayTimer = displayTimer - 1;
      initialTime = millis();
      // ENd the game if displayTimer is zero
      if (displayTimer == 0)
      {
        println("Game End");
        gameState = 2; //END
      }
    }

    // Use dot-notation to call the draw function for each fly
    for (int i = 0; i < 100; i++)
    {
      flies[i].draw();
    }

    // Use dot-notation to call the hand's draw function
    theHand.draw();



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

