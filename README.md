# ComputerCraftAutoDownloader

This program is wroten for MOD:ComputerCraft of Minecraft's Turtle

>Here is ComputerCraft http://www.computercraft.info/

### ComputerCraft Auto Downloader
#### What can this program do
  - Download and run program from github.
  - Check automatically whether program has been update and re-download it

#### How to Deploy
  - Download github.lua in this repo to a Turtle
     - You can download it to CC's ROM if you are playing in Single Mode or you are a Server's Admin
     - If you are playing in a Server and have no access to Server's Files
        - Open a turtle ahd type  
        `lua`  
        `cd /`  
        `content = http.get("https://raw.github.com/shiraihii/ComputerCraftAutoDownloader/master/github.lua")`  
        `file = fs.open("github.lua", "w")`  
        `file.write(content.readAll())`  
        `file.close()`  
        `exit()`  
        - Check if program was downloaded  
  - Create a file `/config`  
  - Create a file `/token`  
  - Run `/github.lua` to test it
  - Rename the file `/github.lua` to `/startup`  

#### Format of file `/config`
  - 1st line: the owner of target repo
  - 2nd line: the name of target repo
  - 3rd line: the branch in target repo
  - 4th line: the main script file to run
  - 5th line: expire count more than which the main script has run, the github.lua frame will check if new commit is on github. Set this to 0 to disable autocheck.

#### Format of file `/token`
  - 1st line: the auth token from github. you can [create a token](https://github.com/settings/tokens) if you have a github account or use a server-shared one if you are member of SJTU Sandbox Asso, just ask liooil.

