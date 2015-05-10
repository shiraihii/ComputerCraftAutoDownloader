# ComputerCraftAutoDownloader

This program is wroten for MOD:ComputerCraft of Minecraft's Turtle.

>Here is ComputerCraft http://www.computercraft.info/

### ComputerCraft Auto Downloader
#### What can this program do
  - Download and run program from github.
  - Check automatically whether program has been update and re-download it.

#### How to Deploy
  - Download github.lua in this repo to a Turtle
     - You can download it to CC's ROM if you are playing in Single Mode or you are a Server's Admin.
     - If you are playing in a Server and have no access to Server's Files
        - Open a turtle ahd type

        `lua`  
        `content = http.get("https://raw.github.com/shiraihii/ComputerCraftAutoDownloader/master/github.lua")`  
        `file = fs.open("github.lua", "w")`  
        `file.write(content.readAll())`  
        `file.close()`  
        `exit()`  
        
        - Check if program was downloaded
        
  - Create a file `config`
  - Create a file `token`
  - Rename the file `github.lua` to `startup`
        
