/**
 * Serial Read & Write to LogFile
 *
 * Read data from Arduino through serial port and appends the data to a text file provided.
 * Code by: Naveen Karuthedath, Barry Chris & Aradhan
*/
import java.util.List;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar; 
import processing.serial.*;
Serial sPort;  
byte[] sData = new bytes[320];


String file1 = "E:/ArduinoLog.txt";
String comPort = "COM5";
int logDelay = 150; //ms delay

void setup()
{
  size(640,480);//window size
  //if serial port is available
  try {
   sPort = new Serial(this, comPort, 115200);
   // don’t read the serial buffer until a new line char
   // should use Serial.println("") in arduino code
   sPort.bufferUntil('\n');   
  } finally {} 
  
}

void draw()
{
  // If data is available,
  if (sPort.available() > 0) {  
    sPort.readBytesUntil('\n', sData);    
    //sData =  sPort.readString(); 
    logData(file1, sData, true);
    delay(logDelay);
  }
}

void logData( String fileName, bytes* newData, boolean appendData)
 {
    BufferedWriter bw=null;
    try { //try to open the file
    FileWriter fw = new FileWriter(fileName, appendData);
    bw = new BufferedWriter(fw);
    bw.write(newData);// + System.getProperty("line.separator"));
    } catch (IOException e) {
    } finally {
    if (bw != null){ //if file was opened try to close
        try {
        bw.close();
        } catch (IOException e) {}
    }
    }
}