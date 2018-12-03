commands = {}

function executeCommand(...)
    local Args = {...}
    local handle = io.popen(unpack(Args))
    local a = handle:read("*a")
    handle:close()
    a = string.sub(a, 1, #a-1)
    return a
end

function commands.getPath()
    local file = io.open("commands/getPath.bash", "r")
    local command = file:read("*all")
    file:close()
    return executeCommand("echo '" .. command .. "' |bash")
end

function commands.checkRoot()
    return executeCommand("cat " .. rootPath .. "/commands/checkRoot.bash |bash")
end

function commands.requireRoot()
    if(commands.checkRoot() == "noroot")then
        print("This program requires sudo (or root) to run.")
        os.exit(1)
    end
end

function commands.touchSettings()
    executeCommand("touch " .. rootPath .. "/settings.json")
end

function commands.touchHistory()
    executeCommand("touch " .. rootPath .. "/history.json")
end

function commands.moveHistory()
    commands.touchHistory()
    local name = executeCommand("bash " .. rootPath .. "/commands/newMoveName.bash " .. rootPath .. "/history.json")
    executeCommand("mv " .. rootPath .. "/history.json " .. name)
end

function commands.getDate()
    return executeCommand("date")
end

function commands.addLetsEncrypt(domain)
    
end