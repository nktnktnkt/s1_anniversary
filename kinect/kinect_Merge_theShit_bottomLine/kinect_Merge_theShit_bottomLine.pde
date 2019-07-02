/******************************************************************
 
 S 1 A N N I V E R S A R Y P A R T Y
 
 ***************************************************************/

import oscP5.*;
import netP5.*;
import themidibus.*;
import KinectPV2.*;

KinectPV2 kinect;
MidiBus myBus; 
MidiBus myBus2;
OscP5 oscP5;
NetAddress myRemoteLocation;

//Q U I N N
float carpetValue;
float carpetNum;
float carpetHue;
float thresholdVal;

PImage depthThreshold;
PImage depthPrevious;
PImage filteredDisplay;
PImage displayMerge;
int[] dataMax = new int[512*424];
int[] mergeArray = new int[1024*424];
boolean toggle = false;
int increment = 0;
float theLfo;

/*****************************************
 Yo the other kinect is coming in hottttt
 *****************************************/
int[] dataMax2 = new int[512*424];
int[] kinect1 = new int[512*424];


void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D, SPAN);
  colorMode(HSB, 255, 255, 255);

  //KINECT STUFF
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();

  //Pimage inits
  depthThreshold = createImage(1024, 424, RGB);
  depthPrevious = createImage(1024, 424, RGB);
  filteredDisplay = createImage(1024, 424, RGB);

  //OSC RECIEVE THE MF OTHER KINECT RAW DEPTH
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  //trackColor = color(255,255,255);

  //THIS FOR KINECT PLUGED INTO HERE
  for (int i = 0; i < dataMax.length; i++)
  {
    dataMax[i] = 4500;
  }

  //DOI
  theLfo = 0;

  myBus = new MidiBus(this, 0, -1); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  myBus2 = new MidiBus(this, 1, -1); 

  /**************************************************
   Initialize the other kinect data arrays
   *************************************************/
  for (int i = 0; i < dataMax.length; i++)
  {
    dataMax2[i] = 4500;
  }
  for (int i = 0; i < kinect1.length; i++)
  {
    kinect1[i] = 0;
  }
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


  theLfo += 0.1;

  /**************************************
   *        DEPTH MASKING                *
   **************************************/

  //pull the depth data
  int [] rawData = kinect.getRawDepthData();
  int cR = 0;
  int cL = 0;

  //paint pixels that are within the constraints
  for (int i = 0; i < depthThreshold.width * depthThreshold.height; i++)
  {
    
    if (i % 512 == 0) 
    {
      toggle = toggle ? false : true;
    }

    if (toggle == true) {

      if (rawData[cR] > 1800 && rawData[cR] < 2500)
      {
        
        dataMax[cR] = rawData[cR] - 1800;
        float c = dataMax[cR] * (theLfo % 20);
        carpetHue = map(lerp(carpetNum, carpetHue, 0.001), 1, 20, 1, 255);

        //filteredDisplay.pixels[i] = color(c % 255, (c + carpetNum) % 255);

        filteredDisplay.pixels[i] = color(carpetHue, 200, 200, (c + carpetNum) % 255);

        if (depthThreshold.pixels[i] <= 0xf0f0f0) 
        {
          depthThreshold.pixels[i] -= 0x0f0f0f;
        } else {
          depthThreshold.pixels[i] = 0xFFFFFF;
        }
      } else {
        if (depthThreshold.pixels[i] < 0x050505) {
          depthThreshold.pixels[i] += 0x010101;
        } else {
          depthThreshold.pixels[i] = 0x000000;
        }
      }
      cR++;
    } else
    {
      if (kinect1[cL] > 1800 && kinect1[cL] < 2500)
      {
        dataMax2[cL] = kinect1[cL] - 1800;
        float c = map(dataMax2[cL], 0, 700, 0, 255);
        filteredDisplay.pixels[i] = color(c);
        if (depthThreshold.pixels[i] <= 0xf0f0f0) {
          depthThreshold.pixels[i] += 0x0f0f0f;
        } else {
          depthThreshold.pixels[i] = 0xFFFFFF;
        }
      } else {
        if (depthThreshold.pixels[i] > 0x050505) {
          depthThreshold.pixels[i] -= 0x010101;
        } else {
          depthThreshold.pixels[i] = 0x000000;
        }
      }
      cL++;
    }
  }



      
  for(int i = 0; i < depthThreshold.width * depthThreshold.height; i++)
       {
       filteredDisplay.pixels[i] = color(increment % 255, (increment*increment) % 255, 255);
       }
       

      /*********************************************************************
       OTHER KINECT LOOOOOOP
       **********************************************************************/
      //for(int i = 0; i < depthThreshold.width * depthThreshold.height; i++)
      //{
      //if (kinect1[i] > 1800 && kinect1[i] < 2500)
      //{
      //  dataMax2[i] = kinect1[i] - 1800;
      //  float c = map(dataMax2[i], 0, 700, 0, 255);
      //  filteredDisplay.pixels[i] = color(c);
      //  if (depthThreshold.pixels[i] <= 0xf0f0f0) {
      //    depthThreshold.pixels[i] += 0x0f0f0f;
      //  } else {
      //    depthThreshold.pixels[i] = 0xFFFFFF;
      //  }
      //} else {
      //  if (depthThreshold.pixels[i] > 0x050505) {
      //    depthThreshold.pixels[i] -= 0x010101;
      //  } else {
      //    depthThreshold.pixels[i] = 0x000000;
      //  }
      //}
      //}

      increment = increment + 1;

      depthThreshold.updatePixels();
      filteredDisplay.updatePixels();

      //display filtered data
      filteredDisplay.mask(depthThreshold);
      image(filteredDisplay, 0, 0, width, height);

      //update filter buffer
      depthPrevious = depthThreshold.get();
      //arrayCopy(rawData, dataPrev);

      //image(depthPrevious, 512, 0);

      stroke(255);
      text(frameRate, 50, height - 50);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  if (value > thresholdVal) {
    println();
    println("Controller Change:");
    println("--------");
    println("Channel:"+channel);
    println("Number:"+number);
    println("Value:"+value);
    carpetValue = value;
    carpetNum = number;
  }
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      thresholdVal = thresholdVal + 1;
      println(thresholdVal);
    } else if (keyCode == DOWN) {
      thresholdVal = thresholdVal - 1;
      println(thresholdVal);
    }
  }
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
