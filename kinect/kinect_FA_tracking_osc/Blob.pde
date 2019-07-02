class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;

  Blob(float x, float y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
  }

  void show() {
    if((maxx - minx) > 30 && (maxy - miny) > 30){
      
    stroke(0,255,0);
    fill(255,0);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(minx, miny, maxx, maxy);
    OscMessage myMessage = new OscMessage("/body");
    float centerX = (minx + maxx) / 2;
    float centerY = (miny + maxy) / 2;
    float translatedX = ((1024 - centerX)/1024)*1920;
    float translatedY = ((424 - centerY)/424)*1080;
    //println(translatedX);
    myMessage.add((int)translatedX); /* add an int to the osc message */
    myMessage.add((int)translatedY);
    /* send the message */
    oscP5.send(myMessage, myRemoteLocation); 
    }
  }
  
  void add(float x, float y) {
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
  }
  
  float size() {
    return (maxx-minx)*(maxy-miny); 
  }

  boolean isNear(float x, float y) {
    float cx = max(min(x, maxx), minx);
    float cy = max(min(y, maxy), miny);
    //float cy = (miny + maxy) / 2;

    float d = distSq(cx, cy, x, y);
    
    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}
