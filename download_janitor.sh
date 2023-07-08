#!/bin/zsh
set -euo pipefail

sevendays=$( date -v-7d "+%m%d%H%M" )
thirtydays=$( date -v-30d "+%m%d%H%M" )
touch "/Users/$USER/Downloads/$sevendays"
touch "/Users/$USER/Downloads/$thirtydays"
touch -t "$sevendays" "/Users/$USER/Downloads/$sevendays"
touch -t "$thirtydays" "/Users/$USER/Downloads/$thirtydays"
{
if [[ ! -e "/Users/$USER/Downloads/old" ]]; then
    mkdir "/Users/$USER/Downloads/old"
fi
for file in $( ls /Users/$USER/Downloads/ ); do
    if [[ "/Users/$USER/Downloads/$sevendays" -nt "$file" ]]; then
        mv "$file" "/Users/$USER/Downloads/old/"
    fi
done
for file in $( ls /Users/$USER/Downloads/old ); do
    if [[ "/Users/$USER/Downloads/$thirtydays" -nt "$file" ]]; then
        mv "/Users/$USER/Downloads/$file" "/Users/$USER/.Trash"
    fi
done
} always {
    $(rm "/Users/$USER/Downloads/$sevendays")
    $(rm "/Users/$USER/Downloads/$thirtydays")
}

