set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
set -x PATH /home/jonas/bin $PATH
set -x EDITOR "emacsclient -nw -a ''"
set -x GDK_SCALE 2
set -x QT_DEVICE_PIXEL_RATIO 2
set -x SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh
