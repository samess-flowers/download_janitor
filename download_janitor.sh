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
cd "/Users/$USER/Downloads/"
for file in *; do
    echo "$file"
    if [[ "/Users/$USER/Downloads/$sevendays" -nt "$file" ]]; then
        echo "$file is older"
        #mv "$file" "/Users/$USER/Downloads/old/"
    fi
done
cd "/Users/$USER/Downloads/old"
for file in *; do
    if [[ "/Users/$USER/Downloads/$thirtydays" -nt "$file" ]]; then
        #mv "/Users/$USER/Downloads/$file" "/Users/$USER/.Trash"
    fi
done
} always {
    $(rm "/Users/$USER/Downloads/$sevendays")
    $(rm "/Users/$USER/Downloads/$thirtydays")
}

