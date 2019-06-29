import beads.*;
import org.jaudiolibs.beads.*;

float incrementer = 0;
boolean incDirection;
float layeredNumA= 1;



void setup() {
  size(1000,900); 
  stroke(255);
  noFill();
  strokeWeight(0.2);
//frameRate(60);
colorMode(HSB);
}

void draw() {
  // background(0);
  fill(70,200,20,10);
  rect(0,0,width,height);
  noFill();
 // rect(500,500,510,510);

   incrementer += PI / 90; 
 float stepperCount = map(cos(incrementer), -1, 1, 0, 255);

  println(stepperCount);
  scale(3.5);
    translate(100,50);
   
  for(int i=0;i<10;i+=3){
   // layeredNumA++;
      
    layeredNumA = layeredNumA+0.01;
    float randomness = random(10);
    //stroke((i*3)/stepperCount%5,1,1,1);
    //bezier(i*PI+10,i+40,cos(PI*stepperCount)+300,i+400,261,i+10,941,i+150);
      for(int j=0;j<5;j+=2){
    //bezier(i+j,i+j,(j+stepperCount)*PI,sin(i+PI)*100,961,cos(i)+10,941,i*4+150);
    for(int n=0;n<6;n+=6){
      
       layeredNumA = layeredNumA+0.001;
    for(int k=0;k<12;k+=1){
     
      //stroke(k+stepperCount/2);
    //  point(i+k, i+j);
         // point(i+k+(10*n), i+j); pretty
          stroke(30+k*(stepperCount/5),100,100,sin(layeredNumA) *20+70);
         // point(layeredNumA % width, k%height);
         beginShape();
         vertex(10*k, 7*j);
vertex(cos(k*PI)*50, stepperCount);
vertex(stepperCount/PI+40, 5*(j+k)+20);
vertex(k%200,j%200);
vertex(k*2+20, n+j%200);
endShape();
           //bezier(10+((1+n*j)*k),10,150,150,k%200,j%200,stepperCount+300/((k*i)+1),250);
          stroke(stepperCount+20,50,50,100);
     point((1+(1+n)*(i+1)),j*i);
    //bezier(k*j+j*n,n+k,(k*n+10)*3,sin(n+4)*stepperCount,9*k*j,cos(i*k)+10,cos(i)*k,i*4+150);
    }
    stroke(250-stepperCount/2,70,70,100);
      for (int q=0; q <= 10;q++){ 
         // ellipseMode(CENTER);
  //ellipse(2*i,130,2*i+(2*1+q),130+(2*1+q));

      }
    bezier(n+j,n+j,(n-stepperCount)*PI,sin(n+4)*10,2*stepperCount,cos(i)+10,91,i*4+150);
  }
  }
  }
  

 flipHalf();
}

void mousePressed(){

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
