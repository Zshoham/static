#!/dev/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "installing steam"
sudo apt install steam

nice_print "installing lutris"
sudo apt install lutris
