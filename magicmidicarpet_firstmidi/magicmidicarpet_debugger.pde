import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
float myControllerNum = 0;
float myControllerVal = 0;
void setup() {
  //fullScreen(P2D);
  size(400,400);
 colorMode(HSB);
  //MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

  // or for testing you could ...
  //                 Parent  In        Out
  //                   |     |          |
 // myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void draw() {
  //
  
  if (myControllerNum > 1) {
    background(255);
    fill(map(myControllerNum,1,9,0,255),255,255,90);
   // rect(0,0,300,300);
    fill(0);
    textSize(40);
    text(myControllerNum,0,200);
  }
  float posish = myControllerVal;
  //ellipse(100-posish,100-posish,posish,posish);


  //myBus.sendControllerChange(channel, number, value); // Send a controllerChange
  //delay(2000);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange

  if (value > 20) {
  myControllerNum = number;
  myControllerVal = value;
    //background(random(255));
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  //translate(width/2-200,height/2);
 // stroke(255);
 // text(value, 50,0,0);
  //delay(10);
  } else {
    myControllerNum = 0;
  }
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
