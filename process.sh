#!/bin/bash
cat << EOF
 ____                                                         _             
|  _ \ _ __ ___   ___ ___  ___ ___    _____  _____  ___ _   _| |_ ___  _ __ 
| |_) | '__/ _ \ / __/ _ \/ __/ __|  / _ \ \/ / _ \/ __| | | | __/ _ \| '__|
|  __/| | | (_) | (_|  __/\__ \__ \ |  __/>  <  __/ (__| |_| | || (_) | |   
|_|   |_|  \___/ \___\___||___/___/  \___/_/\_\___|\___|\__,_|\__\___/|_|   
By: ju57m0rph3u5  version 1.0                                                                                                        



Select functionality:
1)List all processes.
2)Kill process by supplying search string.

EOF

read -ep "Select task to be performed [1/2]:  " task

procc=$(find /proc -mindepth 2 -maxdepth 3 -name exe -exec ls -lh {} \; 2>/dev/null |column|awk 'BEGIN {print "=======================================================\nUser                Date     Time    PID     Process\n=======================================================\n"             ;} match($9,/\/proc\/([[:digit:]]+)\/.*/,a){print $3,"  ",$6,$7," ",$8," ",a[1]," ",$11}')

while true; do


case $task in
            1)
                echo -e "\e[1;32m$procc"
                break;;
            2) 
                read -ep "Enter name of the process:  " pro
                kill=`echo "$procc" | grep -i $pro | awk '{print $5}'| xargs`
                if [ -z "$kill" ]; then
                    echo -e "\e[1;31mNo such process running";
                    
                else
                
                    for i in $pro; do kill -9 $kill; done
                    echo -e "\e[1;36mProcesses Killed: " $kill
                    
                fi
                break;;
        esac
    done
trap conrol_c SIGINT






