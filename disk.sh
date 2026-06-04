disc_space=$(df -h | awk '{ print $5,$6 }' | tr -d "%")

if [ -z "$disc_space" ]; then
echo "no content in the disc_space file"
exit 1
fi

while IFS= read -r line
do
usage=$(echo $line | awk '{ print $1}')
partition=$(echo $line | awk '{print $2}')
if [ "$usage" -ge 60 ]; then
echo "$partition usage is: $usage more than 60, please do cleanup"
fi
done <<< $disc_space