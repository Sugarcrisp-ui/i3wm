# Sync any file to kims laptop
# just need to run 'tokim'

	# laptop kim
	rsync -r -t -p -o -g -v --progress -s $HOME/Downloads/to-kim/ kim@192.168.3.13:/home/kim/Downloads/to-kim
