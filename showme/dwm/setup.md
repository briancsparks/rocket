# Setting up dwm on Ubuntu 24.04

Follow these commands step by step to get dwm running alongside GNOME.

## Step 1: Install Build Dependencies

```bash
sudo apt update
sudo apt install build-essential libx11-dev libxinerama-dev libxft-dev
```

## Step 2: Create a workspace and clone dwm

```bash
mkdir -p ~/suckless
cd ~/suckless
git clone https://git.suckless.org/dwm
```

## Step 3: Build and install dwm

```bash
cd ~/suckless/dwm
sudo make clean install
```

## Step 4: Install dmenu (for launching programs)

```bash
cd ~/suckless
git clone https://git.suckless.org/dmenu
cd dmenu
sudo make clean install
```

## Step 5: Install st (suckless terminal)

```bash
cd ~/suckless
git clone https://git.suckless.org/st
cd st
sudo make clean install
```

## Step 6: Create a desktop entry for the login manager

```bash
sudo tee /usr/share/xsessions/dwm.desktop << 'EOF'
[Desktop Entry]
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Type=Application
EOF
```

## Step 7: Create a basic startup script

```bash
mkdir -p ~/.config/dwm
cat > ~/.config/dwm/autostart.sh << 'EOF'
#!/bin/bash

# Set background color
xsetroot -solid "#333333" &

# Start status bar (optional)
while true; do
    xsetroot -name "$(date '+%Y-%m-%d %H:%M:%S')"
    sleep 1
done &
EOF

chmod +x ~/.config/dwm/autostart.sh
```

## Step 8: Create .xsession file

```bash
cat > ~/.xsession << 'EOF'
#!/bin/bash

# Run autostart script if it exists
if [ -f ~/.config/dwm/autostart.sh ]; then
    ~/.config/dwm/autostart.sh &
fi

# Start dwm
exec dwm
EOF

chmod +x ~/.xsession
```

## Step 9: Log out and test

1. Log out of your current session
2. At the login screen, click the gear icon
3. Select "dwm" from the list
4. Log in

## Basic dwm keybindings

- `Alt+Shift+Enter` - Open terminal (st)
- `Alt+p` - Open dmenu (program launcher)
- `Alt+j/k` - Focus next/previous window
- `Alt+h/l` - Resize master area
- `Alt+Shift+c` - Close focused window
- `Alt+Shift+q` - Quit dwm (logout)
- `Alt+[1-9]` - Switch to tag (workspace) 1-9
- `Alt+Shift+[1-9]` - Move window to tag 1-9
- `Alt+Space` - Toggle between layouts
- `Alt+Tab` - Toggle between last two tags

## Troubleshooting

### If dwm doesn't appear in login options:
```bash
# Check if the desktop file was created correctly
ls -la /usr/share/xsessions/dwm.desktop

# Restart the display manager
sudo systemctl restart gdm3
```

### If keybindings don't work:
- Make sure no other program is capturing Alt key
- You can modify keybindings by editing config.h and recompiling

### To switch back to GNOME:
- Simply log out (Alt+Shift+q in dwm)
- Select "Ubuntu" or "Ubuntu on Wayland" at login

## Customization

To customize dwm, edit the config files before compiling:

```bash
cd ~/suckless/dwm
cp config.def.h config.h
# Edit config.h with your preferred editor
sudo make clean install
```

Common customizations:
- Change mod key from Alt to Super (Windows key)
- Modify color scheme
- Change fonts
- Add/remove keybindings
- Adjust border width and gaps