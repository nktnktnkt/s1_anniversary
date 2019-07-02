/*
Thomas Sanchez Lengeling.
http://codigogenerativo.com/

KinectPV2, Kinect for Windows v2 library for processing

Depth  and infrared Test
*/

import KinectPV2.*;

KinectPV2 kinect;

PImage depthThreshold;
PImage depthPrevious;
PImage filteredDisplay;
ArrayList <Blob> blobs = new ArrayList<Blob>();
color trackColor; 
float threshold = 1;
float distThreshold = 15;

void setup() {
  size(1024, 424, P3D);
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();
  depthThreshold = createImage(512,424,RGB);
  depthPrevious = createImage(512,424,RGB);
  filteredDisplay = createImage(512,424,RGB);
  trackColor = color(255,255,255);
}

void draw() {
  
  //get all the pixels
  loadPixels();
  depthThreshold.loadPixels();
  depthPrevious.loadPixels();
  filteredDisplay.loadPixels();
  blobs.clear();
 
  /**************************************
  *        DEPTH MASKING                *
  **************************************/
  
  //pull the depth data
  int [] rawData = kinect.getRawDepthData();
  
  //paint pixels that are within the constraints
  for(int i = 0; i < depthThreshold.width * depthThreshold.height; i++)
  {
    if(rawData[i] < 4300 && rawData[i] > 2000) {
      depthThreshold.pixels[i] = color(255);
    } else {
      depthThreshold.pixels[i] = color(0);
    }
  }
  depthThreshold.updatePixels();
  
  //filter noise by checking previous state
  for(int i = 0; i < depthThreshold.width * depthThreshold.height; i++)
  {
    if(depthThreshold.pixels[i] == color(255) && 
       depthPrevious.pixels[i] == color(255) )
    {
      filteredDisplay.pixels[i] = color(255);
    } else {
      filteredDisplay.pixels[i] = color(0);
    }
  }
  filteredDisplay.updatePixels();
  
  //display filtered data
  image(filteredDisplay, 0, 0);
  
  //update filter buffer
  depthPrevious = depthThreshold.get();
  
  //image(depthPrevious, 512, 0);

  stroke(255);
  text(frameRate, 50, height - 50);
  
  
  /***********************************
  *         BLOB TRACKING            *
  ***********************************/
  
  // Begin loop to walk through every pixel
  for (int x = 0; x < filteredDisplay.width; x++ ) {
    for (int y = 0; y < filteredDisplay.height; y++ ) {
      int loc = x + y * filteredDisplay.width;
      // What is current color
      color currentColor = filteredDisplay.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {

        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }

  for (Blob b : blobs) {
    if (b.size() > 500) {
      b.show();
    }
  }
}


float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

  
