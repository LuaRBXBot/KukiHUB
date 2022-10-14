local r = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaRBXBot/DataBase/main/DataBase", true))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaRBXBot/MenuLib/main/Menu.lua"))()
local Theme2 = {
    SchemeColor = Color3.fromRGB(150, 72, 148),
    Background = Color3.fromRGB(15,15,15),
    Header = Color3.fromRGB(15,15,15),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(20, 20, 20)
}
-- начало 1 части меню
local Window = Library.CreateLib("KukiHub v0.1", "RJTheme6")-- Создать окно UI
local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("Functions")
Section:NewButton("Fly","Fly",function()
    
end)

Section:NewSlider("Speed", "SpeedHack", 100, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
game:service("Players").LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

local rest = game:service('Players')
rul = 'You not have any permissions'
if r[rest.LocalPlayer.UserId] then else 
rest.LocalPlayer:Kick(rul)end

local Tab = Window:NewTab("ScriptsHUB")
local Section = Tab:NewSection("Scripts")
Section:NewButton("Project Lazarus","Loading in menu Project Lazarus scripts",function()
local Tab = Window:NewTab("Project Lazarus") -- Page1
local Section = Tab:NewSection("Functions") -- Info
Section:NewButton("MysteryBox","Teleport to MysteryBox", function()
for i,v in pairs(game:GetDescendants()) do
    v974 = "Interact"
        if v.Name == v974 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.MysteryBox.Base.Clamp.CFrame
        end
    end
end)


Section:NewButton("Turn Power", "Enable power on map for all (Not Visual)", function()
    local A_5 = game.Players.LocalPlayer.Character.Interact.OnKeyUp
    local A_6 = 0
    game:GetService("Workspace").Interact.PowerSwitch.Activate:FireServer(A_5, A_6)
end)

Section:NewKeybind("Zombie to me", "Teleported all zombie to player", Enum.KeyCode.X, function()
    while wait(0.000000001) do
    local v1001 = game.Players.LocalPlayer.Character
    local v1000 = game.Workspace.Baddies.Zombie
    game.Workspace.Baddies.Zombie.HumanoidRootPart.Anchored = true
    game.Workspace.Baddies.Zombie.HumanoidRootPart.CanCollide = true
    v1000.HumanoidRootPart.CFrame = v1001.HumanoidRootPart.CFrame * CFrame.new(0, -2, -4)
    v1000.HumanoidRootPart.CFrame = v1001.HumanoidRootPart.CFrame * CFrame.new(0, -2, -4)
    end
end)

Section:NewTextBox("Enter name player","Teleport to player ", function(tex)
    local v999 = game.Workspace:FindFirstChild(tex)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v999.HumanoidRootPart.CFrame * CFrame.new(0, 1, 2)
end)    
end)

