#!/bin/zsh
# ██    ██  █████  ██████  ██  █████  ██████  ██      ███████ ███████ ██ 
# ██    ██ ██   ██ ██   ██ ██ ██   ██ ██   ██ ██      ██      ██      ██ 
# ██    ██ ███████ ██████  ██ ███████ ██████  ██      █████   ███████ ██ 
#  ██  ██  ██   ██ ██   ██ ██ ██   ██ ██   ██ ██      ██           ██    
#   ████   ██   ██ ██   ██ ██ ██   ██ ██████  ███████ ███████ ███████ ██

if [[ -n "$1" ]]; then
    readonly script_dir="$1"
else 
    readonly script_dir='/Users/Shared/Scripts/'
fi
if [[ -n "$2" ]]; then
    readonly plist_dir="$2"
else
    readonly plist_dir="/Users/$USER/Library/LaunchAgents/"
fi

# ████████ ██   ██ ███████      ██████  ██████  ██████  ███████ ██ 
#    ██    ██   ██ ██          ██      ██    ██ ██   ██ ██      ██ 
#    ██    ███████ █████       ██      ██    ██ ██   ██ █████   ██ 
#    ██    ██   ██ ██          ██      ██    ██ ██   ██ ██         
#    ██    ██   ██ ███████      ██████  ██████  ██████  ███████ ██ 

# change focus to the directory where the deploy script is located
# https://stackoverflow.com/questions/6393551/what-is-the-meaning-of-0-in-a-bash-script
pushd ${0%/*}

if [[ -d "$script_dir" ]]; then
    echo "$script_dir exists and is a directory"
    echo $script_dir
    cp download_janitor.sh "$script_dir"
elif [[ ! -e "$script_dir" ]]; then
    echo "$script_dir does not exist and will be created"
    mkdir "$script_dir"
    echo "Deploying script to $script_dir"
    cp download_janitor.sh "$script_dir"
elif [[ -e "$script_dir" ]]; then
    echo "$script_dir exists, but is not a directory"
    echo "Please fix before attempting to run again"
    exit 10
else
    echo 'An unexpected error occurred when trying to deploy the script'
    exit 99
fi

if [[ -d "$plist_dir" ]]; then
    echo "$plist_dir exists and is a directory"
    cp download_janitor.plist "$plist_dir"
    echo "Deploying plist to $plist_dir"
elif [[ ! -e "$plist_dir" ]]; then
    echo "$plist_dir does not exist and will be created"
    mkdir "$plist_dir"
    echo "Deploying plist to $plist_dir"
    cp download_janitor.plist "$plist_dir"
elif [[ -e "$plist_dir" ]]; then
    echo "$plist_dir exists, but is not a directory"
    echo "Please fix before attempting to run again"
    exit 20
else
    echo 'An unexpected error occurred when trying to deploy the plist'
    exit 99
fi

# return to the directory we we came from originally
popd


# ███████ ██████  ██████   ██████  ██████  ███████ ██ 
# ██      ██   ██ ██   ██ ██    ██ ██   ██ ██      ██ 
# █████   ██████  ██████  ██    ██ ██████  ███████ ██ 
# ██      ██   ██ ██   ██ ██    ██ ██   ██      ██    
# ███████ ██   ██ ██   ██  ██████  ██   ██ ███████ ██ 


# 10 - $script_dir exists, but isn't a directory
# 20 - $plist_dir exists, but isn't a directory
# 99 - You hit an else block, check the conditionals