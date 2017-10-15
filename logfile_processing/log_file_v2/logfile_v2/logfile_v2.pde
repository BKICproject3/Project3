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
int currRow = 0;

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
     serialPort.readBytes(pix[currRow]);
     serialPort.clear();
     currRow++;
     if (currRow >= F_H) {
       buff2pixFrame(pix, currFrame);
       //noSmooth();
       image(currFrame,0,0, F_W,F_H);
       smooth();
       currRow = 0;
     }

}

void buff2pixFrame(byte[][] pixBuff, PImage dstImg) {
 
  int Y0 = 0, U = 0, Y1 = 0, V = 0;
  
  dstImg.loadPixels();
 for (int y = 0, l = 0, x = 0; y < F_H; y++, x = 0)
     while (x < 320) {
        Y0 = int(pixBuff[y][x++]);
        print(Y0); print('\t');
        U  = int(pixBuff[y][x++]);
        print(U);print('\t');
        Y1 = int(pixBuff[y][x++]);
        print(Y1);print('\t');
        V  = int(pixBuff[y][x++]);
        print(V);print('\t');
        dstImg.pixels[l++] = YUV2RGB(Y0,U,V);
        dstImg.pixels[l++] = YUV2RGB(Y1,U,V);
  }
  print('\n');              

  
  dstImg.updatePixels();  
}
  
// ************************************************************
//                     YUV TO RGB
// ************************************************************

color YUV21RGB(int Y, int Cb, int Cr) {
     // from OV7670 Software Application note
     float R = Y + 1.371*(Cr-128);
     float G = Y - 0.698*(Cr-128)+0.336*(Cb-128);
     float B = Y + 1.732*(Cb-128);

     return color(R, G, B);
}
  
  
  color YUV2RGB(int Y, int Cb, int Cr) {
     // from OV7670 Software Application note
    int C = Y - 16;
  int D = Cb - 128;
  int E = Cr - 128;
  
  float R = (298*C+409*E+128);
  float G = (298*C-100*D-208*E+128);
  float B = (298*C+516*D+128);
    return color(R, G, B);
}

// ************************************************************
//                      RGB TO YUV
// ************************************************************

color RGB2YUV(int R, int G, int B) {
    // from OV7670 Software Application note
    float Yu = 0.299*R+0.587*G+0.114*B;
    float Cb = 0.568*(B-Y)+128;
    float Cr = 0.713*(R-Y)+128;

    return color(Yu, Cb, Cr);
}
// ************************************************************
//
// ************************************************************

void mousePressed() {
  println(mouseY);
}