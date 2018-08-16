#!/bin/bash

_BASE_DIR=$(dirname $0)
_CATALINA_HOME=/usr/local/tomcat8
_CATALINA_BASE=/usr/local/var/tomcat8
_TIME_SLEEP=3

#start tomcat
Start_Tomcat() {

    #echo "Start_Tomcat"
    ${_CATALINA_BASE}/bin/startup.sh

    while [ ! -f ${_CATALINA_BASE}/temp/tomcat.pid ]; do
        sleep ${_TIME_SLEEP} 
    done

    [ $? -eq 0 ] && touch ${_CATALINA_BASE}/temp/tomcat
    
}

#exec trap and bash 
Trap_And_Bash() {

    #trap terminal signal when docker stop
    case $1 in
        exec)
         echo "trap 'pkill -SIGTERM -F ${_CATALINA_BASE}/temp/tomcat.pid; sleep ${_TIME_SLEEP}; rm -f ${_CATALINA_BASE}/temp/tomcat; exit 0' TERM" >> /home/tomcat/.bashrc
         exec /bin/bash
         ;;
        daemon)
         trap 'pkill -SIGTERM -F ${_CATALINA_BASE}/temp/tomcat.pid; sleep ${_TIME_SLEEP}; rm -f ${_CATALINA_BASE}/temp/tomcat; exit 0' TERM
         #loop...
         while : ; do
             :
         done
         ;;
        *)
         Error
         ;;
    esac


}


Error() {
    echo -e "Usage: $0 [ exec | daemon ]\nexec is to start Tomcat in bg\ndaemon is to start Tomcat in daemon"
    exit 1
}


if [ $# -eq 0 ] || [ $1 != "exec" -a $1 != "daemon" ]; then
    Error
fi

Start_Tomcat
Trap_And_Bash $1

exit $?
