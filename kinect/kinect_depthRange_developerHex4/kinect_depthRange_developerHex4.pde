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
int[] dataMax = new int[512*424];
color addC = color(1);
color empty = color(0);
color full = color(255);
color subC = color(0.1);
int increment = 0;
float theLfo;

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D, SPAN);
  colorMode(HSB, 255, 255, 255);
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();
  depthThreshold = createImage(512,424,RGB);
  depthPrevious = createImage(512,424,RGB);
  filteredDisplay = createImage(512,424,RGB);
  
  trackColor = color(255,255,255);
  for(int i = 0; i < dataMax.length; i++)
  {
    dataMax[i] = 4500;
  }
  theLfo = 0;
  
}

void draw() {
  //if(increment % 2 == 1){
  background(0);
  //}
  //get all the pixels
  loadPixels();
  depthThreshold.loadPixels();
  depthPrevious.loadPixels();
  filteredDisplay.loadPixels();
  blobs.clear();
  theLfo += 0.1;
  
  /**************************************
  *        DEPTH MASKING                *
  **************************************/
  
  //pull the depth data
  int [] rawData = kinect.getRawDepthData();
  
  //paint pixels that are within the constraints
  for(int i = 0; i < depthThreshold.width * depthThreshold.height; i++)
  {
     if (rawData[i] > 1800 && rawData[i] < 2500)
     {
       dataMax[i] = rawData[i] - 1800;
       float c = dataMax[i] * (theLfo % 20);
       filteredDisplay.pixels[i] = color(c % 255, (c + 16) % 255);
       if (depthThreshold.pixels[i] <= 0xf0f0f0){
          depthThreshold.pixels[i] -= 0x0f0f0f;
       } else {
          depthThreshold.pixels[i] = 0xFFFFFF;
       }
     } else {
       if(depthThreshold.pixels[i] < 0x050505) {
         depthThreshold.pixels[i] += 0x010101;
       } else {
         depthThreshold.pixels[i] = 0x000000;
       }
     }
  }
  

 /*
  for(int i = 0; i < depthThreshold.width * depthThreshold.height; i++)
  {
    filteredDisplay.pixels[i] = color(increment % 255, (increment*increment) % 255, 255);
  }
  */
  
  
  increment = increment + 1;
  
  depthThreshold.updatePixels();
  filteredDisplay.updatePixels();
  
  //display filtered data
  filteredDisplay.mask(depthThreshold);
  image(filteredDisplay, 0, 0, 1368, 940);
  
  //update filter buffer
  depthPrevious = depthThreshold.get();
  //arrayCopy(rawData, dataPrev);

  //image(depthPrevious, 512, 0);

  stroke(255);
  text(frameRate, 50, height - 50);
  
  /***********************************
  *         BLOB TRACKING            *
  ***********************************/
  /*
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
  */
}


float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

  
