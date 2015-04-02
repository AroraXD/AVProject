//Audio Visual Coursework 2
//by Jacky Wang && Yuvesh Tulsiani
//github: https://github.com/uveavanto/AVProject

Maxim maxim; 
AudioPlayer backgroundmusic; 
AudioPlayer ringtone; 
AudioPlayer labmusic;
AudioPlayer labsounds;

PFont font1;

boolean shake;

character character1;
character character2;

boolean showcharacter1 = false;
boolean showcharacter2 = false;

color textcol = color(255);

String text = "text goes here";
String username ="";

int index = 0;//controls which line of text the game reads.

int pausestate =0; //sets which part of the pause menu the player is veiwing

PImage currentbackground;
PImage thegreensBG;
PImage labsBG;
PImage lectureBG;
PImage filterimg;
PVector v1, v2, v3, v4;

boolean play = false;
boolean processing = false;
boolean showfilters = false;
boolean showboids = false;
boolean insertname = false;
boolean paused =false;


Boid allBoids[]; //creates an array to store the boids

void setup()
{
  size(900, 600, P3D);//p3d needed for the boids to work properly

  rectMode(CENTER);
  imageMode(CENTER);
  textureMode(NORMAL);
  noStroke();
  smooth();

  textAlign(CENTER, CENTER);

  if (frame  !=null)
  {
    frame.setResizable(true);
  }

  font1 = loadFont("Fonts/Playtime.vlw");

  character1 = new character("Sapphire", "LEFT");
  character2 = new character("Brock", "RIGHT");


  thegreensBG = loadImage("Backgrounds/Goldsmiths_Main_Building.jpg");
  labsBG = loadImage("Backgrounds/labimage.jpg");
  lectureBG = loadImage("Backgrounds/20150309_163721.jpg"); // filler image, need to be replaced
  filterimg = loadImage("Backgrounds/image.jpg");
  thegreensBG.resize(width, height);
  labsBG.resize(width, height);
  lectureBG.resize(width, height);

  currentbackground = thegreensBG;

  maxim = new Maxim(this);

  backgroundmusic = maxim.loadFile("Audio/justyce22-70-bpm-ethnic-victory.wav"); //music from http://www.looperman.com/loops/detail/82039
  ringtone = maxim.loadFile("Audio/New Tuturu.wav"); //sound effect from https://youtu.be/nuLeIpTGui0
  labmusic = maxim.loadFile("Audio/maxjc-sparkling-keys-loop.wav"); //sound effect http://www.looperman.com/loops/detail/46566
  labsounds = maxim.loadFile("Audio/labsoundsfaded.wav"); //sound effect recodeded in room 306
  labsounds.volume(0.6);
  v1 = new PVector(0, 0);
  v2 = new PVector(width, 0);
  v3 = new PVector(width, height);
  v4 = new PVector(0, height);

  textFont(font1);

  allBoids = new Boid[20];// fills the allboids array with boids

  frame.setTitle("Audio Visual Adventures - Jacky & Yuvesh"); //sets the name of the game window
}

void draw()
{
  if (!play)
  {
    menu();
  } else
  {
    if (paused)
    {
      pausescreen();
    } else
    {
      background(0); //not normally seen. this is for when the player resizes the window.
      // restrictwindow(); //temporrally removed as it was casuing the game to crash if players made the window too small.
      effects();
      if (shake)
      {
        translate(random(5), random(5));
      }

      drawbackground();

      if (shake)
      {
        translate(random(5), random(5));
      }

      pushMatrix();

      if (showcharacter1)
        character1.update();

      if (showcharacter2)
        character2.update();

      popMatrix();

      if (shake)
      {
        translate(random(4), random(4));
      }

      if (insertname)
      {
        textinput();
      }

      if (processing)
      {
        processingwindow();

        if (showfilters)
        {
          filters();
        }

        if (showboids)
        {
          drawboids();
        }
      }


      textbox();
    }
  }
}

void menu()
{
  background(#3F5D67);

  fill(50, 200);
  text("Audio Visual Adventures", width/2, height*0.1);

  if ( button("PLAY", height*0.5))
    play = true;
}

boolean button(String buttontext, float buttonheight)
{
  boolean x = false;
  fill(255, 200);
  rect(width/2, buttonheight, width*0.3, height*0.1);
  fill(0);
  textSize(40); 
  fill(50, 200);
  text(buttontext, width/2, buttonheight);

  if (mouseX >width*0.5-width*0.15 && mouseX < width*0.5+width*0.15)
  {
    if (mouseY >buttonheight-height*0.05 && mouseY < buttonheight+height*0.05)
    {
      if (mousePressed)
      {
        x = true;
        return x;
      }
    }
  }
  return x;
}

void drawbackground()
{
  v1.x = 0;
  v1.y = 0;
  v2.x = width;
  v2.y = 0;
  v3.x = width;
  v3.y = height;
  v4.x = 0;
  v4.y = height;
  noStroke();
  beginShape();
  texture(currentbackground);
  vertex(v1.x, v1.y, 0, 0);
  vertex(v2.x, v2.y, 1, 0);
  vertex(v3.x, v3.y, 1, 1);
  vertex(v4.x, v4.y, 0, 1);
  endShape(CLOSE);
}

void textinput()
{
  textSize(height/20);
  fill(255, 200);
  rect(width/2, height*0.45, width*0.4, height/5);
  fill(0);
  text("What is your name?", width/2, height*0.4);
  text(username, width/2, height/2);
  //text is edited in the void keyPressed funtion. if added in this function it detect each key per frame and trigger them multipul times making it very difficult to type
  //textinput concept taken from http://www.learningprocessing.com/examples/chapter-18/example-18-1/
}

void textbox()
{
  noStroke();

  pushStyle();
  fill(0, 100);
  rect(width*0.5, height*0.85, width*0.9, height*0.2);
  popStyle();

  pushStyle();
  fill(textcol);
  textSize((width+height/2)*0.015); 
  text(text, width*0.5, height*0.85, width*0.9, height*02);
  popStyle();

  if (mouseX < (width-width*0.9)/2 && mouseX > width-((width-width*0.9)/2))
  {
    pushStyle();
    fill(0, 100);
    popStyle();
  }
}

void restrictwindow()//is supossed to stop the screen getting smaller than a specified size 
{
  if (width < 400)
  {
    size(400, height, P2D);
  }

  if (height < 400)
  {
    size(width, 400, P2D);
  }
}

class character
{
  String name;
  PImage sprite1;
  float location;
  String loc;
  character(String n, String l )
  {
    name = n;
    sprite1 = loadImage("Characters/"+name+".png");
    loc = l;
  }

  void update()
  {
    sprite1.resize(0, int(height*0.8));

    if (loc == "LEFT")
      location = width*0.8;
    else
      location = width*0.2;

    image(sprite1, location, height - sprite1.height/2);
  }
}

void keyPressed()
{
  if (key == 'p' || key =='P')
    if (!insertname)
      paused = !paused;

  if (play && !paused)
  {
    if (key == ' ' && insertname == false)
    {
      updatetext();
    }
  }
  if (insertname)
  {
    if (key == '\n')//enter key will save the name and contine the game.
      updatetext();
    else
      if (keyCode == BACKSPACE)
      username ="";
    else 
      if (username == "" && key == ' ' || username.length() >12)//used to stop spaces being entered at the start of the name. also used to limit the charcter count
    {
    } else
      username = username + key;
  }
}

void mouseClicked()
{
  if (play && !insertname && !paused)
  {
    updatetext();
  }
}

void processingwindow()
{
  fill(0, 80);// draws the shadow of the processing window
  rect(width*0.3+width*0.005+height*0.005, height*0.4+width*0.01+height*0.005, width*0.5, height*0.5, 10);

  fill(0);//draws the main window part of the processing window
  rect(width*0.3, height*0.4, width*0.5, height*0.5, 0, 0, 5, 5);
  fill(215);//draws the window title bar
  rect(width*0.3, height*0.14, width*0.5, height*0.02, 5, 5, 0, 0);

  fill(10);//draws the text on the title bar
  textSize(height*0.02);
  text("AV_Project", width*0.3, height*0.14);
}

void updatetext()
{
  index++;
  String lines[] = loadStrings("data.txt");

  if (index >= lines.length )
  {
    index=0;
    play = false;
  }

  text = lines[index];
}

void drawboids()
{
  PVector centrePoint = null;
  if (mouseX > width*0.05 && mouseX < width*0.55 && mouseY > height*0.15 && mouseY < height*0.65)
    centrePoint = new PVector(mouseX, mouseY); 
  // draw all the boids
  for (int i = 0; i < allBoids.length; i++)
  {
    allBoids[i].draw(centrePoint);
  }
}

void filters()
{
  image(filterimg, width*0.3, height*0.4);
  if (keyPressed)
  {
    fill(200, 0, 0, 30);
    rect(width*0.3, height*0.4, width*0.5, height*0.5);
  }
}

void pausescreen()
{
  fill(255);
  textSize(height*0.1);
  text("PAUSED", width/2, height*0.05);

  fill(#4DD1FF, 20);
  rect(width*0.5, height*0.5, width*0.9, height*0.8);
  fill(#3CA3C6, 50);
  rect(width*0.15, height*0.5, width*0.2, height*0.8);

  fill(#4DD1FF, 50); //colors the area behind the text you hover over.
  if (mouseX >width*0.05 && mouseX < width*0.25 && mouseY < height*0.2 && mouseY > height*0.1)
  {  
    rect(width*0.15, height*0.15, width*0.2, height*0.1);
    if (mousePressed && pausestate != 0)
    { 
      pausestate = 0;
      fill(255);
      rect(width*0.5, height*0.5, width*0.9, height*0.8);
    }
  }
  if (mouseX >width*0.05 && mouseX < width*0.25 && mouseY < height*0.3 && mouseY > height*0.2)
  {  
    rect(width*0.15, height*0.25, width*0.2, height*0.1);
    if (mousePressed && pausestate != 1)
    {
      pausestate = 1;
      fill(255);
      rect(width*0.5, height*0.5, width*0.9, height*0.8);
    }
  }
  if (mouseX >width*0.05 && mouseX < width*0.25 && mouseY < height*0.4 && mouseY > height*0.3)
  {  
    rect(width*0.15, height*0.35, width*0.2, height*0.1);
    if (mousePressed && pausestate != 2)
    {   
      pausestate = 2;
      fill(255);
      rect(width*0.5, height*0.5, width*0.9, height*0.8);
    }
  }
  if (mouseX >width*0.05 && mouseX < width*0.25 && mouseY < height*0.5 && mouseY > height*0.4)
  {  
    rect(width*0.15, height*0.45, width*0.2, height*0.1);
  }
  if (mouseX >width*0.05 && mouseX < width*0.25 && mouseY < height*0.6 && mouseY > height*0.5)
  {  
    rect(width*0.15, height*0.55, width*0.2, height*0.1);
  }
  fill(255);
  textSize((width+height/2)*0.02);
  text(username, width*0.15, height*0.15);
  text(character1.name, width*0.15, height*0.25);
  text(character2.name, width*0.15, height*0.35);
  text("???", width*0.15, height*0.45);
  text("???", width*0.15, height*0.55);

  switch(pausestate) {
  case 0:
    text(username+ " stats", width*0.5, height*0.15);
    break;
  case 1:
    text(character1.name+" stats", width*0.5, height*0.15);
    break;
  case 2:
    text(character2.name+" stats", width*0.5, height*0.15);
    break;
  case 3:
    break;
  case 4:
    break;
  }
}

