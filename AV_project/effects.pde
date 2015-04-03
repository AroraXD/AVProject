//for an breif explianation of what each of these do please see the Refrence.txt file
void effects()
{
  if (text.equals("TEXTWHITE"))
  {
    textcol = color(255);    
    updatetext();
  }
  if (text.equals("TEXTBLUE"))
  {
    textcol = color(#6AD8FF);    
    updatetext();
  }
  if (text.equals("SHOWC1"))
  {
    showcharacter1 = true;
    updatetext();
  }
  if (text.equals("HIDEC1"))
  {
    showcharacter1 = false;
    updatetext();
  }
  if (text.equals("SHOWC2"))
  {
    showcharacter2 = true;
    updatetext();
  }
  if (text.equals("HIDEC2"))
  {
    showcharacter2 = false;
    updatetext();
  }
  if (text.equals("BGmusicStart"))
  {
    backgroundmusic.play();
    updatetext();
  }
  if (text.equals("BGmusicStop"))
  {
    backgroundmusic.stop();
    updatetext();
  }
  if (text.equals("BGlabsStart"))
  {
    labmusic.play();
    updatetext();
  }
  if (text.equals("BGlabsStop"))
  {
    labmusic.stop();
    updatetext();
  }
  if (text.equals("LabSoundStart"))
  {
    labsounds.play();
    updatetext();
  }
  if (text.equals("LabSoundStop"))
  {
    labsounds.stop();
    updatetext();
  }
  if (text.equals("BG_GREENS"))
  {
    currentbackground = thegreensBG;    
    updatetext();
  }
  if (text.equals("BG_LABS"))
  {
    currentbackground = labsBG;    
    updatetext();
  }
  if (text.equals("BG_LECTURE"))
  {
    currentbackground = lectureBG;    
    updatetext();
  }
  if (text.equals("SHAKE"))
  {
    shake = true;
    updatetext();
  }
  if (text.equals("STOPSHAKE"))
  {
    shake = false;
    updatetext();
  }
  if (text.equals("OPENPROCESSING"))
  {
    processing = true;
    updatetext();
  }
  if (text.equals("CLOSEPROCESSING"))
  {
    processing = false;
    updatetext();
  }
  if (text.equals("FILTERSOFF"))
  {
    showfilters = false;
    updatetext();
  }
  if (text.equals("FILTERSON"))
  {
    showfilters = true;
    updatetext();
  }
  if (text.equals("STARTBOIDS"))
  {
    for (int i = 0; i < allBoids.length; i++)
      allBoids[i] = new Boid();
    showboids = true;
    updatetext();
  }
  if (text.equals("STOPBOIDS"))
  {
    showboids = false;
    updatetext();
  }
  if (text.equals("RINGTONESTART"))
  {
    ringtone.play();
    backgroundmusic.volume(0.3);
    updatetext();
  }
  if (text.equals("RINGTONESTOP"))
  {
    ringtone.stop();
    backgroundmusic.volume(1);
    updatetext();
  }
  if (text.equals("TEXTINPUTSTART"))
  {
    insertname = true;
    updatetext();
  }
  if (text.equals("TEXTINPUTSTOP"))
  {
    insertname = false;
    updatetext();
  }

  if (text.equals("PLAYERNAME"))
  {
    text = username;
  }
}

