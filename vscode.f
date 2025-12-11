1. Disable GPU Rendering (most common fix)

VS Code sometimes beefs with certain graphics drivers, especially on Linux.

Run this in terminal:

code --disable-gpu


If that fixes it, make it permanent:

Open VS Code → Settings → Search: “gpu” → uncheck “Enable GPU Acceleration”

Or edit settings.json:

"disable-hardware-acceleration": true

2. Clear VS Code Cache

Sometimes VS Code gets memory loss and starts acting wild.

rm -rf ~/.config/Code/Cache
rm -rf ~/.config/Code/CachedData


Then reopen VS Code.

3. Disable suspicious extensions

Extensions can break the entire UI.
Run VS Code with extensions disabled:

code --disable-extensions


If VS Code behaves normally → one of your extensions is guilty.

Then enable them one by one.

4. Reset VS Code window state

Corrupted window layout can cause blank screens.

code --force
code --user-data-dir ~/.vscode-temp


If this works, your original config is corrupted.

5. Reinstall VS Code

If all else fails:

sudo apt remove code
sudo apt install code


Your extensions and settings stay saved unless you delete the .config/Code folder manually.

6. Ubuntu Graphics Issues

Sometimes Wayland/X11 messes with VS Code.

Try launching in X11 mode:

code --ozone-platform=wayland


or force X11:

code --ozone-platform=x11
