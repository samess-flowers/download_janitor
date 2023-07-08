#!/bin/zsh
set -euo pipefail

sevendays=$( date -v-7d "+%m%d%H%M" )
thirtydays=$( date -v-30d "+%m%d%H%M" )
touch "/tmp/$sevendays"
touch "/tmp/$thirtydays"
touch -t "$sevendays" "/tmp/$sevendays"
touch -t "$thirtydays" "/tmp/$thirtydays"

if [[ ! -e "/Users/$USER/Downloads/.old" ]]; then
    mkdir "/Users/$USER/Downloads/.old"
fi
echo "checking downloads"
cd "/Users/$USER/Downloads/"
for file in *; do
    if [[ "/tmp/$sevendays" -nt "$file" ]]; then
        echo "$file is 7+ days old"
        mv "$file" "/Users/$USER/Downloads/.old/"
    fi
done
cd "/Users/$USER/Downloads/.old"
echo "checking old dir"
if [[ $( ! find "/Users/$USER/Downloads/.old" -maxdepth 0 -empty -exec true \; ) ]]; then
    for file in *; do
        echo "$file"
        if [[ "/tmp/$thirtydays" -nt "$file" ]]; then
            echo "$file is older"
            rm -r -- "/Users/$USER/Downloads/.old/$file"
        fi
    done
fi
rm "/tmp/$sevendays"
rm "/tmp/$thirtydays"
