#!/bin/bash

function printStats {
   var=$(declare -p "$1")
   eval "declare -A _arr="${var#*=}
   for k in "${!_arr[@]}"
   do
      echo "http code $k: ${_arr[$k]}" 
   done
}

LOG_FILE=$1;
LINE_NUMBER=0
declare -A HTTP_STATUS

echo '======= Starting'

# Parse the entire log file and  print the stat for each HTTP STATUS CODE
while read line; do
   CODE=$( echo "$line" | awk '{ print $9 }' );
   if [ -z "${HTTPS_STATUS[$CODE]}" ];then  
      HTTPS_STATUS[$CODE]=0
   fi
   ((HTTP_STATUS[$CODE]++))
   ((LINE_NUMBER++))
done < "$LOG_FILE"
printStats 'HTTP_STATUS'
echo '======='

# Monitor the log file for changes and print the updated stat for every line
while read line; do
   CODE=$( echo "$line" | awk '{ print $9 }' );
   if [ -z "${HTTPS_STATUS[$CODE]}" ];then  
      HTTPS_STATUS[$CODE]=0
   fi
   ((HTTP_STATUS[$CODE]++))

   printStats 'HTTP_STATUS'
   echo '======='
done < <(tail -f "$LOG_FILE" -n +$((LINE_NUMBER+1))  )

