#!/bin/bash


# Python-2.7.13
echo "Downloading Python 2.7.13"
curl -OL https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
tar -xvzf Python-2.7.13.tgz
rm Python-2.7.13.tgz
echo "Downloading libffi-3.2.1" 
curl -OL ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz 
tar -xvzf libffi-3.2.1.tar.gz
rm libffi-3.2.1.tar.gz
echo "Applying patch to libffi-3.2.1"
(cd libffi-3.2.1 ; patch -p 1 < ../libffi-3.2.1_patch ; cd ..)
echo "Applying patch to Python-2.7.13"
(cd Python-2.7.13 ; patch -p 1 < ../python2.7.13_ios_patch ; cd ..)
echo "All done. Now open both Xcode files and compile"
 

