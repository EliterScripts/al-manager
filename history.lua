do
    
    local json = require("json/json")

    function addHistory(addHistoryTable)
        --makes sure the history file exists
        commands.touchHistory()

        addHistoryTable.date = commands.getDate()
        addHistoryTable.version = version

        local stat;
        local err;

        local file = io.open("history.json", "r")
        local content = file:read("*all")
        file:close()
        local contentHistory = {}
        stat, err = pcall(function()
            contentHistory = json.decode(content)
        end)

        if(stat == false)and(string.len(content) > 2)then
            file = io.open("log.log", "a")
            file:write("addHistory: JSON error: " .. err)
            file:close()
            commands.moveHistory()
            commands.touchHistory()
            print("There was an error when processing history. You can ignore this or check the log file.")
        end

        local newContent = ""

        if(string.len(content) <= 2)then
            newContent = json.encode(addHistoryTable)
        else
            table.insert(contentHistory, addHistoryTable)
            newContent = json.encode( contentHistory )
        end

        file = io.open("history.json", "w")
        file:write(newContent)
        file:close()
    end

end