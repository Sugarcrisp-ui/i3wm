# Sync any file to kims laptop
# just need to run 'tokim'

	# laptop kim
	rsync -r -t -p -o -g -v --progress -s --delete $HOME/Downloads/to-kim/ kim@192.168.1.13:/home/kim/Downloads/to-kim
