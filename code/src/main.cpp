#include <Arduino.h>
#include <Adafruit_NeoPixel.h>
#include <Servo.h>

class LowPass {
  private:
    float _previousPrefilteredAnalog;
    unsigned long _previousMicros = 0;
  public:
    float RCus;
    LowPass(float _RCus) : RCus(_RCus) {}
    float step(float prefilteredAnalog) {
      if (_previousMicros == 0) {
        _previousMicros = micros();
        _previousPrefilteredAnalog = prefilteredAnalog;
        return prefilteredAnalog;
      }
      unsigned long now = micros();
      unsigned long dt = now - _previousMicros;
      float alpha = dt / (RCus * dt);
      _previousMicros = now;
      _previousPrefilteredAnalog += alpha * (prefilteredAnalog - _previousPrefilteredAnalog);
      return _previousPrefilteredAnalog;
    }
};

// How many internal neopixels do we have? some boards have more than one!
#define NUMPIXELS 1
Adafruit_NeoPixel pixels(NUMPIXELS, PIN_NEOPIXEL, NEO_GRB + NEO_KHZ800);

Servo servo;

// low pass filter with an RC time constant of 40us
LowPass lowPass(40);

void setup() {
  Serial.begin(115200);

#if defined(NEOPIXEL_POWER)
  // If this board has a power control pin, we must set it to output and high
  // in order to enable the NeoPixels. We put this in an #if defined so it can
  // be reused for other boards without compilation errors
  pinMode(NEOPIXEL_POWER, OUTPUT);
  digitalWrite(NEOPIXEL_POWER, HIGH);
#endif

  pixels.begin(); // INITIALIZE NeoPixel strip object (REQUIRED)
  pixels.setBrightness(127);

  pinMode(A2, INPUT);
  analogReadResolution(12);

  servo.attach(A3, 1100, 1900);
  servo.writeMicroseconds(1500);
}

void loop() {
  int pot = analogRead(A2);

  // map pot to an HSV value that is between 240 deg and 360 deg of the color wheel.
  pixels.fill(pixels.ColorHSV(map(pot, 0, 4095, (pow(2, 16) - 1) * 240/360, pow(2, 16) - 1), 255, 255));
  pixels.show();

  servo.writeMicroseconds(lowPass.step(map(pot, 0, 4095, 1200, 2000)));

  delay(20);
}
