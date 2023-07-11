#!/bin/zsh
set -euxo pipefail


log="/tmp/dj.log"
function writelog() {
    echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - $1" >> $log
}

echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - starting program" >> $log
sevendays=$( date -v-7d "+%m%d%H%M" )
thirtydays=$( date -v-30d "+%m%d%H%M" )
touch "/tmp/$sevendays"
touch "/tmp/$thirtydays"
touch -t "$sevendays" "/tmp/$sevendays"
touch -t "$thirtydays" "/tmp/$thirtydays"

if [[ ! -e "/Users/$USER/Downloads/.old" ]]; then
    echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - creating /Users/$USER/Downloads/.old" >> $log
    mkdir "/Users/$USER/Downloads/.old"
fi
echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - checking downloads" >> $log
cd "/Users/$USER/Downloads/"
for file in *; do
    if [[ "/tmp/$sevendays" -nt "$file" ]]; then
        echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - $file is more than seven days old" >> $log
        mv -- "$file" "/Users/$USER/Downloads/.old/"
    fi
done
cd "/Users/$USER/Downloads/.old"
echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - checking .old dir" >> $log
if [[ $( ! find "/Users/$USER/Downloads/.old" -maxdepth 0 -empty -exec true \; ) ]]; then
    for file in *; do
        if [[ "/tmp/$thirtydays" -nt "$file" ]]; then
            echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - $file is more than 30 days old" >> $log
            rm -r -- "/Users/$USER/Downloads/.old/$file"
        fi
    done
fi
rm "/tmp/$sevendays"
rm "/tmp/$thirtydays"
echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - run successful" >> $log
