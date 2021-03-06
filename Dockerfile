from resin/rpi-raspbian:jessie 

RUN sudo apt-get update
RUN sudo apt-get upgrade

RUN sudo apt-get install build-essential\
 cmake\
 git\
 pkg-config\
 libjpeg-dev\
 libtiff5-dev\
 libjasper-dev\
 libpng12-dev\
 libavcodec-dev\
 libavformat-dev\
 libswscale-dev\
 libv4l-dev\
 libxvidcore-dev\
 libx264-dev\
 libgtk2.0-dev\
 libatlas-base-dev\
 gfortran\
 python2.7-dev\
 wget\
 unzip

RUN cd /tmp && \
  wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.2.0.zip

# RUN sudo apt-get install unzip
RUN cd /tmp && \
 unzip opencv.zip

RUN cd /tmp && \
 wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.2.0.zip && \
 unzip opencv_contrib.zip

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN sudo python get-pip.py

RUN pip install numpy

#4-----------------------------------------------

RUN cd /tmp/opencv-3.2.0 && \
 mkdir build && \
 cd build && \
 cmake -D CMAKE_BUILD_TYPE=RELEASE\
 -D CMAKE_INSTALL_PREFIX=/usr/local\
 -D INSTALL_C_EXAMPLES=ON\
 -D INSTALL_PYTHON_EXAMPLES=ON\
 -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-3.2.0/modules\
 -D BUILD_EXAMPLES=ON .. && \
 make && \
 make install && \
 make clean

RUN sudo ldconfig
