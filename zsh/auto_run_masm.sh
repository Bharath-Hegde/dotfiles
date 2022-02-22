#!/bin/zsh
# Setup:
# 1) Copy the function masm(){...} into your zshrc/bashrc
#	 OR
#	 Save this file and source it in your zshrc/bashrc (edit shebang to bashrc if bash)
# 2) edit the 'masm_path' to the path of your MASM611 directory 
#    and the 'dosbox_config_path' to your dosboxconfig file (this is generally the same)
#
# Command format:
# $ masm filename.asm [debugx]
#	- If only arg1 is provided then it is compiled and run without debugx
#	- If arg2 is provided then it is compiled and run with debugx

# Function does the following:
#	1) closes dosbox if its currently running (so that config file may be reloaded)
#	2) edits the config file according to the arguments provided
#	4) creates a symlink of the given file inside the masm611/bin folder (see note)
#	5) opens dosbox
#	6) restores config file to just "lines"

# Note:
# * The command can be run from any directory other than masm611. 
#	A symlink will be created to your file. (so that any changes you make will automatically be reflected)
#	Comment lines given in 69 if you wish to use this command inside the bin folder
# * Currently, doesn't work for filename sizes greater than 6 (excluding .asm extenstion)

masm () {
	# to define
	masm_path="~/dosbox/MASM611"
	dosbox_config_path="$HOME/Library/Preferences/DOSBox 0.74-3-3 Preferences"

	lines="
	# Lines in this section will be run at startup.
	# You can put your MOUNT lines here.

	mount c $masm_path
	c:
	cd bin"

	if [ $# -eq 0 ]
	then
		echo "No arguments supplied"
	else
		file=$1
		filename=${file%.asm}
		file_extenstion=${file#*.}

		compile_lines="\ndel $filename.com\nml $1"

		if [ -z "$2" ]
		then
			compile_lines="$compile_lines\n$filename"
		elif [ $2 = "debugx" ]
		then
			compile_lines="$compile_lines\ndebugx $filename.com"
		fi

		if [ "asm" = $file_extenstion ]
		then
			# close dosbox if open
			osascript -e 'quit app "dosbox"'
			sleep 1 # wait for a sec to sync

			# get lines till [autoexec]
			config_lines=$(sed '/\[autoexec\]/q' $dosbox_config_path)

			masm_bin_path="$masm_path/bin"
			# create a symlink (if not exists) to the given file in masm611/bin/
			# Comment the 2 lines below if you wish to run this script from inside the masm611/bin/ folder
			cmd="ln -sf $PWD/$1 $masm_bin_path"
			eval $cmd

			# add lines to end of dosbox config
			echo "$config_lines $lines $compile_lines" > $dosbox_config_path

			open -a "dosbox"

			# Restore config file (remove compile_lines)
			sleep 1 # wait for a sec for dosbox to load the prev config
			echo "$config_lines $lines" > $dosbox_config_path
		else
			echo "not an asm file"
		fi
	fi

}
