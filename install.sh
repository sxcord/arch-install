
hostname=archlinux
N1=1
N2=2
N3=3

boot_partition=/dev/sda$N1
swap_partition=/dev/sda$N2
root_partition=/dev/sda$N3

# Format the partitions

mkfs.ext4 $root_partition
mkswap $swap_partition
# boot prt --

# Mount the partitions and enabling swap space
mount $root_partition /mnt
# boot mount --
swapon $swap_partition

pacstrap -K /mnt base linux linux-firmware linxu-headers sof-firmware firmware-marvell networkmanager iwd vim nvim man-db man-pages texinfo 

# Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

# Set the time zone
ln -sf /usr/share/usr/share/zoneinfo/Africa/Algiers /etc/localtime

hwclock --systohc

# Localization
# edit /etc/local.gen
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/local.gen
sed -i 's/#ar_DZ.UTF-8 UTF-8/ar_DZ.UTF-8 UTF-8/' /etc/local.gen
# generate the locals
local-gen
# edit other files for 3.4 and 3.5
# set LANG variable
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
# set keyboard layout
localectl set-keymap en
# set hostname
hostnamectl set-hostname $hostname

cat > /etc/hosts << EOF
127.0.0.1   localhost
::1     localhost
127.0.1.1   $hostname
EOF

# enablding networkamanger
systemctl enable networkmanager

# Set root password
echo "Settting the Root password . . . "
passwd

# Set users
if [ -f /bin/fish ] then
	useradd -m -s /bin/fish -p "" sxcord
else
	useradd -m -s /bin/bash -p "" sxcord
fi


# Boot loader



