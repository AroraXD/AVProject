Maxim maxim; 
AudioPlayer backgroundmusic; 


boolean shake;

character character1;

String text = "text goes here";

int index = 0;

PImage background1;

void setup()
{
  size(900, 600, P2D);
  rectMode(CENTER);
  imageMode(CENTER);
  noStroke();
  if (frame  !=null)
  {
    frame.setResizable(true);
  }

  character1 = new character("Elsa");
  
  background1 = loadImage("Goldsmiths_Main_Building.jpg");
  background1.resize(width,height);

  maxim = new Maxim(this);

  backgroundmusic = maxim.loadFile("justyce22-70-bpm-ethnic-victory.wav"); //music from http://www.looperman.com/loops/detail/82039
}

void draw()
{
  restrictwindow();

  backgroundmusic.play();

  if (shake)
  {
    translate(random(5), random(5));
  }

  pushMatrix();

  background(background1);

  // image(elsa, width*0.8, height - elsa.height/2);
  character1.update();

  popMatrix();

  textbox();
}

void textbox()
{
  pushStyle();
  fill(0, 100);
  rect(width*0.5, height*0.85, width*0.9, height*0.2);
  popStyle();
  
  pushStyle();
  fill(255);
  text(text, width*0.1, height*0.8);
  popStyle();
  
  if(mouseX < (width-width*0.9)/2 && mouseX > width-((width-width*0.9)/2))
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

  String lines[] = loadStrings("data.txt");

  index++;
  if (index >= lines.length )
    index=0;

  text = lines[index];
}

