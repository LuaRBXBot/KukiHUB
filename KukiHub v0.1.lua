local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaRBXBot/MenuLib/main/Menu.lua", true))()
    colorss = {
    -- Цвет фона у Секций
    SchemeColor = Color3.fromRGB(91, 94, 176),
    -- Цвет фона в правой части UI
    Background = Color3.fromRGB(15,15,15),
    -- Цвет фона в левой части UI
    Header = Color3.fromRGB(15,15,15),
    -- Цвет текста
    TextColor = Color3.fromRGB(255,255,255),
    -- Цвет фона у кнопок
    ElementColor = Color3.fromRGB(20, 20, 20)
    }
-- начало 1 части меню
local Window = Library.CreateLib("KukiHub v0.1", colors)-- Создать окно UI
local Tab = Window:NewTab("ChangeLog")
local Section = Tab:NewSection("Change log:")
Section:NewLabel("15.10.2022: Added AimBot [Assist]")
Section:NewLabel("15.10.2022: Added ESP [Visuals]")
Section:NewLabel("15.10.2022: Added FPS Booster [Misc]")
Section:NewLabel("15.10.2022: Removed Turn Power on Project Lazarus [ScriptHUB]")
Section:NewLabel("15.10.2022: Reworked btools [Misc]")
Section:NewLabel("15.10.2022: Added A bizzary day scripts [ScriptHUB]")
Section:NewLabel("14.10.2022: Added btools [Misc]")
Section:NewLabel("14.10.2022: Added jump hack [Misc]")
Section:NewLabel("14.10.2022: Added Speed Hack [Misc]")
Section:NewLabel("14.10.2022: Added Project Lazarus scripts [ScriptHUB]")
local Tab = Window:NewTab("Visuals")
local Section = Tab:NewSection("Functions")
local ColorBox = Instance.new("StringValue")
ColorBox.Value = "255,48,48"
Section:NewTextBox("Box color","This box color (x - number [ x,x,x ])",function(txt)
    ColorBox.Value = txt
end)
Section:NewButton("ESP","Drawing entity through the walls", function()
while wait(0.5) do
    for i, childrik in ipairs(workspace:GetDescendants()) do
        if childrik:FindFirstChild("Humanoid") then
            if not childrik:FindFirstChild("EspBox") then
                if childrik ~= game.Players.LocalPlayer.Character then
                    local esp = Instance.new("BoxHandleAdornment",childrik)
                    esp.Adornee = childrik
                    esp.ZIndex = 0
                    esp.Size = Vector3.new(4, 4, 4)
                    esp.Transparency = 0.65
                    esp.Color3 = Color3.fromRGB(ColorBox.Value)
                    esp.AlwaysOnTop = true
                    esp.Name = "EspBox"
                end
            end
        end
    end
end
end)
-- Секция
local Tab = Window:NewTab("Assist")
local Section = Tab:NewSection("Enable AimAssist:")
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false
local OnHold = Instance.new("StringValue")
-- CheckBox
Section:NewToggle("AimAssist", "Activate AimAssist", function(state)
    if state then
        _G.AimbotEnabled = true
    else
        _G.AimbotEnabled = false
    end
end)

Section:NewToggle("Visible FOV","(hide/show FOV radius.)",function(state)
    if state then
        _G.CircleVisible = true
    else
        _G.CircleVisible = false
    end
end)

Section:NewSlider("FOV","(for change radius AimAssist.)", 180, 0,function(fov)
    _G.CircleRadius = fov
end)
Section:NewLabel("Aim speed:")
Section:NewSlider("SpeedModify", "(Change speed AimAssist.)", 2, 0, function(s)
_G.Sensitivity = s
end)

Section:NewLabel("Keybind:")
-- KeyBind
Section:NewKeybind("AimAssist","(if you press the button it lock at target.)", Enum.KeyCode.Z, function()
    if _G.AimbotEnabled == true then
        if Holding == false then
            Holding = true
            else
            Holding = false
        end
    end
end)
Section:NewLabel("Hitbox:")
-- DropDown
Section:NewDropdown("Hitbox", "(if you press the button it lock at target.)", {"Head", "Body"}, function(HitBoxs)
if HitBoxs == "Head" then
_G.AimPart = "Head"
elseif HitBoxs == "Body" then
_G.AimPart = "Torso"
end
end)
_G.AimbotEnabled = true
_G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
_G.AimPart = "Head" -- Where the aimbot script would lock at.
_G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.
_G.CircleSides = 64 -- How many sides the FOV circle would have.
_G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
_G.CircleTransparency = 0.7 -- Transparency of the circle.
_G.CircleRadius = 80 -- The radius of the circle / FOV.
_G.CircleFilled = false -- Determines whether or not the circle is filled.
_G.CircleVisible = false -- Determines whether or not the circle is visible.
_G.CircleThickness = 0 -- The thickness of the circle.
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness
local function GetClosestPlayer()
    local MaximumDistance = _G.CircleRadius
    local Target = nil

    for _, v in next, Players:GetPlayers() do
        if v.Name ~= LocalPlayer.Name then
            if _G.TeamCheck == true then
                if v.Team ~= LocalPlayer.Team then
                    if v.Character ~= nil then
                        if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                            if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                if VectorDistance < MaximumDistance then
                                    Target = v
                                end
                            end
                        end
                    end
                end
            else
                if v.Character ~= nil then
                    if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                        if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude                           
                            if VectorDistance < MaximumDistance then
                                Target = v
                            end
                        end
                    end
                end
            end
        end
    end
    return Target
end
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness
    if Holding == true and _G.AimbotEnabled == true then
        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
    end
end)

local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("Functions")
Section:NewSlider("Jump", "Changed Jump Power", 100, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)
Section:NewSlider("Speed", "Changed Walk speed", 100, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
Section:NewButton("FPS BOOSTER","(Speeds up the performance of the game by reducing the quality of the graphics.)",function()
local removedecals = false
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(g:GetDescendants()) do
if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then v.Material = "Plastic";v.Reflectance = 0
elseif v:IsA("Decal") or v:IsA("Texture") and removedecals then v.Transparency = 1
elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Lifetime = NumberRange.new(0)
elseif v:IsA("Explosion") then v.BlastPressure = 1;v.BlastRadius = 1
elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then v.Enabled = false
elseif v:IsA("MeshPart") then v.Material = "Plastic";v.Reflectance = 0;v.TextureID = 10385902758728957 end end
for i, e in pairs(l:GetChildren()) do
if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled = false end end
end)
local player = game.Players.LocalPlayer;
local mouse = player:GetMouse();
local On = Instance.new("StringValue"); 
On.Parent = TextButton;
 On.Value = "Off"; 
 mouse.Button1Up:Connect(function()
    if On.Value == "Off" then
     else 
        if mouse.Target.Locked == true then 
            mouse.Target:Destroy()
        else 
            mouse.Target:Destroy()
        end 
    end 
end)
local r = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaRBXBot/DataBase/main/DataBase.lua", true))() local sf = game:service('Players') f = "You are blocked in this ScriptHUB" if r[rest.LocalPlayer.UserId] then else sf.LocalPlayer:Kick("rul")end
Section:NewButton("Btools","Load btools",function()
    Section:NewKeybind("btools", "(Removes objects from the map that you want to remove.)", Enum.KeyCode.Y, function()
        if On.Value == "Off" then
            On.Value = "On"
            TextButton.Text = "Btools (On)"
        else
            On.Value = "Off"
            TextButton.Text = "Btools (Off)"
        end
    end)
end)
local Tab = Window:NewTab("ScriptsHUB")
local Section = Tab:NewSection("Scripts")
 -- Project Lazarus
    Section:NewButton("Project Lazarus","Loading in menu [Project Lazarus] scripts",function()
        local Tab = Window:NewTab("Project Lazarus")
        local Section = Tab:NewSection("Functions")
        Section:NewButton("MysteryBox","Teleport to MysteryBox", function()
        for i,v in pairs(game:GetDescendants()) do
            v974 = "Interact"
                if v.Name == v974 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.MysteryBox.Base.Clamp.CFrame
                end
            end
        end)        
    Section:NewKeybind("Zombie to me", "Teleported all zombie to player", Enum.KeyCode.X, function()
        while wait(0.01) do
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
 -- A bizzary day
    Section:NewButton("A Bizzare day","Loading in menu [A Bizzare Day] scripts",function()
        local Tab = Window:NewTab("A Bizzare Day")
            local Section = Tab:NewSection("Teleport player to items")
            Section:NewButton("Rokaka Fruit", "Teleport player to item", function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItFolder["Rokakaka Fruit"].Handle.CFrame
            end)
            Section:NewButton("Banknote", "Teleport player to item", function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItFolder["Banknote"].Handle.CFrame
            end)
            Section:NewButton("Arrow", "Teleport player to item", function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItFolder["Arrow"].Handle.CFrame
            end)
            Section:NewButton("Frog", "Teleport player to item", function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItFolder["Frog"].Handle.CFrame
            end)
        end)
