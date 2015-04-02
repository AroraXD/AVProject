class character
{
  String name;
  PImage sprite1;
  float location;
  String loc;
  boolean unlocked;
  PVector c1, c2, c3, c4;


  character(String n, String l )
  {
    name = n;
    sprite1 = loadImage("Characters/"+name+".png");
    loc = l;
  }

  void update()
  {
    if (!unlocked)//as soon as the update funtion is called the character has been seen by the player and its stats are visable in the pause menu.
      unlocked = true;

    if (frameCount%300 == 1 )//reloads the image every 10 secounds. reduces the blur caused by resizing if the user makes the window smaller then bigger. 
    {
      sprite1 = loadImage("Characters/"+name+".png");
    }

    sprite1.resize(0, int(height*0.8));

    if (loc == "LEFT")
      location = width*0.8;
    else
      location = width*0.2;

    image(sprite1, location, height - sprite1.height/2);
  }
}

