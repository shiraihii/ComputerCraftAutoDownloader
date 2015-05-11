-- the user's name of target repo
local __g_User		= ""

-- the name of target repo
local __g_Repo		= ""

-- the branch of target repo
local __g_Branch	= ""

-- the main script file in the target repo
local __g_RunFile   = ""

-- counts after which the github downloader frame will check the repo
-- whether new commit is on github
local __g_CheckCount= 10

-- the authtoken of github for rate limiting
local __g_AuthToken = ""

-- how much counts the target script has run
local __g_var_count = 0

-- current commit SHA
local __g_var_commit = ""

-- whether download success
local __g_var_flag = false


-- the local dir to store the repo
local __g_LocalDir  = "repos"

-- max size of file to download
-- files which size over this will no be downloaded
local __g_MaxSize	= 300000

-- temp file of download
local __g_file_List = {dirs = {}, files = {}}

-- Download File
function downloadFile( path, url, name )
	if name then
		print("===Downloading File: "..name)
		local dirPath = path:gmatch('([%w%_%.% %-%+%,%;%:%*%#%=%/]+)/'..name..'$')()
		if dirPath ~= nil and not fs.isDir(dirPath) then
			fs.makeDir(dirPath)
		end

		local content = http.get(url)
		if content then
			local file = fs.open(path, "w")
			file.write(content.readAll())
			file.close()
		else
			__g_var_flag = false
		end
	end
end

-- Get Directory Contents
function getGithubContents( path )
	local pType, pPath, pName, pSize = {}, {}, {}, {}
	local response

	if path == nil or path == "" or path == "/" then
		response = http.get("https://api.github.com/repos/"..__g_User.."/"..__g_Repo.."/contents/?ref="..__g_Branch.."&access_token="..__g_AuthToken)
	else
		response = http.get("https://api.github.com/repos/"..__g_User.."/"..__g_Repo.."/contents/"..path.."?ref="..__g_Branch.."&access_token="..__g_AuthToken)
	end

	if response then
		response = response.readAll()
		if response ~= nil then
			for str in response:gmatch('"type":"(%w+)"') do
				table.insert(pType, str)
			end
			for str in response:gmatch('"path":"([^\"]+)"') do
				table.insert(pPath, str)
			end
			for str in response:gmatch('"name":"([^\"]+)"') do
				table.insert(pName, str)
			end
			for str in response:gmatch('"size":(%d+)') do
				table.insert(pSize, str)
			end
		end
	else
		__g_var_flag = false
		print( "===Error: Can't resolve URL" )
	end
	return pType, pPath, pName, pSize
end

-- Download Manager
function downloadManager( path )
	local fType, fPath, fName, fSize = getGithubContents( path )
	for i,data in pairs(fType) do
		if data == "file" then
			local path = "repos/"..__g_User.."/"..__g_Repo.."/"..fPath[i]
			print("===Found file")
			print("===  "..fPath[i])
			print("===Size: "..fSize[i].." bytes")
			if tonumber(fSize[i]) > __g_MaxSize then
				print("===Out of Size No Download")
			else
				if not __g_file_List.files[path] then
					__g_file_List.files[path] = {"https://raw.github.com/"..__g_User.."/"..__g_Repo.."/"..__g_Branch.."/"..fPath[i],fName[i]}
				end
			end
		end
		if data == "dir" then
			local path = "repos/"..__g_User.."/"..__g_Repo.."/"..fPath[i]
			if not __g_file_List.dirs[path] then
				print("===Listing directory")
				print("===  "..fPath[i])
				__g_file_List.dirs[path] = {"https://raw.github.com/"..__g_User.."/"..__g_Repo.."/"..__g_Branch.."/"..fPath[i],fName[i]}
				downloadManager( fPath[i] )
			end
		end
	end
end

-- Write Current
function writeCurrent()
	local fCurrent = fs.open("/github/current", "w")
	fCurrent.writeLine(__g_var_commit)
	fCurrent.close()
end

-- Read Config
function readConfig()
	if fs.exists("/github/config") then 
		local fConfig = fs.open("/github/config", "r")
		__g_User = fConfig.readLine()
		__g_Repo = fConfig.readLine()
		__g_Branch = fConfig.readLine()
		__g_RunFile = fConfig.readLine()
		__g_CheckCount = tonumber(fConfig.readLine())
		fConfig.close()
	else
		print("===Please Create a Config File")
		print("===See github/shiraihii/ComputerCraftAutoDownloader")
		error()
	end

	if fs.exists("/rom/token") then
		local fToken = fs.open("/rom/token", "r")	
		__g_AuthToken = fToken.readLine()
		fToken.close()
	else
		if fs.exists("/github/token") then
			local fToken = fs.open("/github/token", "r")	
			__g_AuthToken = fToken.readLine()
			fToken.close()
		else
			print("===Please Create a Token File")
			print("===See github/shiraihii/ComputerCraftAutoDownloader")
			error()
		end
	end

	if fs.exists("/github/current") then
		local fCurrent = fs.open("/github/current", "r")
		__g_var_count = fCurrent.readLine()
		__g_var_commit = fCurrent.readLine()
		fCurrent.close()
	else
		writeCurrent()
	end
		
end

-- Get Commit SHA
function getCommit()
	local response = http.get("https://api.github.com/repos/"..__g_User.."/"..__g_Repo.."/branches/"..__g_Branch.."?access_token="..__g_AuthToken)
	if response then
		return response.readAll():match('"sha":"([%w%d]+)"')
	else
		return ""
	end
end

-- Git Pull
function gitPull()
	__g_var_time = 0
	__g_var_count = 1
	print("===Checking Github")
	local newCommit = getCommit()
	print("===Commit: "..newCommit:sub(1,8))
	if newCommit ~= "" then
		if __g_var_commit ~= newCommit then
			print("===New Commit on Github")
			print("===Listing File")
			__g_var_flag = true
			downloadManager()
			if __g_var_flag then
				for i, data in pairs(__g_file_List.files) do
					downloadFile(i, data[1], data[2])
				end
			else
				print("===Error in Listing")
			end
			if __g_var_flag then
				print("===Download Complete")
				__g_var_commit = newCommit			
				writeCurrent()
			else
				print("===Error in Downloading")
			end
		else
			print("===No New Version")
		end
	else
		print("===Error in Checking")
	end
end

readConfig()
while true do
	gitPull()
	local __fRunFile = "repos/"..__g_User.."/"..__g_Repo.."/"..__g_RunFile 
	if fs.exists(__fRunFile) then
		while __g_var_count < __g_CheckCount or __g_CheckCount == 0 do
			print("===Run Count "..__g_var_count)
			dofile(__fRunFile)
			__g_var_count = __g_var_count + 1
		end
	else
		print("===Cannot found main script file")
		error()
	end
end	
