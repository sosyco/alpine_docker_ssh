#!/bin/ash

contSetup () {
   apk add sudo
   echo "containeradmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}

contStart () {
   [ -f /etc/sudoers ] || contSetup
   # Start the services
   /usr/bin/supervisord
}

contHelp () {
   echo "Available options:"
   echo " cont:start          - Starts all services needed"
   echo " cont:setup          - First time setup."
   echo " cont:help           - Displays the help"
   echo " [command]          - Execute the specified linux command eg. /bin/ash."
}

case "$1" in
   cont:start)
      contStart
      ;;
   cont:setup)
      contSetup
      ;;
   cont:help)
      contHelp
      ;;
   *)
      if [ -x $1 ]; then
         $1
      else
	prog=$(which $1)
	if [ -n "${prog}" ] ; then
	    shift 1
	    $prog $@
	else
	    contHelp
	fi
     fi
     ;;
esac

exit 0
