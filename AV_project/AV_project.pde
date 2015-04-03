//Audio Visual Coursework 2
//by Jacky Wang && Yuvesh Tulsiani
//github: https://github.com/uveavanto/AVProject

Maxim maxim; 
AudioPlayer backgroundmusic; 
AudioPlayer ringtone; 
AudioPlayer labmusic;
AudioPlayer labsounds;

PFont font1;

boolean shake;//sets weather the shake function is on or off

character character1;
character character2;

boolean showcharacter1 = false;
boolean showcharacter2 = false;

color textcol = color(255);

String text = "text goes here";//text that is displayed in game.
String username ="Player";//the name the player gets called in the game.

int index = 0;//controls which line of text the game reads.
int loadtextfrom = 0; //used to pick which text file the game reads from.
int pausestate = 0; //sets which part of the pause menu the player is veiwing

PImage currentbackground;//used to store one of the other backgrounds
PImage thegreensBG;
PImage labsBG;
PImage lectureBG;
PImage filterimg;
PVector v1, v2, v3, v4;//vectors used for the background image.

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
  lectureBG = loadImage("Backgrounds/20150309_163721.jpg");
  filterimg = loadImage("Backgrounds/image.jpg");
  //thegreensBG.resize(width, height);
  //labsBG.resize(width, height);
  //lectureBG.resize(width, height);

  currentbackground = thegreensBG;

  maxim = new Maxim(this);

  backgroundmusic = maxim.loadFile("Audio/justyce22-70-bpm-ethnic-victory.wav"); //music from http://www.looperman.com/loops/detail/82039
  ringtone = maxim.loadFile("Audio/New Tuturu.wav"); //sound effect from https://youtu.be/nuLeIpTGui0
  labmusic = maxim.loadFile("Audio/maxjc-sparkling-keys-loop.wav"); //sound effect http://www.looperman.com/loops/detail/46566
  labsounds = maxim.loadFile("Audio/labsoundsfaded.wav"); //sound effect recodeded using a smartphone in room 306 during a AV lab
  labsounds.volume(0.6);//sets the volume to 60%
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
       restrictwindow(); //if the player resizes the window too small it stops the game from scaleing down below 400x400 
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
        translate(random(4), random(4));//this function is repeated 3 times to create a layer effect. otherwise the background,chracter and textbox all shake together.
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
  background(#3CA3C6);

  textSize(height*0.1);//we used proportions of height and width as variables as much as possible throughout the code to make sure it resizes properly.
  fill(50, 200);
  text("Audio Visual Adventures", width/2, height*0.1);

  if ( button("DAY 1", height*0.4))
  {
    play = true;
    loadtextfrom = 1;
  }
  if ( button("DAY 2", height*0.6))//day 2 is dlc (it is loaded from a server and can be changed later)
  { 
    play = true;
    loadtextfrom = 2;
  }
  if ( button("REPORT", height*0.8))
  {
    link("https://docs.google.com/document/d/1ifSaP82deqNTF_FHbHYPqJdykq9_STVKM4onr3VIlno/edit?usp=sharing", "_new"); 
  }
}

boolean button(String buttontext, float buttonheight) // we made a function for buttons. it returns either true or false if it has been pressed or not
{
  boolean x = false;
  fill(255, 200);
  rect(width/2, buttonheight, width*0.3, height*0.1);
  fill(0);
  textSize(height*0.06); 
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

void drawbackground()//draws the background 
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
  //text is edited in the void keyPressed funtion. if added in this function it detect each key per frame and trigger them multipule times making it very difficult to type
  //textinput concept taken from http://www.learningprocessing.com/examples/chapter-18/example-18-1/
}

void textbox()//draws the textbox at the bottom of the screen
{
  noStroke();

  pushStyle();
  fill(0, 150);
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
    size(400, height, P3D);
  }

  if (height < 400)
  {
    size(width, 400, P3D);
  }
}

void keyPressed()
{
  if (key == 'p' || key =='P')
    if (!insertname)
    {
      paused = !paused;
      pausestate = 0;//sets it so when the player views there own stats on the pause screen when they open it
    }

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

void updatetext()//adds 1 to the index and loads the next line of text
{
  index++;
  String lines[];
  switch(loadtextfrom)
  {
  case 1:
    String lines1[] = loadStrings("Day_1.txt");
    if (index >= lines1.length )
    {
      index=0;
      play = false;
    }
    text = lines1[index];
    break;
  case 2:
    String lines2[] = loadStrings("http://igor.gold.ac.uk/~ytuls045/AV/Day_2.txt");
    if (index >= lines2.length )
    {
      index=0;
      play = false;
    }
    text = lines2[index];
    break;
  }
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
  image(filterimg, width*0.3, height*0.4,width*0.5, height*0.5);
  if (keyPressed)
  {
    if (key == '1')
    {
      fill(200, 0, 0, 30);
      rect(width*0.3, height*0.4, width*0.5, height*0.5);
    }
    if (key == '2')
    {
      fill(200, 200, 200, 20);
      rect(width*0.3, height*0.4, width*0.5, height*0.5);
    }
     if (key == '3')
    {
      fill(0, 200, 0, 20);
      rect(width*0.3, height*0.4, width*0.5, height*0.5);
    }
     if (key == '4')
    {
      fill(10, 10, 10, 40);
      rect(width*0.3, height*0.4, width*0.5, height*0.5);
    }
     if (key == '5')
    {
      fill(0, 0, 200, 20);
      rect(width*0.3, height*0.4, width*0.5, height*0.5);
    }
  }
}

