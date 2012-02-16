
int photocellPin = 0; // the cell and 10K pulldown are connected to Analogue 0
int redLED = 9;
int blueLED = 10;
int greenLED = 11;
int whiteLED = 6;
int ledPins[4][2] = {
    {redLED, 0}, 
    {blueLED, 0}, 
    {greenLED, 0}, 
    {whiteLED, 0}
  };

void setup(void) {
  Serial.begin(9600); // We'll send debugging information to the Serial monitor
  randomSeed(analogRead(photocellPin));
  pinMode(redLED, OUTPUT);
  pinMode(blueLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
  pinMode(whiteLED, OUTPUT);
}

void loop(void) {
  int sensorInput = analogRead(photocellPin);

  Serial.print("Analog reading = ");
  Serial.println(sensorInput);

  if(sensorInput > 800){
    int pin = random(0,4);
    change(ledPins[pin]);
    Serial.print("Pin: ");
    Serial.println(pin);
    delay(random(5,100));
    
  }else{
    for(int i = 0; i < 4; i++)
    {
      digitalWrite(ledPins[i][0], LOW);
    }
  }

  // send the reading to the serial monitor
  //wait 1/10th sec before we re-start the loop
  delay(10);
}

void change(int pinInfo[]){
  if(random(0,2) > 0){
    ledSinWave(pinInfo[0], pinInfo[1], 8);
    if(pinInfo[1] == 0){
      pinInfo[1] = 1;
    }
    else{
      pinInfo[1] = 0;
    }
  } 
  else {
    if(pinInfo[1] == 0){
      digitalWrite(pinInfo[0], HIGH);
      pinInfo[1] = 1;
    }
    else{
      digitalWrite(pinInfo[0], LOW);
      pinInfo[1] = 0;
    }
  }
}

void ledSinWave(int ledPin, int state, int waitMs){

  double sinVal;
  int ledVal;
  int minSin, maxSin;
  if(state = 0)
  {
    minSin = 0;
    maxSin = 90;
  }
  else{
    minSin = 90;
    maxSin = 180;
  }
  
  // If we go to 90, that leaves the LED on
  for (int i = minSin; i <= maxSin; i++){
    sinVal = (sin(i*(3.1412/180)));
    ledVal = int(sinVal * 255);
    analogWrite(ledPin, ledVal);
    delay(waitMs);
  }
}

