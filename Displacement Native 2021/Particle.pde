class Particle {

  PVector location;
  PVector velocity;
  PVector acceleration;


  float lifespan;
  float mass;

  Particle(PVector l, PVector a, float mass_) {

    location = l.get();
    acceleration = a.get();
    velocity = new PVector();

    mass = mass_;
    lifespan = 255;
  };

  void update() {

    lifespan -= lifespanTimer;
    velocity.add(acceleration);
    location.add(velocity);
  };

  void display() {

    
    ps.textSize(10);

    if (location.x>ps.width) {
      lifespan = 0;
      ps.fill(0, 0, 0, 0);
    } else {

      ps.fill(360, 0, 100, 100);
    }


    ps.text(int (random(minValue, maxValue)), location.x, location.y);
  };

  boolean isDead() {
    if (lifespan<0.0) {

      return true;
    } else {
      return false;
    }
  };

  void run() {
    display();
    update();
  };

  void applyForce(PVector force) {

    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
}
