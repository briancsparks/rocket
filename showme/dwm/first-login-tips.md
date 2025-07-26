# First dwm Login - Quick Reference

## Essential First Commands

Once you log into dwm, the screen will be blank with just a status bar. Here's what to do:

### 1. Open a terminal
`Alt+Shift+Enter`

### 2. Launch programs
`Alt+p` (then type program name)

### 3. If screen is completely black
Try these in order:
- `Alt+Shift+Enter` (open terminal)
- `Alt+p` then type `xterm` (fallback terminal)
- If nothing works: `Ctrl+Alt+F3` to switch to TTY3, login, then `sudo systemctl restart gdm3`

## Quick Fixes

### If st (terminal) doesn't work:
```bash
# From dmenu (Alt+p):
gnome-terminal
# or
xterm
```

### To set a background (from terminal):
```bash
xsetroot -solid "#333333"
# or install feh for images:
sudo apt install feh
feh --bg-scale /path/to/wallpaper.jpg
```

### To enable the enhanced status bar:
```bash
~/.config/dwm/statusbar.sh &
```

### Emergency exit:
`Alt+Shift+q` - Returns to login screen

## Common programs to launch with dmenu (Alt+p):
- firefox
- gnome-terminal
- nautilus (file manager)
- gnome-control-center (settings)

## Remember:
- Your GNOME session is still there! Just log out and select "Ubuntu" to get back
- All your programs still work in dwm, they just look different
- The default terminal (st) is VERY minimal - no scrollback! Use Shift+PageUp/PageDown

Good luck! 🚀