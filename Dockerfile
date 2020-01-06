FROM debian

LABEL maintainer="mooplab"

ENV  TERM linux
RUN  apt-get update --allow-releaseinfo-change && \
     apt-get install -y apt-utils xarclock \
	build-essential cmake wget unzip pkg-config \
     # work with images
        libjpeg-dev libtiff-dev libpng-dev libtiff-dev \
     # work with images
	libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libxvidcore-dev libx264-dev \
     # work with gui
 	libgtk-3-dev \
 	libcanberra-gtk* \
 	libatlas-base-dev gfortran \
 	python3-dev && \
     # cleanup
     rm -rf /var/lib/apt/lists/* && \
     apt-get -y autoremove

RUN  wget -O /opt/opencv.zip https://github.com/opencv/opencv/archive/4.2.0.zip && \
     wget -O /opt/opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.2.0.zip 

RUN  cd /opt && \
     unzip opencv.zip && unzip opencv_contrib.zip && \
     mv opencv-4.2.0 opencv && \
     mv opencv_contrib-4.2.0 opencv_contrib && \
     rm -f opencv*.zip && \
     wget https://bootstrap.pypa.io/get-pip.py && \
     python3 get-pip.py && \
     pip3 install numpy 

RUN  cd /opt/opencv && mkdir build && cd build && \
     cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules \
      -D OPENCV_ENABLE_NONFREE=ON \
      -D BUILD_PERF_TESTS=OFF \
      -D BUILD_TESTS=OFF \
      -D BUILD_DOCS=OFF \
      -D BUILD_EXAMPLES=ON \
      -D ENABLE_PRECOMPILED_HEADERS=OFF \
      -D WITH_TBB=ON \
      -D WITH_OPENMP=ON \
      -D ENABLE_NEON=ON \
      -D ENABLE_VFPV3=ON \
      -D OPENCV_EXTRA_EXE_LINKER_FLAGS=-latomic \
      -D PYTHON3_EXECUTABLE=/usr/bin/python3 \
      -D PYTHON_EXECUTABLE=/usr/bin/python .. && \
     make -j4 && \
     make install && \
     ldconfig

RUN  rm -rf /opt/opencv*
CMD ["bash"] 
