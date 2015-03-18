class Boid
{
   PVector Pos;
   PVector Vel;
 
   float threshold = 10;
 
   Boid()
   {
       Pos = new PVector (random(width*0.05, width*0.55), random(height*0.15, height*0.65));
       Vel = new PVector (random(-2, 2), random(-2,2));
   }
 
   // bounce off the edges of the screen
   boolean walls()
   {
      if(Pos.x < width*0.05 || Pos.x > width*0.55)
      {
         Vel.x = - Vel.x;
         return true;
      }
      if(Pos.y < height*0.15 || Pos.y > height*0.65)
      {
         Vel.y = - Vel.y;
         return true;
      }
      return false;
   }
 
   // implement separation
   // search all other boids, and check
   // whether they are closer than the
   // separation threshold
   // Find the closest one, that is under
   // the threshold and move away from it
   // if non are under the threshold,
   // do nothing and return false
   boolean separation()
   {
       PVector VelChange = null;
       float currentMin = threshold;
       for (int i = 0; i < allBoids.length; i++)
       {
          // don't check against yourself
          if(allBoids[i] == this)
             continue;
          // check the distance is less
          // than the threshold or the
          // previously found closest boid
          if(Pos.dist(allBoids[i].Pos) < currentMin)
          {
             // set the current minimum distance to
             // this one
             currentMin =  Pos.dist(allBoids[i].Pos);
             // find the direction vector to the
             // closest boid
             VelChange = PVector.sub(allBoids[i].Pos,Pos);
             VelChange.normalize();
             // make it have a speed of 5 in the
             // opposite direction to the boid
             VelChange.mult(-5.0f);
          }
       }
       // check if you have got a velocity change
       // if so add it to the current velocity and
       // return true, otherwise false
       if(VelChange != null)
       {
          Vel.add(VelChange);
          return true;
       }
       else
       {
          return false;
       }
   }
 
   // perform cohesion
   // make all boids move towards either
   // the centre of the flock or a centre
   // point specified by the user
   void cohesion(PVector centrePos)
   {
       // if centrePos is null then set it to
       // the average position of all the boids
       if (centrePos == null)
       {
         centrePos = new PVector(0, 0);
         // add up all the positions of all
         // the boids
         for (int i = 0; i < allBoids.length; i++)
         {
            if(allBoids[i] == this)
               continue;
            centrePos.add(allBoids[i].Pos);
         }
         // divide by the number of boids
         centrePos.mult(1.0f/allBoids.length);
       }
       // create a velocity with speed 5 towards this
       // centre position
       PVector velchange = PVector.sub(centrePos,Pos);
       velchange.normalize();
       velchange.mult(5.0f);
       // add the new velocity to the current
       // velocity
       Vel.add(velchange);
   }
 
   // update the position of the boids
   void update(PVector centrePos)
   {
      // check if you need to bounce off the walls
      // if so do so, otherwise try separation
      // if you don't need to do separation
      // do cohesion
      if(!walls())
        if(!separation())
         cohesion (centrePos);
      // limit the velocity to a maximum
      // speed of 10 and then add it to the
      // current position
      Vel.limit(10.0f);
      Pos.add(Vel);
   }
 
   // update and draw the boids
   // centrePos is a point towards which
   // all boids should be heading
   // if you pass in null, they will move towards
   // the centre of the flock
   void draw(PVector centrePos)
   {
      // update the position of the boid
      update(centrePos);
      // draw it as a point
      stroke(255);
      strokeWeight(5);
      point(Pos.x, Pos.y);
   }
}

