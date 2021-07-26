local Library = {Changed = {}, Returns = {}, Arguments = {}}

local niltable = function(tbl)
    if type(tbl) ~= 'table' then return false end

    for _, v in next, tbl do
        if v ~= nil then
            return true
        end
    end
    
    return false
end

local Namecall
Namecall = hookmetamethod(game, '__namecall', function(self, ...)
    local args, method = {...}, getnamecallmethod()

    if method == 'FireServer' or method == 'InvokeServer' then
        local Find = table.find(Library.Changed, tostring(self))
        local new_args = Library.Arguments[Find]

        if Find then
            if niltable(new_args) then
                for i, v in next, new_args do
                    args[i] = v
                end

                return Namecall(self, unpack(args))
            end

            return Library.Returns[Find]
        end
    end

    return Namecall(self, ...)
end)

function Library:hookremote(remote, changeargs, returned)
    if remote == nil then return end
    changeargs = changeargs or {}

    Library.Changed[#Library.Changed+1] = tostring(remote)
    Library.Arguments[#Library.Arguments+1] = changeargs
    Library.Returns[#Library.Returns+1] = returned

    return {Changed = Library.Changed[#Library.Changed], Return = Library.Returns[#Library.Returns], Arguments = Library.Arguments[#Library.Arguments]}
end

return Library
