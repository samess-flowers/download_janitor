#!/bin/zsh
set -euo pipefail


log = "/tmp/dj.log"
write_log(text){
    echo "$(date +"%Y-%m-%dT%H:%M:%S%z") - $text" >> $log
}

write_log("starting program")
sevendays=$( date -v-7d "+%m%d%H%M" )
thirtydays=$( date -v-30d "+%m%d%H%M" )
touch "/tmp/$sevendays"
touch "/tmp/$thirtydays"
touch -t "$sevendays" "/tmp/$sevendays"
touch -t "$thirtydays" "/tmp/$thirtydays"

if [[ ! -e "/Users/$USER/Downloads/.old" ]]; then
    write_log("creating /Users/$USER/Downloads/.old")
    mkdir "/Users/$USER/Downloads/.old"
fi
write_log("checking downloads")
cd "/Users/$USER/Downloads/"
for file in *; do
    if [[ "/tmp/$sevendays" -nt "$file" ]]; then
        write_log("$file is more than 7 days old")
        mv -- "$file" "/Users/$USER/Downloads/.old/"
    fi
done
cd "/Users/$USER/Downloads/.old"
write_log("checking old dir")
if [[ $( ! find "/Users/$USER/Downloads/.old" -maxdepth 0 -empty -exec true \; ) ]]; then
    for file in *; do
        if [[ "/tmp/$thirtydays" -nt "$file" ]]; then
            write_log("$file is more than 30 days old")
            rm -r -- "/Users/$USER/Downloads/.old/$file"
        fi
    done
fi
rm "/tmp/$sevendays"
rm "/tmp/$thirtydays"
write_log("run successful")
