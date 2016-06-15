# KinectToDmx
An dummy proof example of using the Kinect to control Dmx

# Requirements
- Windows 10, 8, 8.1
- 64bit computer with a dedicated USB 3.0.
- A Kinect for Windows v2 Device (K4W2).
- [Kinect SDK v2](https://developer.microsoft.com/en-us/windows/kinect)
- Update your latest video card driver.
- [DirectX 11](https://www.microsoft.com/en-us/download/details.aspx?id=17431)
- [Processing](https://processing.org/)
- Processing library: [KinectPV2](https://github.com/ThomasLengeling/KinectPV2)
- Arduino with Dmx shield, upload the 'ArduinoSerialToDmx' sketch from this repository. 
- Arduino library: [DmxSimple](https://github.com/PaulStoffregen/DmxSimple)

# Instructions
- Install everything mentioned above
- Run 'KinectToDmx' sketch in processing
- Get data from the kinect by calling this function (inside the for loop, around line 57):

        joints[KinectPV2.JointType_HandLeft].getX(); // This returns the x position of your left hand.


### How to more data: 
- Replace 'getX' with 'getY' or 'getZ' to get the Y or Z values.
- Replace the joint type with one of the types below to get info about other body parts.

**Please note: Only the first skeleton measured is used here, because I'm using a for loop that only uses the first skeleton.**

# Joint types:
### Head
    JointType_Head, JointType_Neck, JointType_SpineShoulder
### Body
    JointType_SpineMid, JointType_SpineShoulder, JointType_SpineShoulder, JointType_SpineBase, JointType_SpineBase
### Right Arm    
    JointType_ShoulderRight, JointType_ElbowRight, JointType_WristRight, JointType_HandRight, JointType_WristRight
### Left Arm
    JointType_ShoulderLeft, JointType_ElbowLeft, JointType_WristLeft, JointType_HandLeft, JointType_WristLeft
### Right Leg
    JointType_HipRight, JointType_KneeRight, JointType_AnkleRight
### Left Leg
    JointType_HipLeft, JointType_KneeLeft, JointType_AnkleLeft
### Hands
    JointType_HandTipLeft, JointType_HandTipRight, JointType_FootLeft, JointType_FootRight, JointType_ThumbLeft, JointType_ThumbRight
     

# Help

For questions send an email to: ID [dot] Lightsupport [at] tue [dot] nl