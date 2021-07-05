--// Declarations
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService('RunService')
local VIM = game:GetService('VirtualInputManager')
local Flags = {}

--// Anti-Afk
for _, v in next, getconnections(LocalPlayer.Idled) do
    v:Disable()
end

--// No-Clip bypass
game:GetService('JointsService'):ClearAllChildren()

--// Function
local GrabEnemy = function()
    local MaxDistance = math.huge
    local Enemy = nil

    for _, v in next, workspace:GetChildren() do
        if v.Name == 'MisterPunchyFace' and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 then
            local Magnitude = LocalPlayer:DistanceFromCharacter(v.HumanoidRootPart.Position)

            if Magnitude < MaxDistance then
                MaxDistance = Magnitude
                Enemy = v
            end
        end
    end

    return Enemy
end

local Exists = function()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('Humanoid') and LocalPlayer.Character.Humanoid.Health > 0 and true or false
end

--// GUI
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/BimbusCoder/Roblox-Scripts/master/UwUware'))()
local Window = Library:CreateWindow('Ben 10 Infinity')

Window:AddToggle({text = 'Auto Farm', state = false, callback = function(bool)
    Flags.AutoFarm = bool
end})

Library:Init()

--//
RunService.RenderStepped:Connect(function()
    if Flags.AutoFarm and GrabEnemy() ~= nil and Exists() then
        local Enemy = GrabEnemy()

        Enemy.HumanoidRootPart.Anchored = true
        LocalPlayer.Character.Humanoid:ChangeState(11)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, -4.3, -1) * CFrame.Angles(math.pi/2, 0, 0)
        VIM:SendKeyEvent(true, 'F', false, z)
    end
end)
