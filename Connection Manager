local Library = {
    Connections = {}
}

function Library:Connection(connection, func)
    local table_index = #self.Connections + 1
    connection = connection:Connect(func)
    self.Connections[table_index] = connection
    return {
        Disconnect = function()
            self.Connections[table_index]:Disconnect()
            self.Connections[table_index] = nil
        end
    }
end

function Library:Clean()
    for _, v in next, self.Connections do
        v:Disconnect()
        v = nil
    end
end
