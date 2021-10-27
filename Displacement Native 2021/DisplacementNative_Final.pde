import java.util.*;
import oscP5.*;
import netP5.*;
import processing.video.*;

// VARIABLES 

OscP5 oscP5;
NetAddress supercollider;

ArrayList<ParticleSystem>systems;
float lifespanTimer = 1;
float maxValue;
float minValue;


JSONArray wholeFileArray;
JSONObject wholeFile;
JSONArray timeseries;
JSONObject dataObject;
int index;
int imgIndex;

int individuals [];
int singleValue [];
float mappedValue [];
float mappedValuePI [];
float individualsLerp[];
float individualsSqrt[];
float individualsDist[];
String date[];

Movie vid;
Movie [] vids = new Movie[3];

PGraphics topBand, midBand, lowBand, mask, dateText;
PGraphics ps;
PGraphics canvas;
PImage img;
PImage [] imgs = new PImage [3];
PImage movieCanvas;
PImage [] moviesCanvas = new PImage[3];

int sweep1, sweep2, sweep3;

static final int SCALE = 4, DELAY = 5000, SMOOTH = 3, FPS = 10; 


void setup() {

  /// SETUP///
  
  //INIT WINDOW SIZE , COLOR MODE, OSC CONNECTIVITY
  
  size(960, 540);
  //size(1920, 1080);
  colorMode(HSB, 360, 100, 100, 100);
  surface.setLocation(0, 0);
  smooth(SMOOTH);
  oscP5 = new OscP5(this, 12000);
  supercollider = new NetAddress ("127.0.0.1", 57120);

  //INIT THE DRAWING CANVASES
  
  canvas = createGraphics(width/2, height/2);
  ps = createGraphics(canvas.width, int(canvas.height*0.33));
  mask = createGraphics(canvas.width, int(canvas.height*0.33));
  topBand = createGraphics(canvas.width, int(canvas.height*0.33));
  midBand = createGraphics(canvas.width, int(canvas.height*0.33));
  lowBand = createGraphics(canvas.width, int(canvas.height*0.33));
  dateText = createGraphics(width/4, height/8);

  //INIT VIDEO FUNCTION, INTERACTION VARIABLES
  
  initVideo();
  sweep1 = 0;
  sweep2 = canvas.width;
  sweep3 = int(width*1.10);

  //INIT PARTICLE SYSTEM 
  
  systems= new ArrayList<ParticleSystem>();
  for (int j = int(ps.height*0.0); j<=int(ps.height*1.0); j+=10) {
    systems.add(new ParticleSystem(new PVector(int(ps.width*0.0-100), j)));
  }
  
  //INIT JSON DATA 


  wholeFile = loadJSONObject("https://data2.unhcr.org/population/get/timeseries?widget_id=239457&sv_id=4&population_collection=24&frequency=day&fromDate=2013-01-01");
  timeseries = wholeFile.getJSONObject("data").getJSONArray("timeseries");

  individuals = new int[timeseries.size()];
  date = new String[timeseries.size()];

  for (int j = 0; j<timeseries.size(); j++) {
    dataObject = timeseries
      .getJSONObject(j);

    individuals[j] = dataObject.getInt("individuals");
    date[j] = dataObject.getString("data_date");
  };

  minValue = float(min(individuals));
  maxValue = float(max(individuals));
  
  
}


void draw() {
  
  background(360, 0, 100, 100);

 //INTERACTION VARIABLES, CONDITIONAL LOGIC 
  sweep1 += 1;
  sweep2 += 1;
  sweep3 +=1;

  if (index >=timeseries.size()-1) {
    index=0;
  };

  if (sweep1>width*1.25) {
    sweep1 = 0;
  }
  if (sweep2>width*1.25) {
    sweep2 = 0;
  }
  if (sweep3>width*1.25) {
    sweep3 = 0;
  }
  

  //MATRIX VARIABLES 
    
    //MAIN CANVAS MATRIX 

  pushMatrix();
  translate(width*0.25, height*0.25);
  
      //PARTICLE SYSTEM MATRIX, PARTICLE SYSTEM CANVAS

  pushMatrix();
  translate(0, canvas.height*0.33);
  ps.beginDraw();
  ps.colorMode(HSB, 360, 100, 100, 100);
  ps.background(360, 0, 0, 100);
  
  for (ParticleSystem ps : systems) {
    ps.addParticle(random(0.0, 100.0), 0);  
    ps.emitt();
   
  }
  ps.endDraw();
  image(ps, 0, 0);
  popMatrix();
  
      //END PARTICLE SYSTEM MATRIX, PARTICLE SYSTEM CANVAS

      //VIDEO MATRIX, VIDEO CANVAS 
 
  canvas.beginDraw();
  canvas.background(0, 0, 0, 0);
       
        //COMMENT, UNCOMMENT TO ENABLE MASK BAND (TOP,MIDDLE,LOW)     
         
          //TOP BAND MATRIX, CANVAS
          
  pushMatrix();
  translate(0, 0);
  topBand.beginDraw();
  topBand.loadPixels();
  for (int x = 0; x<canvas.width; x++) {
    for (int y = 0; y<int(canvas.height*0.33); y++) {
      int topBandPixels = x + y*canvas.width;
      int moviePixels = int(x) + int((y+vids[0].height*0.66)*vids[0].width);

      float h = hue(vids[0].pixels[moviePixels]);
      float s = saturation(vids[0].pixels[moviePixels]);
      float br = brightness(vids[0].pixels[moviePixels]);
      float a = alpha(vids[0].pixels[moviePixels]);

      int movie = color(h, s, br, a);

      int mask = color(0, 0, 0, 0);

      if (sweep2>x+width*0.25 && sweep2<x+width*0.75) {
        topBand.pixels[topBandPixels] = mask;
      } else {
        topBand.pixels[topBandPixels] = movie;
      }
    }
  }
  topBand.updatePixels();
  topBand.background(250, 50, 100, 100);
  topBand.textSize(36);
  topBand.fill(0, 0, 0, 100);
  topBand.text("topBand", 0, topBand.height/2);

  topBand.endDraw();
  image(topBand, 0, 0);
  popMatrix();
  
          //TOP BAND MATRIX, CANVAS END
          
          //MID BAND MATRIX, CANVAS
          
  pushMatrix();
  translate(0, int(canvas.height*0.33));

  midBand.beginDraw();
  midBand.loadPixels();
  for (int x = 0; x<canvas.width; x++) {
    for (int y = 0; y<int(canvas.height*0.33); y++) {
      int midBandPixels = x + y*canvas.width;
      int moviePixels = int(x) + int((y+moviesCanvas[0].height*0.66)*moviesCanvas[0].width);

      float h = hue(moviesCanvas[0].pixels[moviePixels]);
      float s = saturation(moviesCanvas[0].pixels[moviePixels]);
      float br = brightness(moviesCanvas[0].pixels[moviePixels]);
      float a = alpha(moviesCanvas[0].pixels[moviePixels]);


      int movie = color(360, s*1.35, br*0.5, a);
      int mask = color(0, 0, 0, 0);

      if (sweep1>x+width*0.25 && sweep1<x+width*0.75) {
        midBand.pixels[midBandPixels] = mask;
      } else {
        midBand.pixels[midBandPixels] = movie;
      }
    }
  }



  midBand.updatePixels();
  midBand.background(250, 50, 100, 100);
  midBand.textSize(36);
  midBand.fill(0, 0, 0, 100);
  midBand.text("midBand", 0, midBand.height/2);
  midBand.endDraw();
  image(midBand, 0, 0);
  popMatrix();
  
          //MID BAND MATRIX, CANVAS END 
          
          //LOW BAND MATRIX, CANVAS


    pushMatrix();
    translate(0, int(canvas.height*0.66));
    lowBand.beginDraw();
    lowBand.loadPixels();

    for (int x = 0; x<canvas.width; x++) {
      for (int y = 0; y<int(canvas.height*0.33); y++) {
        int lowBandPixels = x + y*canvas.width;
        int moviePixels = int(x) + int((y+vids[2].height*0.66)*vids[2].width);

        float h = hue(vids[2].pixels[moviePixels]);
        float s = saturation(vids[2].pixels[moviePixels]);
        float br = brightness(vids[2].pixels[moviePixels]);
        float a = alpha(vids[2].pixels[moviePixels]);

        int movie = color(h, s, br, a);
        int mask = color(0, 0, 0, 0);

        if (sweep3>x+width*0.25 && sweep3<x+width*0.75) {
          lowBand.pixels[lowBandPixels] = mask;
        } else {
          lowBand.pixels[lowBandPixels] = movie;
        }
      }
    }
    lowBand.updatePixels();
    lowBand.background(150, 75, 100, 100);
    lowBand.textSize(36);
    lowBand.fill(0, 0, 0, 100);
    lowBand.text("lowBand", 0, lowBand.height/2);
    lowBand.endDraw();
    image(lowBand, 0, 0);
    popMatrix();
    
          //LOW BAND MATRIX, CANVAS END
          
      
  canvas.endDraw();
  image(canvas, 0, 0);
  popMatrix();
      //VIDEO MATRIX, VIDEO CANVAS END
      
      //DATA - DATE CANVAS
      
  dateText.beginDraw();
  dateText.colorMode(HSB, 360, 100, 100, 100);
  dateText.noStroke();
  dateText.background(360, 0, 0, 0);
  dateText.fill(360, 0, 0, 100);
  dateText.textSize(10);
  dateText.text(countArray(date), dateText.width*0.5, dateText.height*0.5);
  dateText.endDraw();
  image(dateText, int(width*0.0), int(height*0.85));
  
      //DATA - DATE CANVAS END
      
      //RECORD FUNCTION
      
      //rec();
}


// FUNCTIONS 

    //VIDE EXPORT KEY

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
} 

    //VIDEO LOADER
    
void initVideo() {

  colorMode(HSB, 360, 100, 100, 100);

  for (int i = 0; i<vids.length; i++) {
    vids[i] = new Movie(this, "migrant_video_dn_clips/migrant" + nf(i+1, 3) + ".mp4");
    vids[i].play();
    vids[i].speed(1);
    //vid.loop();
    vids[i].volume(0);

    while (vids[i].height == 0) delay(DELAY);
  }
}


    //VIDEO RESIZER , MOVIE PLAYER

void movieEvent(Movie m) {


  for (int i = 0; i<vids.length; i++) {
    m.read();
    imgs[i] = m.get();
    imgs[i].resize(imgs[i].width, imgs[i].height);
    moviesCanvas[i] = imgs[i];
  }
}

    //OSC MESSANGER 

void oscEvent(OscMessage msg) {

  if (msg.checkAddrPattern("data")) {
    int x = msg.get(0).intValue();
    if ((x==1)) {
      imgIndex= int(random(0, vids.length-1));
      index +=1;
      println(x);
    }
  }
}

    //DATA PARSING FUNCTIONS 
    

String countArray( String[]arr) {
  String data = arr[index];
  return data;
}


float countArray( float[]arr) {
  float data = arr[index];
  return data;
}

int countArray( int[]arr) {
  int data = arr[index];
  return data;
}
