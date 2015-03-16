Maxim maxim; 
AudioPlayer backgroundmusic; 

PFont font1;

boolean shake;

character character1;

String text = "text goes here";

int index = 0;

PImage background1;

PVector v1, v2, v3, v4;

boolean play = false;

void setup()
{
  size(900, 600, P2D);
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

  background1 = loadImage("Goldsmiths_Main_Building.jpg");

  background1.resize(width, height);
  maxim = new Maxim(this);

  backgroundmusic = maxim.loadFile("justyce22-70-bpm-ethnic-victory.wav"); //music from http://www.looperman.com/loops/detail/82039

  v1 = new PVector(0, 0);
  v2 = new PVector(width, 0);
  v3 = new PVector(width, height);
  v4 = new PVector(0, height);
  
  textFont(font1, 32);
}

void draw()
{
  if (!play)
  {
    menu();
  } else
  {
    restrictwindow();

    backgroundmusic.play();
    effects();
    if (shake)
    {
      translate(random(5), random(5));
    }

    beginShape();
    texture(background1);
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
  background(20, 60, 70);

  fill(255, 200);
  rect(width/2, height*0.5, width*0.3, height*0.1);
  fill(0);
  textSize(30); 
  text("play", width/2, height*0.5);
  fill(255);
  text("name of the game or something", width/2, height*0.1);

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
  pushStyle();
  fill(0, 100);
  rect(width*0.5, height*0.85, width*0.9, height*0.2);
  popStyle();

  pushStyle();
  fill(255);
  textSize(20); 
  text(text, width*0.5, height*0.8);
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
    sprite1 = loadImage(name+".png");
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
}

void mouseClicked()
{
  if (play)
  {
    String lines[] = loadStrings("data.txt");

    index++;
    if (index >= lines.length )
      index=0;

    text = lines[index];
  }
}

void effects()
{
  if (index == 6)
    shake = true;
  else
    shake = false;
}

