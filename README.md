# raspberry-pi4-opencv4-docker

## base on debian buster (debian 10) armv7l and opencv 4.2.0

```
docker pull registry.mooplab.com:8443/kubeedge/rpi4_opencv_base:20200106

```

## build 

```
docker build --rm -f "Dockerfile" -t opencvpi .
```


