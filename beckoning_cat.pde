#include <Servo.h>

// Setting constants
const int DELAY_MINIMUM = 6;
const int DELAY_MULTIPLICATOR = 1;
const int ARM_MIN = 60;
const int ARM_MAX = 120;
const int ARM_PROBABILITY = 20;
const int SOUND_PROBABILITY = 2;
const int STOP_PROBABILITY = 5;

// Variables
Servo servo1; 
Servo servo2;
int pos1 = 0;
int pos2 = 0;
 
// Inital Stup routine
void setup()
{
  // Normal arm movement servo on Pin 1
  servo1.attach(1);
  servo1.write(ARM_MIN);
  
  // Sideways arm movement servo on Pin 2
  servo2.attach(2);
  servo2.write(90);
  
  // Initialize random number generation
  randomSeed(analogRead(0));
  
  // Buzzer on Pin 3
  pinMode(3, OUTPUT);
}
 
// Loop routine
void loop()
{
  // Move arm forward
  for(pos1 = ARM_MIN; pos1 < ARM_MAX; pos1 += 1) {
    servo1.write(pos1);
    delay(DELAY_MINIMUM + abs(pos1-90) * DELAY_MULTIPLICATOR); 
    
    // On top position, do some stuff (maybe???)
    if (pos1 == 90) {
      if (random(100) < ARM_PROBABILITY) {
        moveArmSideways();
      } else if (random(100) < SOUND_PROBABILITY) {
        servo1.write(0);
        analogWrite(3, 240);
        delay(500);
        analogWrite(3, 120);
        delay(500);
        analogWrite(3, 60);
        servo1.write(359);
        delay(500);
        analogWrite(3, 30);
        delay(500);
        analogWrite(3, 0);
      } else if (random(100) < STOP_PROBABILITY) {
        servo1.write(random(360));
        delay(10000);
      }
    }
  }
  
  // move arm backwards
  for(pos1 = ARM_MAX; pos1 >= ARM_MIN; pos1-=1) {                                
    servo1.write(pos1);
    delay(DELAY_MINIMUM+ abs(pos1-90) * DELAY_MULTIPLICATOR);
  }
}

void moveArmSideways() {
  for (int repeat = 0; repeat < 2; repeat++) {
    for(pos2 = 90; pos2 > 80; pos2 -= 1) {
      servo2.write(pos2);
      delay(10);
    }
    for(pos2 = 80; pos2 < 130; pos2 += 1) {
      servo2.write(pos2);
      delay(10);
    }
    for(pos2 = 130; pos2 > 90; pos2 -= 1) {
      servo2.write(pos2);
      delay(10);
    }
  }
}
