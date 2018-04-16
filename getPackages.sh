#!/bin/bash


HHROOT="https://github.com/holzschu"
IOS_SYSTEM_VER="1.2"

# Python-2.7.13
echo "Downloading Python 2.7.13"
curl -OL https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
tar -xvzf Python-2.7.13.tgz
rm Python-2.7.13.tgz
echo "Downloading ios_system.framework"
(cd Frameworks 
curl -OL $HHROOT/ios_system/releases/download/v$IOS_SYSTEM_VER/smallRelease.tar.gz
( tar -xzf smallRelease.tar.gz --strip 1 && rm smallRelease.tar.gz ) || { echo "ios_system failed to download"; exit 1; }
)
echo "Downloading header file:"
curl -OL $HHROOT/ios_system/releases/download/v$IOS_SYSTEM_VER/ios_error.h 
echo "Downloading libffi-3.2.1" 
curl -OL https://www.mirrorservice.org/sites/sourceware.org/pub/libffi/libffi-3.2.1.tar.gz 
tar -xvzf libffi-3.2.1.tar.gz
rm libffi-3.2.1.tar.gz
echo "Applying patch to libffi-3.2.1:"
(cd libffi-3.2.1 ; patch -p 1 < ../libffi-3.2.1_patch ; cd ..)
echo "Compiling libffi-3.2.1:"
(cd libffi-3.2.1 ;  xcodebuild -project libffi.xcodeproj -target libffi-iOS -sdk iphoneos -arch arm64 -configuration Debug -quiet
; mv build/Debug-iphoneos/libffi.a .. ; cd ..)
echo "Applying patches to Python-2.7.13"
(cd Python-2.7.13 ; patch -p 1 < ../Python_Include.patch ; patch -p 1 < ../Python_Lib.patch ; patch -p 1 < ../Python_Modules.patch; patch -p 1 < ../Python_Parser.patch ; patch -p 1 < ../Python_Python.patch; patch -p 1 < ../Python_setup.patch ; cd ..)

echo "All done. Now open Python_ios.xcodeproj and compile."
 

