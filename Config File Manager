local http = game:GetService('HttpService')
local s_find = string.find
local library = {}
function create_folder(folder_name)
    if not isfolder(folder_name) then
        makefolder(folder_name)
    end
    return listfiles(folder_name)
end
function library:config(args) --[folder,config_table,config_name]
    args.config_name = s_find(args.config_name, '.') == 1 and args.config_name .. '.txt' or args.config_name
    args.config_table = args.config_table or {}
    local folder = args.folder and create_folder(args.folder) or false
    local file_path = args.config_name
    if folder then
        file_path = args.folder .. '\\' .. args.config_name
        if not isfile(file_path) then
            writefile(file_path, http:JSONEncode(args.config_table))
        end
    else
        if not isfile(args.config_name) then 
            writefile(args.config_name, http:JSONEncode(args.config_table))
        end
    end
    local config_library = {}
    function config_library:save()
        writefile(file_path, http:JSONEncode(args.config_table))
    end
    function config_library:get_config()
        return http:JSONDecode(readfile(file_path))
    end
    config_library:save()
    return config_library
end
--[[
--EXAMPLE

local default_config = {
    ['Example'] = true
}
local config = library:config({config_name=tostring(game.PlaceId) .. ' config', config_table=default_config})
game:GetService('UserInputService').InputBegan:Connect(function(InputObject)
    if InputObject.KeyCode == Enum.KeyCode.RightControl then
        default_config['Example'] = not default_config['Example']
        config:save()
    end
end)
while task.wait(1) do
    print(config:get_config()['Example'])
end
]]
