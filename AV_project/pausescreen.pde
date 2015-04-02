void pausescreen()
{
  fill(255);
  textSize(height*0.1);
  text("PAUSED", width/2, height*0.05);

  fill(#4DD1FF, 20);
  rect(width*0.5, height*0.5, width*0.9, height*0.8);
  fill(#3CA3C6, 200);
  rect(width*0.15, height*0.5, width*0.2, height*0.8);

  fill(#4DD1FF, 50); //colors the area behind the text you hover over.
  if (mouseX >width*0.05 && mouseX < width*0.25 && mouseY < height*0.2 && mouseY > height*0.1)
  {  
    rect(width*0.15, height*0.15, width*0.2, height*0.1);
    if (mousePressed && pausestate != 0)
    { 
      pausestate = 0;
      fill(#3CA3C6);
      rect(width*0.5, height*0.5, width*0.9, height*0.8);
    }
  }
  if (mouseX >width*0.05 && mouseX < width*0.25 && mouseY < height*0.3 && mouseY > height*0.2)
  {  
    rect(width*0.15, height*0.25, width*0.2, height*0.1);
    if (mousePressed && pausestate != 1)
    {
      pausestate = 1;
      fill(#3CA3C6);
      rect(width*0.5, height*0.5, width*0.9, height*0.8);
    }
  }
  if (mouseX >width*0.05 && mouseX < width*0.25 && mouseY < height*0.4 && mouseY > height*0.3)
  {  
    rect(width*0.15, height*0.35, width*0.2, height*0.1);
    if (mousePressed && pausestate != 2 && character2.unlocked)
    {   
      pausestate = 2;
      fill(#3CA3C6);
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

  if (character1.unlocked)
    text(character1.name, width*0.15, height*0.25);
  else
    text("???", width*0.15, height*0.25);

  if (character2.unlocked)
    text(character2.name, width*0.15, height*0.35);
  else
    text("???", width*0.15, height*0.35);

  text("???", width*0.15, height*0.45);
  text("???", width*0.15, height*0.55);

  switch(pausestate) {
  case 0:
    fill(255, 15);
    rect(width*0.6, height*0.75, width*0.7, height*0.3);
    for (float i = 0.4; i <1; i+=0.2)//draws 3 rectangles in the inventory section
    {
      pushMatrix();
      translate(width*i, height*0.76);
      fill(255, 30);
      rect(0, 0, width*0.15, height*0.2);
      popMatrix();
    }
    fill(255);
    text(username+ "'s stats", width*0.6, height*0.15);
    text("Inventory", width*0.6, height*0.63);
    String pstats[] = loadStrings("Characters/player_stats.txt");
    for (int i =0; i < pstats.length; i++)
    {
      text(pstats[i], width*0.6, height*0.25+(height*i*0.07));
    }
    break;
  case 1:
    text(character1.name+"'s stats", width*0.6, height*0.15);
    String c1stats[] = loadStrings("Characters/"+character1.name+"_stats.txt");
    for (int i =0; i < c1stats.length; i++)
    {
      text(c1stats[i], width*0.6, height*0.25+(height*i*0.07));
    }
    break;
  case 2:
    text(character2.name+"'s stats", width*0.6, height*0.15);
    String c2stats[] = loadStrings("Characters/"+character2.name+"_stats.txt");
    for (int i =0; i < c2stats.length; i++)
    {
      text(c2stats[i], width*0.6, height*0.25+(height*i*0.07));
    }
    break;
  case 3:
    break;
  case 4:
    break;
  }
}

