
// This example code is in the public domain.

import processing.serial.*;

Serial myPort;                       // The serial port
int[] serialInArray = new int[3];    // Where we'll put what we receive
int serialCount = 0;  // A count of how many bytes we receive

String aData = null;
String dataIn;

import processing.net.*;
Client myClient;
int clicks;

void setup() {
    size( 320, 240 );
    serversetup();

    // print usage
      // Print a list of the serial ports, for debugging purposes:
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {

    // draw face area(s)
    noFill();
    stroke(255,0,0);
if (aData != null) {
 myClient.write(aData); // passing arduino data to urbi
  aData = null;
}  
   if (myClient.available() > 0) {
     dataIn = myClient.readString();
     println(dataIn);
   }

}


void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  String inString = myPort.readStringUntil('\n');
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller. 
  // Otherwise, add the incoming byte to the array:
  if (inString != null) {
    //println(inString);
    aData = inString;
  }
/*
  if (firstContact == false) {
    if (inByte == 'A') { 
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    } 
  } 
  else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 3 bytes:
    if (serialCount > 2 ) {
      xpos = serialInArray[0];
      ypos = serialInArray[1];
      fgcolor = serialInArray[2];

      // print the values (for debugging purposes only):
      println(xpos + "\t" + ypos + "\t" + fgcolor);

      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
  */
}

void serversetup() {
  //establisging network connection to send data to urbi
  // Connect to the local machine at port 1234.
  // This example will not run if you haven't
  // previously started a server on this port  
  myClient = new Client(this, "127.0.0.1", 1234); 
  myClient.write("0");
}
