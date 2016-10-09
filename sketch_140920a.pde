  body[] bodies;
  static int n = 500;
  static float G;
  static int margin = 19; 
  float[] KE;
  int cycle = 0;
  static int skipNum = 3;
  int imageCycle = 0;
  
  public void setup() {
    size(1280, 720);
    
    G = 0.01f;
    
    KE = new float[width];
    bodies = new body[n];
    //one();
    two();
  }
  
  public void one(){
    int i = 0;
    int y = 0;
    int x = 0;
    while(i < n){
      if(x > width / margin){
        x = 0;
        y++;
      }
      PVector init = new PVector(x*margin, margin*y);
      bodies[i] = new body(init);
      x++;
      i++;
    }
  }
  
  public void two(){
    int i = 0;
    while(i < n){
      bodies[i] = new body(new PVector((width/2)-random(-height/2, height/2),(height/2)-random(-height/2, height/2),random(-height/2, height/2)));
      bodies[i].velocity.set(random(-1, 1), random(-1, 1),  random(-1, 1));
      i++;
    }
  }
  
  
  public void draw() {
    background(0xff0f0f0f);
    
    boolean skip;
    if (cycle > skipNum){
      skip = true;
      cycle = 0;
    }else{skip = false;}
    
    if(skip){
    for (int i = 0; i < width-1; i++) {                
      KE[i] = KE[i+1];
    }
    KE[width-1] = 0;
    }
    
    for(int i = 0; i < bodies.length - 1; i++){
      for(int x = i + 1; x < bodies.length; x++){
        
        float mag = G / sq(PVector.dist(bodies[i].position, bodies[x].position));
        PVector a;
        a  = PVector.sub(bodies[x].position, bodies[i].position);
        a.mult(mag);
        bodies[i].velocity.add(a);
        
        a = PVector.sub(bodies[i].position, bodies[x].position);
        a.mult(mag);
        bodies[x].velocity.add(a);
      }
      if(skip){
      KE[width-1] += bodies[i].velocity.mag();
      }
    }
   
   if(skip){
   pow(KE[width-1],2);
   KE[width-1] *= 0.5*n;
   }
   stroke(#FA0000);
   noFill();
   beginShape();
   for (int i = 0; i < width; i++){
     vertex(i, height-(KE[i]/(n*2.5)));
   }
   endShape();
    
    noStroke();
    colorMode(HSB, 255);
    for(int i = 0; i < bodies.length; i++){
      fill(abs(255*bodies[i].position.z*2/height),255,255);
      bodies[i].position.add(bodies[i].velocity);
      ellipse(bodies[i].position.x, bodies[i].position.y, 2, 2);
    }
    
    fill(#ffffff);
    textSize(20);
    text("t = " + millis() + " ms", 50, 50);
    
    if (imageCycle>10){
      //saveFrame();
      imageCycle=0;
    }else{imageCycle++;}
    
    cycle++;
  }
  
  
  
  class body {
    PVector velocity;
    PVector position;
  
    public body(PVector position) {
      this.position = position;
      velocity = new PVector(0, 0);
    }

  }


