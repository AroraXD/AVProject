Maxim maxim; 
AudioPlayer backgroundmusic; 
AudioPlayer ringtone; 
AudioPlayer labmusic;
AudioPlayer labsounds;

PFont font1;

boolean shake;

character character1;

String text = "text goes here";

int index = 0;//controls which line of text the game reads.

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


Boid allBoids[]; //creates an array to store the boids

void setup()
{
  size(900, 600, P3D);
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

  character1 = new character("Sapphire");

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
}

void draw()
{
  if (!play)
  {
    menu();
  } else
  {
    // restrictwindow();
    effects();
    if (shake)
    {
      translate(random(5), random(5));
    }
    noStroke();
    beginShape();
    texture(currentbackground);
    vertex(v1.x, v1.y, 0, 0);
    vertex(v2.x, v2.y, 1, 0);
    vertex(v3.x, v3.y, 1, 1);
    vertex(v4.x, v4.y, 0, 1);
    endShape(CLOSE);

    if (shake)
    {
      translate(random(5), random(5));
    }

    pushMatrix();

    // image(elsa, width*0.8, height - elsa.height/2);
    character1.update();

    popMatrix();

    if (shake)
    {
      translate(random(4), random(4));
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

  v1.x = 0;
  v1.y = 0;
  v2.x = width;
  v2.y = 0;
  v3.x = width;
  v3.y = height;
  v4.x = 0;
  v4.y = height;
}

void menu()
{
  background(#D3CA0B);

  fill(255, 200);
  rect(width/2, height*0.5, width*0.3, height*0.1);
  fill(0);
  textSize(40); 
  fill(50, 200);
  text("PLAY", width/2, height*0.5);
  fill(50, 200);
  text("Audio Visual Adventures", width/2, height*0.1);

  if (mouseX >width*0.5-width*0.15 && mouseX < width*0.5+width*0.15)
  {
    if (mouseY >height*0.5-height*0.05 && mouseY < height*0.5+height*0.05)
    {
      if (mousePressed)
        play = true;
    }
  }
}
void textbox()
{
  noStroke();

  pushStyle();
  fill(0, 100);
  rect(width*0.5, height*0.85, width*0.9, height*0.2);
  popStyle();

  pushStyle();
  fill(255);
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

void restrictwindow()
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
  character(String n )
  {
    name = n;
    sprite1 = loadImage("Characters/"+name+".png");
    sprite1.resize(0, int(height*0.8));
  }

  void update()
  {
    image(sprite1, width*0.8, height - sprite1.height/2);
  }
}

void keyPressed()
{
  //if s key is pressed shake function will turn on/off
  if (key == 's')
    shake = !shake;

  if (play)
  {
    if (key == ' ')
    {
      updatetext();
    }
  }
}

void mouseClicked()
{
  if (play)
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
    fill(200,0,0,30);
    rect(width*0.3,height*0.4,width*0.5,height*0.5);
  }
}
