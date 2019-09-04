class EvolutionGraph extends PApplet {
  
  EvolutionGraph() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
   
  void settings() {
    size(900,600); 
  }
   
  void setup() {
    background(150);
    frameRate(1);
  }
  
  void draw() {
    // portion of the evolution to draw
    int start = max( 0, evolution.size()-52 );
    int stop = start + 52;
    float top;
    if( evolution.size()<2 )
      top = 5;
    else
      top = max( ceil( 1.1 * evolution.get(evolution.size()-1)), 5 ); // the maximum plus 10%
    background(150);
      
    // Label "Generation"
    fill(255);
    strokeWeight(1);
    textSize(15);
    textAlign(CENTER,CENTER);
    text("Generation", width/2,height-20);

    // Graduation Generation
    textSize(10);
    textAlign(CENTER,CENTER);
    float x = 50;
    float y = height-35;
    for(int i=start; i<=stop; i++) {
      text(i,x,y); 
      x += 16;
    }
      
    // Label "Score"
    textSize(15);
    rotate(PI/2);
    textAlign(CENTER,CENTER);
    text("Score", (height-50) / 2 , -15);
    rotate(-PI/2);
      
    // Graduation Score
    textSize(10);
    textAlign(RIGHT,CENTER);
    float ybuff = (height-50) / top;
    y = height-50;
    float ydif = ybuff * (top/20);
    for(float i=0; i<top; i+=(top/20) ) {
      text( i, 40, y ); 
      y -= ydif;
    }

    // Drawing horizontal lines
    stroke(64);
    y = height-50;
    for(int i=0; i<200; i+=10) {
      line(50,y,width,y);
      y-=ydif;
    }

    // Bottom and left line of the graph
    stroke(64);
    strokeWeight(4);
    line(50,0,50,height-50);
    line(50,height-50,width,height-50);

    /**********************\
      Drawing of the curve
    \**********************/
    strokeWeight(2);
    //stroke(255,0,0);
    int oldScore = 0;  // starting Score
    if( evolution.size()>0 ) oldScore = evolution.get( start ); 
    int i = 0;
    int newscore = 0;
    stroke(128,255,128);
    for(int ix = start; ix < stop; ix++) {
      if( ix<evolution.size() ){
        newscore = evolution.get(ix);
        line( 50+(i*16), height-50-(oldScore*ybuff), 50+((i+1)*16), height-50-(newscore*ybuff));
        ellipse(  50+((i+1)*16), height-50-(newscore*ybuff) , 5 , 5);
        oldScore = newscore;
        i++;
      }
    }
  }

  void exit() {
    dispose();
    graph = null;
  }
}
