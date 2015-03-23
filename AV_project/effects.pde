
void effects()
{
  if (text.equals("BGmusicStart") == true)
  {
    backgroundmusic.play();
    updatetext();
  }
  if (text.equals("BGmusicStop") == true)
  {
    backgroundmusic.stop();
    updatetext();
  }
    if (text.equals("BGlabsStart") == true)
  {
    labmusic.play();
    updatetext();
  }
  if (text.equals("BGlabsStop") == true)
  {
    labmusic.stop();
    updatetext();
  }
    if (text.equals("LabSoundStart") == true)
  {
    labsounds.play();
    updatetext();
  }
  if (text.equals("LabSoundStop") == true)
  {
    labsounds.stop();
    updatetext();
  }
  if (text.equals("BG_GREENS") == true)
  {
    currentbackground = thegreensBG;    
    updatetext();
  }
  if (text.equals("BG_LABS") == true)
  {
    currentbackground = labsBG;    
    updatetext();
  }
  if (text.equals("SHAKE") == true)
  {
    shake = true;
    updatetext();
  }
  if (text.equals("STOPSHAKE") == true)
  {
    shake = false;
    updatetext();
  }
  if (text.equals("OPENPROCESSING") == true)
  {
    processing = true;
    updatetext();
  }
  if (text.equals("CLOSEPROCESSING") == true)
  {
    processing = false;
    updatetext();
  }
  if (text.equals("STARTBOIDS") == true)
  {
    for (int i = 0; i < allBoids.length; i++)
      allBoids[i] = new Boid();
    showboids = true;
    updatetext();
  }
  if (text.equals("STOPBOIDS") == true)
  {
    showboids = false;
    updatetext();
  }
  if (text.equals("RINGTONESTART") == true)
  {
    ringtone.play();
    backgroundmusic.volume(0.3);
    updatetext();
  }
  if (text.equals("RINGTONESTOP") == true)
  {
    ringtone.stop();
    backgroundmusic.volume(1);
    updatetext();
  }
}

