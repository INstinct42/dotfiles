function ec --description 'Create emacsclient with frame'
	command emacsclient --create-frame -a '' $argv &
end
