class Fly
{
  // Member variables
  int x, y, w, h; // Location, width, and height
  PImage frame1, frame2, frame3; // Animation frames
  boolean alive; // Am I alive or not?
  int currentImage; // For the animation - what is the current image being shown?

  // Constructor
  Fly(int _x, int _y)
  {
    // Store the values that were given
    x = _x;
    y = _y;

    //  Set the initial values for the tracking variables
    alive = true;
    currentImage = 1;

    // Load the frames of the animation into memory
    frame1 = loadImage("fly1.png");
    frame2 = loadImage("fly2.png");
    frame3 = loadImage("fly3.png");

    w = frame1.width/4; // Make the fly 1/4 the size of my image
    h = frame1.height/4; // Make the fly 1/4 the size of my image
  }

  // Member functions

  void draw()
  {
    if (currentImage == 1)
    {
      image(frame1, x, y, w, h);
      currentImage++;
    }
    else if (currentImage == 2)
    {
      image(frame2, x, y, w, h);
      currentImage++;
    }
    else if (currentImage == 3)
    {
      image(frame3, x, y, w, h);
      currentImage++;
    }
    else if (currentImage == 4)
    {
      image(frame2, x, y, w, h);
      currentImage++;
    }
    else if (currentImage == 5)
    {
      image(frame1, x, y, w, h);
      currentImage = 1;
    }
  }

  void move()
  {
    // For now, have each fly move right to left and back
  }

  boolean amIHit()
  {
    alive = false;
    return alive;
  }
}