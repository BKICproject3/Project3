/**
 * Serial Read & Write to LogFile
 *
 * Read data from Arduino through serial port and appends the data to a text file provided.
 * Code by: Naveen Karuthedath, Barry Chris & Aradhan
*/

import processing.serial.*;

int F_H = 120;
int F_W = 160;
int MAX_ROW_LEN = 320;
Serial serialPort;  
byte[][] pix     = new byte[F_H][MAX_ROW_LEN];



byte[] sData = new byte[320];
char LF = '\n';

String file1 = "E:/ArduinoLog.txt";
String comPort = "COM5";
int logDelay = 160; //ms delay
PImage currFrame;
void setup()
{
  size(640, 507);
  frameRate(30);
  
  currFrame = createImage(F_W, F_H, RGB);
  // create a font with the third font available to the system:
  PFont myFont = createFont("Arial", 18);
  textFont(myFont);

  // List all the available serial serialPorts:
  printArray(Serial.list());

  delay(500);
  serialPort = new Serial(this, "COM5", 115200);
  serialPort.bufferUntil('\n');
  serialPort.clear();
  delay(2000);
  
}

void draw()
{
  reqStatus = requestStatus_t.PROCESSING;
  buff2pixFrame(pix, currFrame, MAX_ROW_LEN);
  noSmooth();
  image(currFrame,0,0, G_DEF.F_W*G_DEF.DRAW_SCALE,G_DEF.F_H*G_DEF.DRAW_SCALE);
  smooth();
}