function ec --description 'Create emacsclient with frame'
	command emacsclient --create-frame -a /usr/bin/vim $argv
end
