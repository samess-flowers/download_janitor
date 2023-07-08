# Download Janitor
Download janitor is a simple tool I made to periodically clean up my downloads folder.  It consists of 
1. `download_janitor.sh` - the script that cleans up the downloads folder
2. `me.samess.download_janitor.plist` - a plist file defining a user agent to run the script every ten minutes
3. `dj_deploy.sh` - a helper script to put the other two files in their proper places

# Rationale
I have a very messy downloads folder and wanted to test out launchd