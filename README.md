# installRealSenseROS
Install the realsense-ros library on NVIDIA Jetson Nano Developer Kit.
<br>MIT License
<br>Copyright (c) 2018-19 JetsonHacks

The installRealSenseROS script will install librealsense and realsense_camera as ROS packages. These scripts have been tested with a RealSense D435, D435i and T265 cameras.

Note that the RealSense ROS wrapper is for ROS Kinetic, but the Jetson Nano is ROS Melodic. Please note any issues that you encounter.

This is the third step of a three step process.

The first step requires the installation of librealsense (version 2). For the D4XX cameras, librealsense requires a modified kernel which modularizes uvcvideo and adds the RealSense video modes to the uvcvideo driver among other things.

One way to accomplish this is to use the 'installLibrealsense' repository on the Github JetsonHacksNano account (https://github.com/JetsonHacksNano/installLibrealsense). There are also scripts to build the librealsense library itself, and convenience scripts to rebuild the kernel if need be. <em><b>Note: </b>You will need to use the matching version of librealsense which corresponds to the RealSense ROS wrapper. See release notes below.</em>

The second step is to install ROS on the Jetson Nano. There are convenience scripts to help do this on the Github JetsonHacksNano account in the installROS repository (https://github.com/JetsonHacksNano/installROS). Note that the repository installs ros-base, if other configurations such as ros-desktop are desired, the scripts can do that through the command line parameters. You may want to install rviz. <em><b>Note: </b>realsense-ros officially only supports ROS Kinetic presently, the Jetson Nano runs ROS Melodic. While we haven't run into any issues running the library under ROS Melodic, be aware that there may be differences</em>.

This repository, the third step, is to install realsense-ros. The script installRealSenseROS.sh in this directory will install realsense-ros and dependencies in a Catkin Workspace.

To install:

$ ./installRealSenseROS.sh \<catkin_ws_name\>

The script 'setupNano.sh' simply turns off the USB autosuspend setting on the Jetson Nano so that the camera is always available. 


<h3>Releases:</h3>
<b>October 2019</b>

* L4T 32.2.1
* JetPack 4.2.1
* Requires librealsense v2.25.0
* Installs RealSense ROS Version = 2.2.8

<b>July 2019</b>
* L4T 32.2
* JetPack 4.2.1
* Expects librealsense v2.24.0
* Installs RealSense ROS Version = 2.2.7

<b>June 2019</b>
* L4T 32.1.0
* JetPack 4.2
* Expects librealsense v2.22.0
* Installs RealSense ROS Version = 2.2.6


