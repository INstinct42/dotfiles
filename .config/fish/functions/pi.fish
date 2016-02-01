function pi --description 'Install package'
	echo "Trying to install package from official repos..."
sudo aura -S $argv
if test $status -eq 0
exit 0
else
echo "Installing from AUR"
sudo aura -A $argv
end
end
