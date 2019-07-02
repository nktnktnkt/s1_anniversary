import themidibus.*; //Import the library
float incrementer = 0;
boolean incDirection;
float layeredNumA= 1;

MidiBus myBus; // The MidiBus
float myControllerNum = 0;
float myControllerVal = 0;
float carpetX=0;
float carpetY=0;
void setup() {
  fullScreen(P2D, SPAN);
  //size(800,800);
 colorMode(HSB);
   fill(200,200,20,7);
  rect(0,0,width,height);
  noFill();
  background(0);
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
  
  if (myControllerNum > 0) {
    
    
    if (myControllerNum == 1) {
      carpetX=1;
      carpetY=1;
    }
        if (myControllerNum == 2) {
      carpetX=2;
      carpetY=1;
    }
            if (myControllerNum == 3) {
      carpetX=3;
      carpetY=1;
    }           
    if (myControllerNum == 4) {
      carpetX=3;
      carpetY=2;
    }
        if (myControllerNum == 5) {
      carpetX=2;
      carpetY=2;
    }
        if (myControllerNum == 6) {
      carpetX=1;
      carpetY=2;
    }        if (myControllerNum == 6) {
      carpetX=1;
      carpetY=2;
    }
    if (myControllerNum == 7) {
      carpetX=3;
      carpetY=3;
    }
        if (myControllerNum == 8) {
      carpetX=2;
      carpetY=3;
    }
            if (myControllerNum == 9) {
      carpetX=1;
      carpetY=3;
    }
    /*
    background(255);
    fill(map(myControllerNum,1,9,0,255),255,255,20);
    rect(0,0,300,300);
    fill(0);
    textSize(40);
    translate(width/carpetX,height/carpetY);
    text(myControllerNum,-200,-200);
    */
  }
  float posish = myControllerVal;
  //ellipse(100-posish,100-posish,posish,posish);




   incrementer += PI / 90; 
 float stepperCount = map(cos(incrementer), -1, 1, 0, 255);

 // println(stepperCount);
  scale(6,2);
    translate(140,20);
    strokeWeight(0.01);
           for (int q=0; q <= 30;q++){ 
         // ellipseMode(CENTER);
         //stroke(stepperCount+20,map(q,0,40,0,255),100);
  ellipse(200-q,200-q,500,500);

      }
   
  for(int i=0;i<9;i+=3){
   // layeredNumA++;
      
    layeredNumA = layeredNumA+0.01;
    float randomness = random(10);
    //stroke((i*3)/stepperCount%5,1,1,1);
    bezier(i*PI+10,i+40,cos(PI*stepperCount)+300,i+400,261,i+10,941,i+150);
      for(int j=0;j<5;j+=2){
    //bezier(i+j,i+j,(j+stepperCount)*PI,sin(i+PI)*100,961,cos(i)+10,941,i*4+150);
    for(int n=0;n<6;n+=6){
      
       layeredNumA = layeredNumA+0.001;
    for(int k=0;k<12;k+=1){
     
      //stroke(k+stepperCount/2);
      point(i+k, i+j);
          point(i+k+(10*n), i+j); 
          //
          stroke(map(carpetX,0,3,1,255),100,200,carpetY*10+70);
         // point(layeredNumA % width, k%height);
         beginShape();
         vertex(carpetY*k, 4+carpetX*j);
         vertex(stepperCount*2-k*10,700);
//vertex((2+cos(layeredNumA*PI))*(10), 2*(7+sin(layeredNumA)));
//vertex((PI*(2+cos(layeredNumA))), (PI*(3+sin(layeredNumA))));
vertex(stepperCount/PI+k, 5*(j+k)+20);
vertex(30*(2+sin(layeredNumA)),n%200);
//vertex((1.5+sin(k))*j*2+20, n+j%200);
endShape();
           //bezier(10+((1+n*j)*k),10,150,150,k%200,j%200,stepperCount+300/((k*i)+1),250);
          //stroke(map(carpetX,0,3,1,255),50,50,100);
     point((carpetY+(1+n)*(i+1)),j*i);
    bezier(carpetX*5,n+k,(k*n+10)*3,carpetY*stepperCount,9*k*j,cos(i*k)+10,cos(i)*k,i*4+150);
    }
 

    bezier(n+j,n+j,(n-stepperCount)*PI,sin(n+4)*10,2*stepperCount,cos(i)+10,600,i*4+550);
  }
 
  }
  }
  

 flipHalf();

  //myBus.sendControllerChange(channel, number, value); // Send a controllerChange
  //delay(2000);
}


void flipHalf() {
  loadPixels();
  for (int x=width/2; x<width; x++) {
    for (int y=0; y<height; y++) {
      pixels[x+y*width] = pixels[(width-x)+y*width];
    }
  }
  updatePixels();
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

  if (value > 6) {
  myControllerNum = number + 1;
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
