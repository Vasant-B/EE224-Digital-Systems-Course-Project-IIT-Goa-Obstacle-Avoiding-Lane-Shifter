#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
const int O_ard0PIN  = A4;
const int O_ard1PIN  = A5;
const int BRAKEPIN = A2;
//const int PARKPIN  = A3;
int O_ard0 = 0;
int O_ard1 = 0;
//int BRAKE = 0;
//int P_D = 0;
//int shift_count = 0;

void setup() {
   pinMode(O_ard0PIN, INPUT);
   pinMode(O_ard1PIN, INPUT);
   //pinMode(BRAKEPIN, INPUT);
   //pinMode(PARKPIN, INPUT);
   lcd.begin(16, 2);
   lcd.setCursor(0,0);
   lcd.print("Hello There!!");
   delay (2000);
   lcd.clear();
   lcd.setCursor(0,0);
   lcd.print("This-s our EE224");
   lcd.setCursor(0,1);
   lcd.print("Course Project");
   delay (2000);
   lcd.clear();
   lcd.setCursor(0,0);
   lcd.print("OBSTACLE AVOIDING");
   lcd.setCursor(0,1);
   lcd.print("LANE SHIFTER");
   delay (2000);
   lcd.clear();
   lcd.setCursor(0,0);
   lcd.print("Vasant , Manika");
   lcd.setCursor(0,1);
   lcd.print("Vaishnavi, Siddharth");
   delay(2000);
   lcd.clear();
}

void loop() {
  O_ard1  = digitalRead(O_ard1PIN);
  O_ard0  = digitalRead(O_ard0PIN);
  //BRAKE = not digitalRead(BRAKEPIN);
  //P_D = not digitalRead(PARKPIN);
  // set the cursor to column 0, line 1
  // (note: line 1 is the second row, since counting begins with 0):
  //lcd.setCursor(0, 1);
  // Print LEFT SHIFT or RIGHT SHIFT on the first Line
  //if (BRAKE == 1) {lcd.setCursor(0,1); lcd.print("BRAKE"); }
  //else            {lcd.setCursor(0,1); lcd.print("CRUZE"); };

  //if (P_D == 1) {lcd.setCursor(7,1); lcd.print("PARK MODE"); }
  //else          {lcd.setCursor(7,1); lcd.print("DRIVEMODE");};


  if      ((O_ard1 == 0) and (O_ard0 == 0)) {lcd.setCursor(0,0); lcd.print("   |   |   |:A:"); lcd.setCursor(0,1); lcd.print("Lane : 4");}
  else if ((O_ard1 == 0) and (O_ard0 == 1)) {lcd.setCursor(0,0); lcd.print("   |   |:A:|   "); lcd.setCursor(0,1); lcd.print("Lane : 3");}
  else if ((O_ard1 == 1) and (O_ard0 == 0)) {lcd.setCursor(0,0); lcd.print("   |:A:|   |   "); lcd.setCursor(0,1); lcd.print("Lane : 2");}
  else if ((O_ard1 == 1) and (O_ard0 == 1)) {lcd.setCursor(0,0); lcd.print(":A:|   |   |   "); lcd.setCursor(0,1); lcd.print("Lane : 1");};
  
   
   //delay(100);
 // lcd.print(millis()/200);// This shows number of total missiseconds passed divided by 1000.
}

