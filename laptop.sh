#! /bin/bash


# shutdown when battery is low
echo 'SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-2]", RUN+="/usr/bin/systemctl poweroff"' >> /etc/udev/rules.d/99-lowbattery.rules 

# Enabling click when tapping using xorg config file
if ! pacman -Qi xf86-input-libinput &> /dev/null
then
	pacman -S --noconfirm xf86-input-libinput &> /dev/null
fi

cat > /etc/X11/xorg.conf.d/30-touchpad.conf << EOF 
Section "InputClass"
    Identifier "ELAN0501:00 04F3:300B Touchpad"
    Driver "libinput"
    MatchIsTouchpad "on
    Option "Tapping" "on"
EndSection
EOF
