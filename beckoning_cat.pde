#include <Servo.h>

const int DELAY_MINIMUM = 6;
const int DELAY_MULTIPLICATOR = 1;
const int ARM_MIN = 60;
const int ARM_MAX = 120;
const int PROBABILITY = 20;

Servo servo1; 
Servo servo2;
int pos1 = 0;
int pos2 = 0;
 
void setup()
{
  servo1.attach(1);
  servo1.write(ARM_MIN);
  
  servo2.attach(2);
  servo2.write(90);
  
  randomSeed(analogRead(0));
}
 
 
void loop()
{
  for(pos1 = ARM_MIN; pos1 < ARM_MAX; pos1 += 1) {
    servo1.write(pos1);
    delay(DELAY_MINIMUM + abs(pos1-90) * DELAY_MULTIPLICATOR); 
    
    
    if (random(100) < PROBABILITY) {
      for (int repeat = 0; repeat < 2; repeat++) {
        if (pos1 == 90) {
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
    }
  }
  
  for(pos1 = ARM_MAX; pos1 >= ARM_MIN; pos1-=1) {                                
    servo1.write(pos1);
    delay(DELAY_MINIMUM+ abs(pos1-90) * DELAY_MULTIPLICATOR);
  }
}
