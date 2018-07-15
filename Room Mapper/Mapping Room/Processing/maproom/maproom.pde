

import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

void setup() 
{
  size(600, 600);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[1];
  println(portName);
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    String inBuffer = myPort.readStringUntil('\n');
    if (inBuffer != null) {
      String[] messages = inBuffer.split("\\s+");
      
      if (messages.length != 5) {
        println("Invalid message size: ", messages.length);
        return;
      }
      
      Float heading = Float.parseFloat(messages[0]);
      int u1 = Integer.parseInt(messages[1]);
      int u2 = Integer.parseInt(messages[2]);
      int u3 = Integer.parseInt(messages[3]);
      int u4 = Integer.parseInt(messages[4]);
      //println(heading, u1, u2, u3, u4);
      
      //background(255);
      //fill(0);
      
      // Convert polar to cartesian
      float r = Math.min(u1, Math.min(u2, Math.min(u3, u4)));
      float theta = radians(heading);
      float x = r * cos(theta);
      float y = r * sin(theta);
      float x_max = 300 * cos(theta);
      float y_max = 300 * sin(theta);
  
      stroke(255);
      line(300, 300, 300+x_max, 300+y_max);
      stroke(0);
      line(300, 300, 300+x, 300+y);
    }
  }
}