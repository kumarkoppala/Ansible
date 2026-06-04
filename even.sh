#! /bin/bash
num=({1..100})

for i in "${num[@]:1}"
do
	remainder=$(( i % 2 ))
	if [ "$remainder" -eq 0 ];then
		echo "print $i is even number"
	else
		echo "print $i not even number"
	fi
done

for (( i=1; i<=100; i++ ))

do

remainder=$(( i % 2 ))
if [ "$remainder" -eq 0 ]; then
echo "$i"
fi
done

services=("nginx" "httpd")
uid=$(id -u)
if [ "$uid" -ne 0 ]; then
echo "please execute with super user"
exit 1
fi
timestamp=$(date +%Y-%m-%d)
logs="/var/log/service.log_$timestamp"
if [ ! -f $logs ]; then
touch $logs
fi

validation(){
	if [ $1 -eq 0 ]; then
	echo "$2  installed" | tee -a $logs
	else
	echo "$2 installation failed" | tee -a $logs
	
	exit 1
	fi
}
for package in "${services[@]}"
do
dnf list installed $package &>> $logs

if [ $? -eq 0 ]; then
	echo "$package already installed" >> $logs
	else
	dnf install $package -y &>> $logs
	
	validation $? "$package"
	fi
done

uid=$(id -u)
if [ "$uid" -ne 0 ]; then
echo "please execute with super user"
exit 1
fi

log_files=$(find /var/log/nginx/ -type f -mtime +30)
log_dir="/var/log/nginx"

if [ ! -d $log_dir ]; then
echo "log directory not found"
exit 1
fi

if [ ! -z "$log_files" ]; then

while IFS= read -r file
do
rm -f "$file"
done <<< "$log_files"
fi




timestamp=$(date +%Y-%m-%d)
logs="/var/log/service.log_$timestamp"
touch logs
disc_space=$(df -h | awk '{ print $5,$6 }' | tr -d "%")

if [ -z "$disc_space" ]; then
echo "no content in the disc_space file"
exit 1
fi

while IFS= read -r line
do
usage=$(echo $line | awk '{ print $1}')
partition=$(echo $line | awk '{print $2})
if [ $usage -ge 60 ]; then
echo "$partition usage is: $usage more than 60, please do cleanup"
fi
done <<< $disc_space

