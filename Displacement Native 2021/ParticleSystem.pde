class ParticleSystem {

  ArrayList particles;
  PVector origin;
  PVector location;
  PVector vel;
  PVector acceleration;
  PVector speed;

  ParticleSystem(PVector location) {

    origin = location;
    speed = new PVector();


    particles = new ArrayList();
  }

  void addParticle(float lo, float hi) {

    
    particles.add(new Particle(origin, (new PVector(random(lo,hi), 0)), 1));
  };

  void moveSystem(PVector speed_) {

    speed.x = speed_.x;
    speed.y = speed_.y;

    origin.x = origin.x + speed.x;
    origin.y = origin.y + speed.y;
  }
  
  
  
  
  void systemCheck(int x ) {

    if ((origin.x>int(width*1.25)) || (origin.y>int(height*1.125))) {

      origin.x = x;
    }
  }




  void runTest() {

    Iterator<Particle> it = particles.iterator();

    while (it.hasNext()) {

      Particle p = it.next();
      p.run();
      if (p.isDead()) {

        it.remove();
      }
    }
  }

  void emitt() {



    Iterator<Particle>it = particles.iterator();

    while (it.hasNext()) {

      Particle p = it.next();


      p.run();


      if (p.isDead()) {

        it.remove();
      }
    }
  }
};
