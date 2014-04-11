import ddf.minim.*;

// Create constants for ease of coding
final boolean down = true;
final boolean up = false;
final int collisionThreshold = 50;

// Create a variable to hold the Hand object we will create
Hand theHand;

// Create variables to hold the Fly objects we will create
Fly fly1;
Fly fly2;
Fly fly3;

// Audio setup
Minim minim;
AudioSample buzz;
AudioSample slap;

void setup()
{
  size(600, 400);

  // Allow the position of ellipses and images to be the center instead of top-left corner
  // Makes for ease and consistency in calculating collisions
  ellipseMode(CENTER);
  imageMode(CENTER);

  // Initialize the hand, creating an object/instance that we can manipulate
  // as the sketch runs
  theHand = new Hand(50);
  // fly1 = new Fly((int)random(width), (int)random(height));
  // fly2 = new Fly((int)random(width), (int)random(height));
  // fly3 = new Fly((int)random(width), (int)random(height));
  fly1 = new Fly(50, 50);
  fly2 = new Fly(150, 150);
  fly3 = new Fly(250, 250);

  // Setup Sound
  minim = new Minim(this);
  // load mp3s from the data folder
  buzz = minim.loadSample( "buzz.wav", 512 ); // Filename, Buffer Size
  slap = minim.loadSample( "slap.mp3", 512 ); // Filename, Buffer Size
}

void draw()
{
  background(255);

  // Use dot-notation to call the draw function for each fly
  fly1.draw();
  fly2.draw();
  fly3.draw();

  // Use dot-notation to call the hand's draw function
  theHand.draw();

  // Check each fly to see if it's been swatted (delete if it was)
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