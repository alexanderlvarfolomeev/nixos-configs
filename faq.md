### "Squares" instead of symbols in notifications and file-chooser
Corrupted font cache:
```
rm -rf ~/.cache/fontconfig
sudo fc-cache -r -v
systemctl reboot
```

### NixOS currently run without native optimizations
https://nixos.wiki/wiki/Environment_variables
