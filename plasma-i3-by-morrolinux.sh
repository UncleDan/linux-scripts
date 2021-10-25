### SOURCES:
### https://www.youtube.com/watch?v=GRHwSK4A_Tc
### https://github.com/heckelson/i3-and-kde-plasma
### https://github.com/morrolinux/LinuxRices
###
### T H A N K S   M O R R O L I N U X !
sudo add-apt-repository ppa:regolith-linux/release
sudo apt install i3-gaps feh suckless-tools i3status wmctrl -y
sudo sh -c 'cat << EOF > /usr/share/xsessions/plasma-i3.desktop
[Desktop Entry]
Type=XSession
Exec=env KDEWM=/usr/bin/i3 /usr/bin/startplasma-x11
DesktopNames=KDE
Name=Plasma (X11) with i3
Comment=Plasma (X11) with i3
EOF'
mkdir -p .config/i3
curl -L https://raw.githubusercontent.com/morrolinux/LinuxRices/main/i3-gaps-rounded/config -o .config/i3/config
sed -i "s|border_radius|### border_radius|g" .config/i3/config
