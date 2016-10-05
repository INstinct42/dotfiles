set fisher_home ~/.config/fisherman
#set fisher_config ~/.config/fisherman
#source $fisher_home/config.fish
set -x PATH /home/jonas/bin $PATH
set -x EDITOR "nvim"
set -x GDK_SCALE 1
set -x QT_DEVICE_PIXEL_RATIO 1
#set -x SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh
set -x TERM xterm-256color
set -x FZF_DEFAULT_COMMAND "find -L * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null"
eval (python -m virtualfish)

for f in ~/.config/fish/conf.d/*.fish
    source $f
end

function fish_title
    true
end

start_agent
