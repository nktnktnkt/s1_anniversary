float incrementer = 0;
boolean incDirection;
float layeredNumA= 1;
PImage flipped; 
void setup() {
  size(1000, 900, P2D); 
  stroke(255);
  noFill();
  strokeWeight(0.01);
  frameRate(100);
  colorMode(HSB);
  
}

void draw() {
  // background(0);
fill(1,4);
  rect(0, 0, width, height);
  noFill();
  
  // rect(500,500,510,510);

  incrementer += PI / 100; 
  float stepperCount = map(cos(incrementer), -1, 1, 0, 255);

  println(stepperCount);

 translate(10, 200);
  //scale(2);
 // flipBottom();
 // flipHalf();
   scale(19);

  for (int i=0; i<10; i+=3) {
      layeredNumA = layeredNumA+0.01;
      float randomness = random(10);
      //stroke(i/stepperCount%5);
      //  bezier(i+10,i+40,cos(randomness)+300,i+400,261,i+10,941,i+150);

        for (int j=0; j<5; j+=2) {
           layeredNumA = layeredNumA+0.01;
          //bezier(i+j,i+j,(j+stepperCount)*PI,sin(i+PI)*100,961,cos(i)+10,941,i*4+150);
          
            for (int n=0; n<36; n+=6) {
      stroke((stepperCount+n*2)/2,220,250);
     // blendMode(DIFFERENCE);
                for (int k=0; k<50; k+=1) {
        
                  //stroke(k+stepperCount/2);
                  //  point(i+k, i+j);
                   point(i+k+(10*n), i+j); 
                  // stroke(layeredNumA % 255);
                  // point(layeredNumA % width, k%height);
                  //stroke(stepperCount+k/2, 180);
                  
                  
                 // bezier(10+((1+n)*i), n*i, (stepperCount%k)*PI, k, 2*j, 80, 20, 250);
        line(200,200,k*5,n*10);
        blendMode(BLEND);
                  //point((1+(1+n)*k),j*i);
                  //bezier(k+j,n+k,(k+10)*3,sin(n+4)*stepperCount,9*k,cos(i)+10,cos(i)*k,i*4+150);
                }
              stroke(stepperCount/i+70, 100,100);
              bezier(n-j, 10+(stepperCount/10), (n-i)*PI, sin(n+i), 2*stepperCount, sin(i)+10, 20+j, i*2+150);
            }
            stroke(255);
            //rect(i*2+10,j+3,i*2+120,j+50);
        }
  }
PImage flipped = 

createImage(width,height,HSB);//create a new image with the same dimensions

  
for(int m = 0 ; m < flipped.pixels.length; m++){       //loop through each pixel
  int srcX = m % width;                        //calculate source(original) x position
  int dstX = flipped.width-srcX-1;                     //calculate destination(flipped) x position = (maximum-x-1)
  int y    = m / flipped.width;                        //calculate y coordinate
  flipped.pixels[y*width+dstX] = flipped.pixels[m];//write the destination(x flipped) pixel based on the current pixel  
}

image(flipped,500,height);
  
  
  flipBottom();
  flipHalf();
}




void flipBottom() {
 
 loadPixels();
  // Begin loop for width
   for (int i = 1; i < height/2; i++) {
     

 
  // Begin loop for height
     for (int j = 1; j < width; j++){   
       pixels[i+j*height] = pixels[(height - i) + j*height]; // Reversing x to mirror the image

     }
   }
 updatePixels(); 
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
