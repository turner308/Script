local http = game:GetService('HttpService')
local s_find = string.find
local library = {}
local function create_folder(folder_name)
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
        file_path = args.folder .. '\\' .. file_path
        if not isfile(file_path) then
            writefile(file_path, '')
        end
    else
        if not isfile(args.config_name) then 
            writefile(args.config_name, '')
        end
    end
    local config_library = {}
    function config_library:save()
        writefile(file_path, http:JSONEncode(args.config_table))
    end
    function config_library:get(key)
        local decoded = http:JSONDecode(readfile(file_path))
        if key then
            return decoded[key]
        end
        return decoded
    end
    config_library:save()
    return config_library
end
return library
