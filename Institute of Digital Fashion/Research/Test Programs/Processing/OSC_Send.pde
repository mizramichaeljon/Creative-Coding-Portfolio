import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress supercollider;

// OSC object
OscMessage myMessage = new OscMessage("/test");


void setup() {

  size(400, 400);
  // start oscP5, listening for incoming messages at port 12000
  // supercollider can send messages to port 12000 to influence Processing
  oscP5 = new OscP5(this, 12000);
  
  // allocate address variables to supercollider net address 
  // supercollider will receive messages on port 57120
  
  // all of this is localhost

  supercollider = new NetAddress("127.0.0.1", 57120);
}

void draw() {
  background(0);
}

void mouseMoved() {

  // sending OscMessages
  // everytime the mouse is moved a new OscMessage (myMessage) is created.
  // the value of mouseX is appended to the message (the value is mapped from  0 to width to 100 to 1000)
  // .send method sends osc message to specified address
  // .clear erases contents of message
  

  OscMessage myMessage = new OscMessage("/test");
  myMessage.add(map(mouseX, 0, width, 100, 1000));
  oscP5.send(myMessage, supercollider);
  myMessage.clear();


}
