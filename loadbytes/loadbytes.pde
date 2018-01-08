//loadbytes
int  numPixelsWide, numPixelsHigh;
int blockSize = 1;
int d, e, f;

String lines[];    // load numbers from txt file into this array
int[] data;        // convert strings to int, place into new array 'data'
color c1;

int r1[], g1[], b1[];
int index = 1;
int w, h;


int[] imgStill = new int[518400]; // size of array should be total resolution of the picture you want to output, 5128400 outputs a picture 960 x 540 pixels

// for saving image sequence, indicates place in an image sequence
int sequence = 0;
int fileLength = 0;

// for loops
int firstPixel = 0;
int lastPixel = 518400;

int n = 0;
int rn = 0;
int gn = 0;
int bn = 0;
int k = 0;


void setup() {

  size(960, 540);
  w = width;
  h = height;

  // Load txt file into int array
  lines = loadStrings("efxsdWav.txt");
  println("there are " + lines.length + " lines");
  //int fileLength = lines.length;
  data = int(lines);       

  numPixelsWide = width / blockSize;
  numPixelsHigh = height / blockSize;
}

void draw() {


  // A lot of this was just experimentation, trying different loops, changing values and running the program to see what changes.  
  loadPixels();

  for (int j = 0; j < numPixelsHigh - 1; j+=1) {
    for (int i = 0; i < numPixelsWide - 1; i+=1) {
      int pix1Index = i + (j * numPixelsHigh) + n;
      int pix2Index = i + (j * numPixelsWide) + 10 + n;
      int pix3Index = i + j * numPixelsWide;

      color c1 = data[pix1Index];
      color c2 = data[pix2Index];
      color c3 = pixels[pix3Index];

      int r1 = int(c1) >> 0 & 0xFF;
      int g1 = int(c1) >> 8 & 0xFF;
      int b1 = int(c1) >> 0 & 0xFF;

      int r2 = int(c2) >> 16 & 0xFF;
      int g2 = int(c2) >> 8 & 0xFF;
      int b2 = int(c2) >> 0 & 0xFF;

      int r3 = int(c3) >> 16 & 0xFF;
      int g3 = int(c3) >> 8 & 0xFF;
      int b3 = int(c3) >> 0 & 0xFF;

      int r0 = ((r1 + r2 + r3)/3);
      int g0 = ((g1 + g2 + g3)/3); 
      int b0 = ((b1 + b2 + b3)/3) ; 
      pixels[i + j * numPixelsWide] =   (b0 << 0 ) | (g0 << 8 ) | ( r0 << 16) | 0xFF000000 ;
    }
  }

  //vertical bars
  /*
  for (int j = 0; j < numPixelsHigh - 1; j+=1) {
   for (int i = 0; i < numPixelsWide - 1; i+=1) {
   int pix1Index = i + (j * numPixelsHigh) + n;
   int pix2Index = i + (j * numPixelsWide) + 10 + n;
   int pix3Index = i + j * numPixelsWide;
   
   color c1 = data[pix1Index];
   color c2 = data[pix2Index];
   color c3 = pixels[pix3Index];
   
   int r1 = data[i+ rn];
   int g1 = data[i+ gn + 1];
   int b1 = data[i+ bn + 2];
   pixels[i + j * numPixelsWide] =   (b1 << 0 ) | (g1 << 8 ) | ( r1 << 16) | 0xFF000000 ;
   }
   }
   */


  // single loop, greyscale
  /*
   for (int i = firstPixel; i < lastPixel; i++)
   {
   c1 = color(data[i + n], data[i + 1+ n], data[i + 2 + n]);
   pixels[i] = c1;
   }
   */


  // single loop, color
  /*
   for (int i = firstPixel; i < lastPixel; i++)
   {
   int r1 = data[i + rn]<<1;
   int g1 = data[i + gn]>>1;
   int b1 = data[i + bn]>>2;
   pixels[i] = (b1 << 0 ) | (g1 << 8 ) | ( r1 << 16) | 0xFF000000 ;
   }
   */

  updatePixels();

  increment();    // increment frame
  // save();      // save frame
}

// bound increment/save to keys in case you want to preview frames manually
void keyPressed() {
  if (key == CODED)
  {
    if (keyCode == UP)
    {
      increment();
    } else if (keyCode == RIGHT)
    {
      save();
    }
  }
}


// increment frame
void increment() {
  n+=30000;
  rn+=200000;
  gn+=10000;
  bn+=30000;
}

// save frame
void save() {
  println("Saving...");
  String s = "screen" + nf(sequence, 4) +".png";      // specify filename
  save(s);
  sequence++;                                         // increment file sequence number
  println("Done saving.");
}