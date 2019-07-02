/*
Thomas Sanchez Lengeling.
http://codigogenerativo.com/

KinectPV2, Kinect for Windows v2 library for processing

Depth  and infrared Test
*/
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PImage depthThreshold;
PImage depthPrevious;
PImage filteredDisplay;
color trackColor; 
float threshold = 1;
float distThreshold = 15;
int[] dataMax = new int[512*424];
int[] kinect1 = new int[512*424];
color addC = color(1);
color empty = color(0);
color full = color(255);
color subC = color(0.1);
int increment = 0;

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D, 2);
  colorMode(HSB, 255, 255, 255);
  
  depthThreshold = createImage(512,424,RGB);
  depthPrevious = createImage(512,424,RGB);
  filteredDisplay = createImage(512,424,RGB);
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  trackColor = color(255,255,255);
  for(int i = 0; i < dataMax.length; i++)
  {
    dataMax[i] = 4500;
  }
  for(int i = 0; i < kinect1.length; i++)
  {
    kinect1[i] = 0;
  }
  
}

void draw() {
  if(increment % 2 == 1){
  background(0);
  }
  //get all the pixels
  loadPixels();
  depthThreshold.loadPixels();
  depthPrevious.loadPixels();
  filteredDisplay.loadPixels();
 
  /**************************************
  *        DEPTH MASKING                *
  **************************************/
  
  //pull the depth data
  //int [] rawData = kinect.getRawDepthData();
  
  //paint pixels that are within the constraints
  for(int i = 0; i < depthThreshold.width * depthThreshold.height; i++)
  {
     if (kinect1[i] > 1800 && kinect1[i] < 2500)
     {
       dataMax[i] = kinect1[i] - 1800;
       float c = map(dataMax[i], 0, 700, 0, 255);
       filteredDisplay.pixels[i] = color(c);
       if (depthThreshold.pixels[i] <= 0xf0f0f0){
          depthThreshold.pixels[i] += 0x0f0f0f;
       } else {
          depthThreshold.pixels[i] = 0xFFFFFF;
       }
     } else {
       if(depthThreshold.pixels[i] > 0x050505) {
         depthThreshold.pixels[i] -= 0x010101;
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
  image(filteredDisplay, width/2, 0, 1920, 1080);
  
  //update filter buffer
  depthPrevious = depthThreshold.get();
  //arrayCopy(rawData, dataPrev);

  //image(depthPrevious, 512, 0);

  stroke(255);
  text(frameRate, 50, height - 50);
 
}

void oscEvent(OscMessage theOscMessage) {
  
      kinect1[theOscMessage.get(0).intValue()] = theOscMessage.get(1).intValue();
      kinect1[theOscMessage.get(2).intValue()] = theOscMessage.get(3).intValue();
      kinect1[theOscMessage.get(4).intValue()] = theOscMessage.get(5).intValue();
      kinect1[theOscMessage.get(6).intValue()] = theOscMessage.get(7).intValue();
      kinect1[theOscMessage.get(8).intValue()] = theOscMessage.get(9).intValue();
      kinect1[theOscMessage.get(10).intValue()] = theOscMessage.get(11).intValue();
      kinect1[theOscMessage.get(12).intValue()] = theOscMessage.get(13).intValue();
      kinect1[theOscMessage.get(14).intValue()] = theOscMessage.get(15).intValue();
      kinect1[theOscMessage.get(16).intValue()] = theOscMessage.get(17).intValue();
      kinect1[theOscMessage.get(18).intValue()] = theOscMessage.get(19).intValue();
      kinect1[theOscMessage.get(20).intValue()] = theOscMessage.get(21).intValue();
      kinect1[theOscMessage.get(22).intValue()] = theOscMessage.get(23).intValue();
      kinect1[theOscMessage.get(24).intValue()] = theOscMessage.get(25).intValue();
      kinect1[theOscMessage.get(26).intValue()] = theOscMessage.get(27).intValue();
      kinect1[theOscMessage.get(28).intValue()] = theOscMessage.get(29).intValue();
      kinect1[theOscMessage.get(20).intValue()] = theOscMessage.get(21).intValue();
      kinect1[theOscMessage.get(22).intValue()] = theOscMessage.get(23).intValue();
      kinect1[theOscMessage.get(24).intValue()] = theOscMessage.get(25).intValue();
      kinect1[theOscMessage.get(26).intValue()] = theOscMessage.get(27).intValue();
      kinect1[theOscMessage.get(28).intValue()] = theOscMessage.get(29).intValue();
      return;
    
}



  
