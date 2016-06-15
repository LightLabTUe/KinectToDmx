import KinectPV2.KJoint;
import KinectPV2.*;
import processing.serial.*;

KinectPV2 kinect;
KJoint[] joints;

float zVal = 300;
float rotX = PI;

Serial arduino;  // The serial port
String text;

void setup() {
  size(1024, 768, P3D);
  
  // setup kinect stuff
  kinect = new KinectPV2(this);

  kinect.enableColorImg(true);

  //enable 3d  with (x,y,z) position
  kinect.enableSkeleton3DMap(true);

  kinect.init();
  
  // setup arduino stuff
  // List all the available serial ports
  printArray(Serial.list());
  
  // Open the port you are using at the rate you want:
  arduino = new Serial(this, Serial.list()[0], 9600);
  arduino.clear();
  arduino.write(" 1c250w");
}

void draw() {
  background(0);

  image(kinect.getColorImage(), 0, 0, 1024, 768);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();
  
  //walkthourgh only the first skeleton
  for (int i = 0; i < 1 && i < skeletonArray.size(); i++) {
    
  // walkthrough all the skeletons  
  //for (int i = 0; i < skeletonArray.size(); i++) {
    
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      joints = skeleton.getJoints();
      
      // Do demo stuff
      demoStuff();
      
      // Insert your stuff here
            
      // //  // How to get started: // // // // // // // // // // // // // // // //
      // Get data from the kinect by calling this function: 
      float myValue = joints[KinectPV2.JointType_HandLeft].getX(); // This returns the x position of your left hand.
      //
      // //  // How to more data:  // // // // // // // // // // // // // // // //
      // Replace 'getX' with 'getY' or 'getZ' to get the Y or Z values.
      // Replace the joint type with one of the types below to get info about other body parts
      //
      // Please note: Only the first skeleton measured is used here, 
      //              because I'm using a for loop that only uses the first skeleton
      // 
      // //  // Joint types: // // // // // // // // // // // // // // // // // //
      // // Head
      // JointType_Head, JointType_Neck, JointType_SpineShoulder
      //
      // // Body
      // JointType_SpineMid, JointType_SpineShoulder, JointType_SpineShoulder, JointType_SpineBase, JointType_SpineBase
      //
      // // Right Arm    
      // JointType_ShoulderRight, JointType_ElbowRight, JointType_WristRight, JointType_HandRight, JointType_WristRight
      //
      // // Left Arm
      // JointType_ShoulderLeft, JointType_ElbowLeft, JointType_WristLeft, JointType_HandLeft, JointType_WristLeft
      //
      // // Right Leg
      // JointType_HipRight, JointType_KneeRight, JointType_AnkleRight
      //
      // // Left Leg
      // JointType_HipLeft, JointType_KneeLeft, JointType_AnkleLeft
      //
      // // Hands
      // JointType_HandTipLeft, JointType_HandTipRight, JointType_FootLeft, JointType_FootRight, JointType_ThumbLeft, JointType_ThumbRight
      // // // // // // // // // // // // // // // // // // // // // // // //
    }
  }
}

void demoStuff() {
    /// printing values on the screen
    fill(255,0,0);
    textSize(16);
    
    // read the x,y,z value from the left and right hand
    float lefthandX = joints[KinectPV2.JointType_HandLeft].getX();
    float lefthandY = joints[KinectPV2.JointType_HandLeft].getY();
    float lefthandZ = joints[KinectPV2.JointType_HandLeft].getZ();
    
    float righthandX = joints[KinectPV2.JointType_HandRight].getX();
    float righthandY = joints[KinectPV2.JointType_HandRight].getY();
    float righthandZ = joints[KinectPV2.JointType_HandRight].getZ();
    
    // print this as text (or use these values as input for your lighting installation)
    text = "Left hand: ";
    text += "\nx: " + lefthandX;
    text += "\ny: " + lefthandY;
    text += "\nz: " + lefthandZ;
    text += "\nRight hand: ";
    text += "\nx: " + righthandX;
    text += "\ny: " + righthandY;
    text += "\nz: " + righthandZ;
    text(text,10,30);

    // set the intensity according to the distance between your hands
    float dX = abs(lefthandX - righthandX); 
    float dY = abs(lefthandY - righthandY);
    float dZ = abs(lefthandZ - righthandZ);
    float distance = sqrt(pow(sqrt(dX*dX + dY*dY), 2) + dZ*dZ);
    int intensity = int(distance * 125);
    arduino.write("1c" + intensity + "w");

    //draw different color for each hand state
    float handX = joints[KinectPV2.JointType_HandRight].getX();
    int red = int((handX + 1) * 125);
    arduino.write("2c" + red + "w");
    
    float handY = joints[KinectPV2.JointType_HandRight].getY();
    int green = int((handY + 1) * 125);
    arduino.write("3c" + green + "w");
    
    float handZ = joints[KinectPV2.JointType_HandRight].getZ();
    int blue = int((handZ) * 75);
    arduino.write("4c" + blue + "w");
    
    // I added some extra lamps for a dramatic effect. FUN!
    for(int c = 5; c < 25;c++) {
      int channel = c + 1;
      if(c%4 == 0) arduino.write(channel + "c" + intensity + "w");
      if(c%4 == 1) arduino.write(channel + "c" + red + "w");
      if(c%4 == 2) arduino.write(channel + "c" + green + "w");
      if(c%4 == 3) arduino.write(channel + "c" + blue + "w");
    }
    
    //println("handX: " + handX + "red: " + red + "handY: " + handY + "green: " + green);
    //println("handZ: " + handZ + "blue: " + blue);
    println(distance);
}