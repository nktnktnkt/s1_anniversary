/*

Vika Zero
Capstone 19

  http://www.arduino.cc/en/Tutorial/Knock
*/

// these variables wont change ... so "const int" is used 
const int knockSensor = A8; // piezo is connected to analog pin 8
const int knockSensor1 = A7;
const int knockSensor2 = A6;
const int knockSensor3 = A5;
const int knockSensor4 = A4;
const int knockSensor5 = A3;
const int knockSensor6 = A2;
const int knockSensor7 = A1;
const int knockSensor8 = A0;

const int threshold = 10;

// these variables will change, so we use int:
int sensorReading = 0;
int sensorReading1 = 0; // variable to store the value read from the piezo
int sensorReading2 = 0;
int sensorReading3 = 0;
int sensorReading4 = 0;
int sensorReading5 = 0;
int sensorReading6 = 0;
int sensorReading7 = 0;
int sensorReading8 = 0;
  
void setup() {
  Serial.begin(9600);       // use the serial port
}

void loop() {
  // read the sensor and store it in the variable sensorReading:
  sensorReading = analogRead(knockSensor);
  sensorReading1= analogRead(knockSensor1);
  sensorReading2 = analogRead(knockSensor2);
  sensorReading3 = analogRead(knockSensor3);
  sensorReading4 = analogRead(knockSensor4);
  sensorReading5 = analogRead(knockSensor5);
  sensorReading6 = analogRead(knockSensor6);
  sensorReading7 = analogRead(knockSensor7);
  sensorReading8 = analogRead(knockSensor8);
  
  
  // if the sensor reading is greater than the threshold:
  if (sensorReading >= threshold) {
    Serial.print("A8: threshold");
    Serial.println(sensorReading);
  }
  if (sensorReading1 >= threshold) {
    Serial.print("A7: threshold");
    Serial.println(sensorReading1);
  }
  if (sensorReading2 >= threshold) {
    Serial.print("A6: but");
    Serial.println(sensorReading2);
  }
  if (sensorReading3 >= threshold) {
    Serial.print("A5: threshold");
    Serial.println(sensorReading3);
  }
  if (sensorReading4 >= threshold) {
    Serial.print("A4: threshold");
    Serial.println(sensorReading4);
  }
  if (sensorReading5 >= threshold) {
    Serial.print("A3: threshold");
    Serial.println(sensorReading5);
  }
  if (sensorReading6 >= threshold) {
    Serial.print("A2: threshold");
    Serial.println(sensorReading6);
  }
  if (sensorReading7 >= threshold) {
    Serial.print("A1: threshold");
    Serial.println(sensorReading7);
  }
  if (sensorReading8 >= threshold) {
    Serial.print("A0: threshold");
    Serial.println(sensorReading8);
  }

  delay(100);  // delay to avoid overloading the serial port buffer
}
