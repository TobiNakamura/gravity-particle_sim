  body[] bodies;
  static int n = 5000;
  static float G;
  static int margin = 19; 
  
  public void setup() {
    size(displayWidth, displayHeight);
    
    G = 0.1f;
    
    bodies = new body[n];
    int i = 0;
    int y = 0;
    int x = 0;
    while(i < n){
      if(x > displayWidth / margin){
        x = 0;
        y++;
      }
      PVector init = new PVector(x*margin, margin*y);
      bodies[i] = new body(init);
      x++;
      i++;
    }
  }
  
  public void draw() {
    background(0xff0f0f0f);
    
    int i = 0;
    while(i < bodies.length - 1){
      int x = i + 1;
      while(x < bodies.length){
        
        float mag = G / sq(PVector.dist(bodies[i].position, bodies[x].position));
        PVector a;
        a  = PVector.sub(bodies[x].position, bodies[i].position);
        a.mult(mag);
        bodies[i].velocity.add(a);
        
        a = PVector.sub(bodies[i].position, bodies[x].position);
        a.mult(mag);
        bodies[x].velocity.add(a);
        
        x++;
      }
      
      i++;
    }
    
    noStroke();
    fill(0xffffffff);
    i = 0;
    while(i < bodies.length) {
      bodies[i].position.add(bodies[i].velocity);
      ellipse(bodies[i].position.x, bodies[i].position.y, 2, 2);
      i++;
    }
    
    
    textSize(50);
    text("t = " + millis() + " ms", 50, 50);
    
    saveFrame();
  }
  
  
  
  class body {
    PVector velocity;
    PVector position;
  
    public body(PVector position) {
      this.position = position;
      velocity = new PVector(0, 0);
    }

  }


