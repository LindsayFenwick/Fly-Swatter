// Create a class for the swatting hand
class Hand
{
  //Member variables
  int x, y; // The x and y location of the hand. Even though these will be the same
  // as the mouse location, it's useful to have separate variables for the class
  // in order to make the code easier to understand

  int size; // The width=height of the hand
  int minimumSize;
  int maximumSize;
  boolean swatting; // Is it swatting or not
  boolean swatDirection; //true for down, false for up

  int numberOfFlyHit; // Stores the number of the fly that was hit so that our main
  // draw function can check to see if there's a fly that needs to be marked "dead"

  // Constructor - setup for the class
  Hand(int _size)
  {
    size = _size; // Store the value that was given
    maximumSize = size;
    minimumSize = size/2;
    swatting = false; // No swatting at the beginning
    swatDirection = down; // Swatting motion shrinks the hand at first, then grows to get back to size
    numberOfFlyHit = 0; // No flies hit at the beginning, obviously
  }

  //Member functions

  void draw()
  {
    // Set the x and y to the mouse location
    x = mouseX;
    y = mouseY;

    checkSwat();

    fill(250, 222, 129);

    ellipse(x, y, size, size);
  }

  void startSwat()
  {
    // Start the swatting animation
    swatting = true;
    swatDirection = down;
  }

  void checkSwat()
  {
    // If we're swatting, do the animation
    if (swatting)
    {
      if (swatDirection == down)
      {
        // Make the hand smaller
        size-=4;
        if (size <= minimumSize)
        {
          // We should play the sound, check for a collision, and go back up
          slap.trigger();
          swatDirection = up;
          numberOfFlyHit = collided();
          
          if (numberOfFlyHit != -1)
          {
            flies[numberOfFlyHit].alive = false;
            fliesKilled = fliesKilled + 1;
          }
        }
      }
      else if (swatDirection == up)
      {
        // Make the hand bigger
        size+=4;
        if (size >= maximumSize)
        {
          size = maximumSize;
          //We are done swatting!
          swatting = false;
        }
      }
    }
  }

  int collided()
  {
    // Check the middle of each fly to see if the hand overlaps it
    for (int i = 0; i < 100; i++)
    {
      if (flies[i].x >= (x - minimumSize/2) && flies[i].x <= (x + minimumSize/2) &&
        flies[i].y <= (y + minimumSize/2) && flies[i].y >= (y - minimumSize/2))
      {
        // Return the number of the fly I collided with
        return i;
      }
    }

    // If no fly hit, return -1
    return -1;
  }
}

