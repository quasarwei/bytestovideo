// savebytes
// load bytes from a file, convert range to 0 -255, write to text

byte b[];
PrintWriter output;

void setup() 
{
  
  output = createWriter("QtGui4aaa.txt");  // choose output filename
  byte b[] = loadBytes("QtGui4.txt");      // file you want read from (inside data folder)


  for (int i = 0; i < b.length; i++) 
  {
    // bytes are from -128 to 127, this converts to 0 to 255 
    output.println((b[i] & 0xff));
  }


  output.flush();    // Writes the remaining data to the file
  output.close();    // Finishes the file
  exit();            // Stops the program
}