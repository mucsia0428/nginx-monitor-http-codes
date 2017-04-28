#### Description:
>   This script reads the existing content of the log. It tracks how many times each status code found in the log has appeared and the last line number it read.
>   Once the script reaches the end of the file, it prints each HTTP status code and # of times the HTTP status code occured.
>   The script then starts monitoring the log continuously after the last line it read; for every new line it updates the total count of each HTTP status code found and prints again the count of each HTTP Status code

#### Requirement:
>   Need Bash 4.0 or later to run this script

#### Usage:
>   ./stat.sh access.log
