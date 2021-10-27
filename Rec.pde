final String sketchname = getClass().getName();
final int SECONDS_TO_CAPTURE = 30;
final int VIDEO_FRAME_RATE = 30;

import com.hamoid.*;
VideoExport videoExport;

void rec() {


  if (frameCount ==1) {
    videoExport = new VideoExport(this, "../"+sketchname+".mov");
    videoExport.setFrameRate(30);  
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}
