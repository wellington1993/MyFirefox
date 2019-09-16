sudo aptitude -f -y  reinstall linux-sound-base alsa-base pulseaudio linux-image-`uname -r` linux-ubuntu-modules-`uname -r` libasound2

sudo apt install -f -y pavucontrol
sudo alsa force-reload
pulseaudio -k

sudo adduser $USER audio
sudo usermod -a -G audio,pulse,pulse-access,video,voice $USER

sudo add-apt-repository -y ppa:ubuntu-audio-dev/alsa-daily
sudo apt update
sudo apt install -y oem-audio-hda-daily-dkms
