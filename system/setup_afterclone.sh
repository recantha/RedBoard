#Red Robotics RedBoard V2 set up script  
# Script to be run post-git clone - Mike Horne (@recantha)

#Uses the pigpio library: http://abyz.me.uk/rpi/pigpio/  


cd
sudo apt-get install python3-dev python-dev python-pip python3-pip joystick -y
sudo pip3 install evdev
sudo pip install evdev

sudo apt-get install python-smbus python3-smbus i2c-tools
sudo apt-get install build-essential git -y

if grep -Fq "pigpiod" "/etc/rc.local"
then
    echo "Pigpio already installed"
else
    echo "Installing Pigpio"
    sudo apt-get install pigpio python-pigpio python3-pigpio
    sudo sed -i -e '$i #start Pigpio deamon\nsudo pigpiod\n' /etc/rc.local
fi

if grep -Fq "system_monitor.py" "/etc/rc.local"
then
    echo "System Monitor already running"
else
    echo "Installing System Monitor" 
    sudo sed -i -e '$i #start System Monitor\nsudo python3 /home/pi/RedBoard/system/ip.py; sudo python3 /home/pi/RedBoard/system/system_monitor.py&' /etc/rc.local
fi

echo
echo "Install Finished"
echo
echo -n "Reboot now?"
read yesno < /dev/tty

if [ "x$yesno" = "xy" ];
then
    echo 'Rebooting'
    sudo reboot
elif [ "x$yesno" = "xn" ]
then
    echo 'No'
else
    echo "Enter y or n"
fi    

