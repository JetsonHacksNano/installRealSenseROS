#!/bin/bash
# Install Intel realsense-ros on Jetson Nano Developer Kit
# Copyright (c) 2017-2019 Jetsonhacks 
# MIT License
# Usage:
# ./installRealSenseROS.sh <catkin workspace>
# If <catkin workspace> is omitted "catkin_ws" assumed
# ROS should already be installed, and a catkin workspace created
# Figure out where to install realsense-ros
# Save the directory we're installing from:
INSTALL_DIR=$PWD
# This version uses librealsense v2.22.0
REALSENSE_ROS_VERSION=2.2.6
# Now go get ready to install realsense-ros
source /opt/ros/melodic/setup.bash
DEFAULTDIR=catkin_ws
CLDIR="$1"
if [ ! -z "$CLDIR" ]; then 
 DEFAULTDIR="$CLDIR"
fi
# Check to see if qualified path already
if [ -d "$DEFAULTDIR" ] ; then
   echo "Fully qualified path"
else
   # Have to add path qualification
   DEFAULTDIR=$HOME/$DEFAULTDIR
fi
echo "DEFAULTDIR: $DEFAULTDIR"



if [ -e "$DEFAULTDIR" ] ; then
  echo "$DEFAULTDIR exists" 
  CATKIN_WORKSPACEHIDDEN=$DEFAULTDIR/.catkin_workspace
  CATKIN_BUILD_WORKSPACEHIDDEN=$DEFAULTDIR/.catkin_tools
  if [ -e "$CATKIN_WORKSPACEHIDDEN" ] || [ -e "$CATKIN_BUILD_WORKSPACEHIDDEN" ] ; then
	# This appears to be a Catkin_Workspace
	echo "Found catkin workspace in directory: $DEFAULTDIR"
  else
	echo "$DEFAULTDIR does not appear to be a Catkin Workspace."
        echo "The directory does not contain the hidden file .catkin_workspace or .catkin_tools."
	echo "This does not appear to be a proper ROS installation."
	echo "Terminating Installation."
	exit 1
  fi
else 
  echo "Catkin Workspace named $DEFAULTDIR does not exist"
  echo "Please create a Catkin Workspace before installation"
  echo "Terminating Installation"
  exit 1
fi
if [ "${DEFAULTDIR: -1}" != "/" ] ; then
	DEFAULTDIR=$DEFAULTDIR/
fi

INSTALLDIR="$DEFAULTDIR"src
if [ -e "$INSTALLDIR" ] ; then
  echo "Installing realsense-ros in: $INSTALLDIR"
else
  echo "$INSTALLDIR does not appear to be a source of a Catkin Workspace"
  echo "The source directory src does not exist"
  echo "Terminating Installation"
  exit 1
fi 

echo "Starting installation of realsense-ros"

cd $INSTALLDIR

# Update the dependencies database
rosdep update
echo "Cloning Intel ROS realsense package"
# Prerequisite: ddynamic_reconfigure
git clone https://github.com/pal-robotics/ddynamic_reconfigure
git clone https://github.com/IntelRealSense/realsense-ros.git
cd realsense-ros
git checkout $REALSENSE_ROS_VERSION
# Remove the librealsense2 package requirement in package.xml
patch -p1 < $INSTALL_DIR/patches/package.diff
cd ../..
echo $PWD
echo "Making Intel ROS realsense-ros"
sudo rosdep -y install --from-paths src --ignore-src --rosdistro melodic
if [ -e "$CATKIN_WORKSPACEHIDDEN" ] ; then
        echo "catkin_make starts"
	catkin_make
	echo "realsense-ros Package installed"
elif [ -e "$CATKIN_BUILD_WORKSPACEHIDDEN" ] ; then
        echo "catkin_build starts"
	catkin build
	echo "realsense-ros Package installed"
else
	echo "Error: Could not decide to use catkin_make or catkin build"
	echo "Aborting..."
fi
