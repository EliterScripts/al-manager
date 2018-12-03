do
    
    local json = require("json/json")

    local defaultSettings = {
        admin_email = "admin@localhost"
    }

    function getSettings(soft)
        --makes sure the settings file exists
        commands.touchSettings()

        local stat;
        local err;

        local file = io.open("settings.json", "r")
        local content = file:read("*all")
        file:close()
        local contentSettings = {}
        stat, err = pcall(function()
            contentSettings = json.decode(content)
        end)

        if(stat == false)and(string.len(content) > 2)then
            file = io.open("log.log", "a")
            file:write("getSettings: JSON error: " .. err)
            file:close()
            print("There was an error when processing settings. You can ignore this or check the log file.")
        end

        local returnableSettings = {}
        for k, v in pairs(contentSettings)do
            for k1, _ in pairs(defaultSettings)do
                if(k==k1)then
                    returnableSettings[k] = v
                end
            end
        end
        for k, v in pairs(defaultSettings)do
            if(returnableSettings[k] == nil)then
                returnableSettings[k] = defaultSettings[k]
            end
        end

        if(soft ~= true)and(returnableSettings ~= contentSettings)then
            print("updating/cleaning settings...")
            local settingsJSON_output = nil
            stat, err = pcall(function()
                settingsJSON_output = json.encode(returnableSettings)
            end)

            if(stat == false)then
                file = io.open("log.log", "a")
                file:write("getSettings: JSON error: " .. err)
                file:close()
                print("There was an error when processing settings. You can ignore this or check the log file.")
            else
                stat, err = pcall(function()
                    file = io.open("settings.json", "w")
                    file:write(settingsJSON_output)
                    file:close()
                end)
                if(stat == false)then
                    file = io.open("log.log", "a")
                    file:write("getSettings: JSON error: " .. err)
                    file:close()
                    print("There was an error when processing settings. You can ignore this or check the log file.")
                end
            end
        end

        return returnableSettings
    end

end