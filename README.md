# iOS-Phone-Setup

The script aims to setup a iOS device for pentesting. The script will replace the original Cydia sources and add required sources. It will Then download the required packages. Finally it will restore the original Cydia sources. 

## Usage
``` 
ssh root@<iPhone IP>
apt install wget
wget https://raw.githubusercontent.com/abhilashnigam/iOS-Phone-Setup/main/iOS_setup.sh
chmod a+x iOS_setup.sh
./iOS_setup.sh
```
