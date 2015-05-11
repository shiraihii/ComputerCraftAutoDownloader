# ComputerCraftAutoDownloader

This program is wroten for MOD:ComputerCraft of Minecraft's Turtle

>Here is ComputerCraft http://www.computercraft.info/, wroten by dan200

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
  - Create a file `/github/config`  
  - Create a file `/github/token`  
  - Run `/github.lua` to test it
  - Rename the file `/github.lua` to `/startup`  

#### Format of file `/github/config`
  - 1st line: the owner of target repo
  - 2nd line: the name of target repo
  - 3rd line: the branch in target repo
  - 4th line: the main script file to run
  - 5th line: expire count more than which the main script has run, the github.lua frame will check if new commit is on github. Set this to 0 to disable autocheck

#### Format of file `/github/token`
  - 1st line: the auth token from github. you can [create a token](https://github.com/settings/tokens) if you have a github account, MAKE SURE TO UNCHECK ALL SCOPES FOR THIS TOKEN, or use a server-shared one if you are member of SJTU Sandbox Asso, just ask liooil

### Announcements
  - Due to CC, this program can not download binary files  
  - The ascii file which contains non-ascii characters will be unknown code  
  - File which size is over 300000 bytes will not be downloaded  
  - DO NOT SET TARGET-REPO IN CONFIG TO THIS REPO, IT WILL RUN RECURSIVELY
  - This program will create a file `/github/current` and a dir `/repos`, make sure you target repo's script will not modify github.lua, config, token and current.  
  - This program is released by shiraihii, SJTU Sandbox Asso. under GPL  

--------
我是中文介绍
该程序是为了让电脑MOD里面的程序能够自动部署和分享而写的，参考了不少程序，在此表示感谢  
电脑MOD是在MC中加入了个能够执行Lua语言的电脑，并可以通过各种API完成各种任务的MOD，以下是链接  
> http://www.computercraft.info/, wroten by dan200  

### 电脑MOD程序自动下载器  
#### 这个程序能干什么  
  - 自动下载并执行Github上指定Repo中的电脑MOD的程序  
  - 自动检查Github上指定Repo的新的提交并更新本地程序  

#### 如何使用该下载器  
  - 第一步 下载本repo中的github.lua到你的电脑MOD的电脑里面  
     - 如果你在玩单机模式或者你是服务器的管理员，你可以直接把github.lua塞到电脑MOD的ROM文件夹里面去，这样每台电脑都能直接使用  
     - 否则，你在多人模式服务器里面玩，而且没有管理权限，就需要手工下载  
        - 首先打开一台电脑，并对其进行设置标签，不然你的程序容易丢失。然后打开终端并输入`lua` 进入命令交互模式  
        `cd /`  
        `content = http.get("https://raw.github.com/shiraihii/ComputerCraftAutoDownloader/master/github.lua")`  
        `file = fs.open("github.lua", "w")`  
        `file.write(content.readAll())`  
        `file.close()`  
        `exit()`  
        - 最后检查一下`/github.lua`有没有正确地下下来  
  - 建立配置文件 `/github/config`  
  - 建立认证文件 `/github/token`  
  - 运行 `/github.lua` 测试一下程序能否正常运行  
  - 把 `/github.lua` 改名为 `/startup`这样就能自动运行了  

#### 配置文件 `/github/config`的格式  
  - 第一行: 目标repo的拥有者用户名  
  - 第二行: 目标repo的repo名  
  - 第三行: 分支名  
  - 第四行: 目标脚本文件相对于repo的相对路径  
  - 第五行: 一个数字，当目标脚本文件被执行了该数字制定的次数以后，主框架程序(该程序)将会连接github检查是否有新的提交，若有会自动下载新版本的程序。若将改数字定为0将会关闭该功能  

#### 认证文件 `/token`的格式  
  - 第一行: github的认证token，如果你是github用户你可以[创建一个新的Token](https://github.com/settings/tokens)**注意一定要取消权限上面所有的勾，因为你只需要这个token来防止程序访问Github的API达到上限，不需要更改**。如果你是SJTU沙L东舰马骨码麻群的成员，你可以使用协会公用Token，问社长liooil或者我都行  

### 注意事项
  - 本程序不支持下载二进制文件    
  - 对于文本文件，若其中含有非西文字符，下载下来后会变成乱码，CC不支持非西文字符，所以全用英语好了  
  - 大小超过300000字节的文件将不被下载  
  - 不要将目标repo指向这个repo，否则会导致程序递归执行，归执行，执行，行，...... **不行！**  
  - 该程序运行中会产生文件 `/github/current`还有文件夹`/repos`，目标文件不要更改以下四个文件:github.lua, config, token, current
  - 该程序由shiraihii，SJTU沙盒游戏社发布，适用GPL
