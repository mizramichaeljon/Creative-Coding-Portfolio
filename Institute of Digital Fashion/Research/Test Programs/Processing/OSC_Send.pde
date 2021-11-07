import netP5.*;
import oscP5.*;


OscP5 oscP5;
NetAddress supercollider;
int on = 1;

void setup() {

  size(400, 400);

  oscP5 = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57120);
}

void draw() {
}

void mouseMoved() {

  float sustain = 0.1;
  float mouseMapFreq = map(mouseX, 0, width, -1.0, 1.0);
  float mouseMapAmp = map(mouseY, 0, height, 0.5, 0.0);
  //float mapSustain = map(sustain,mouseMapFreq,mouseMapAmp,0.01,0.3);

  OscMessage message = new OscMessage("/mouse");
  message.add(mouseMapFreq);
  message.add(mouseMapAmp);
  //message.add(mapSustain);
  oscP5.send(message, supercollider);
  message.clear();
}

void mousePressed() {

  if (mouseButton == LEFT) {
    OscMessage message = new OscMessage("/off");
    message.add(0);
    oscP5.send(message, supercollider);
    message.clear();
    on = 1;
  }

  if (mouseButton == RIGHT) {
    OscMessage message = new OscMessage("/on");
    message.add(on);
    oscP5.send(message, supercollider);
    message.clear();
    on = on + 1;
  }
}
