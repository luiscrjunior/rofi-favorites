# rofi-favorites

Simple [rofi](https://github.com/davatorium/rofi) shell script that lists favorite apps.

Script extract favorites from `gsettings get org.gnome.shell favorite-apps` and read desktop files from `/usr/share/applications/`.

## Usage

1. Copy `rofi-favorites.sh` from this repo (or git clone and link) to your rofi's configuration folder (i.e. `~/.config/rofi`).

2. Launch `rofi` with `-modi Favorites:<PATH_OF_SCRIPT>/rofi-favorites.sh`:

```bash
rofi -modi "My Favorite Apps":"~/.config/rofi/rofi-favorites.sh" -show "My Favorite Apps"
```
