import java.io.*;

BufferedReader reader;
String line;
 
void setup() {
  // Open the file from the createWriter() example
  size(640,480);
  reader = createReader("1.txt");    
}
 
void draw() {
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    // Stop reading because of an error or file is empty
    noLoop();  
  } else {
    String[] pieces = split(line, TAB);
    int i = 0;
    while(i<321){
      print(pieces[i]+'\t');
      i++;
    }
  }
} 