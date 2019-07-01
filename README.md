# installRealSenseROS
Install the realsense-ros library on NVIDIA Jetson Nano Developer Kit.
<br>MIT License
<br>Copyright (c) 2018-19 JetsonHacks

Currently in development

The installRealSenseROS script will install librealsense and realsense_camera as ROS packages. These scripts have been tested with a RealSense D435, D435i and T265 cameras.

This is the third step of a three step process.

The first step requires the installation of librealsense (version 2). For the D4XX cameras, librealsense requires a modified kernel which modularizes uvcvideo and adds the RealSense video modes to the uvcvideo driver among other things.

One way to accomplish this is to use the 'installLibrealsense' repository on the Github JetsonHacksNano account (https://github.com/JetsonHacksNano/installLibrealsense). There are scripts which download the kernel source, apply the necessary patches, make the kernel, and then copy the kernel images to the boot directory. There are also scripts to build the librealsense library itself. <em><b>Note: </b>You will need to use version v0.9 (release late June, 2019) of installLibrealsense to match this repository. This repository requires v2.22.0 of librealsense.</em>

The second step is to install ROS on the Jetson Nano. There are convenience scripts to help do this on the Github JetsonHacksNano account in the installROS repository (https://github.com/JetsonHacksNano/installROS). Note that the repository installs ros-base, if other configurations such as ros-desktop are desired, the scripts can do that through the command line parameters. You may want to install rviz.

This repository, the third step, is to install realsense-ros. The script installRealSenseROS.sh in this directory will install realsense-ros and dependencies in a Catkin Workspace.

To install:

$ ./installRealSenseROS.sh \<catkin_ws_name\>

The script 'setupNano.sh' simply turns off the USB autosuspend setting on the Jetson Nano so that the camera is always available. 


<h3>Releases:</h3>

<b>Unreleased</b>


