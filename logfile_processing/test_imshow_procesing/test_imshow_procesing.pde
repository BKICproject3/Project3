import java.io.*;

BufferedReader read;
String line;
PImage currFrame;
int currRow = 0;
byte[][] pix     = new byte[240][320];


void setup(){
  size(480, 640);
  currFrame = createImage(160, 240, RGB);
  read = createReader("1.txt");
}

void draw(){
  try{
    line = read.readLine();
  } catch(IOException e){
    e.printStackTrace();
    line = null;
  }
  if(line==null){
    noLoop();
  }else{
    int[] data_line = int (split(line, TAB));
    byte[] data = byte(data_line);
    print(data_line);
    for (int i = 0; i<320; i++)  
      pix[currRow][i] = data[i];
    currRow ++;
    if (currRow >= 240) {
       buff2pixFrame(pix, currFrame);
       //noSmooth();
       image(currFrame,0,0, 480,640);
       smooth();
       currRow = 0;
     }
  }
}


void buff2pixFrame(byte[][] pixBuff, PImage dstImg) {
 
  int Y0 = 0, U = 0, Y1 = 0, V = 0;
  
  dstImg.loadPixels();
 for (int y = 0, l = 0, x = 0; y < 240; y++, x = 0)
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

color YUV2RGB(int Y, int Cb, int Cr) {
     // from OV7670 Software Application note
     float R = Y + 1.371*(Cr-128);
     float G = Y - 0.698*(Cr-128)+0.336*(Cb-128);
     float B = Y + 1.732*(Cb-128);

     return color(R, G, B);
}
  
  
    color YUV21RGB(int Y, int Cb, int Cr) {
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