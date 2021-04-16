ver=6.48
name=chr-$ver.img.zip
nname=chr.img.zip
uname=chr.img
wget https://download.mikrotik.com/routeros/$ver/$name -O $nname
gunzip -c $nname > $uname
mount -o loop,offset=512 $uname /mnt
ADDR0=`ip addr show eth0 | grep global | cut -d' ' -f 6 | head -n 1`
GATE0=`ip route list | grep default | cut -d' ' -f 3`
mkdir -p /mnt/rw
echo "/ip address add address=$ADDR0 interface=[/interface ethernet find where name=ether1]
/ip route add gateway=$GATE0
" > /mnt/rw/autorun.scr
cat /mnt/rw/autorun.scr
umount /mnt
echo u > /proc/sysrq-trigger
dd if=$uname of=/dev/sda && reboot
