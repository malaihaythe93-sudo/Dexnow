local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local CurrentLevel = game:GetService("Players").LocalPlayer.Data.Level.Value

local Window = Fluent:CreateWindow({
    Title = "RaNi-Freemium 🍌✨",
    SubTitle = "Bản quyền của malaihaythe93-sudo",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "scroll" }),
    Player = Window:AddTab({ Title = "Nhân Vật", Icon = "user" }),
    Combat = Window:AddTab({ Title = "Chiến Đấu", Icon = "crosshair" })
}

_G.Settings = {
    ["Auto Farm Level"] = false,
    ["Bring Mob"] = true,
    ["WalkSpeed"] = 16,
    ["JumpPower"] = 50
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local function doAutoFarm()
    while _G.Settings["Auto Farm Level"] do
        task.wait(0.1)
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(0, 0))
    end
end

Tabs.Main:AddParagraph({
    Title = "THÔNG TIN NGƯỜI CHƠI (UPDATE 2026)",
    Content = "Cấp độ hiện tại: " .. tostring(CurrentLevel) .. ".\nChúc bạn trải nghiệm RaNi-Freemium vui vẻ!"
})

Tabs.Main:AddToggle("AutoFarmToggle", {
    Title = "Auto Farm Level (Auto Click M1)",
    Default = false,
    Callback = function(Value)
        _G.Settings["Auto Farm Level"] = Value
        if Value then
            task.spawn(doAutoFarm)
        end
    end
})

Tabs.Main:AddToggle("BringMobToggle", {
    Title = "Bring Mob (Tự động gom quái)",
    Default = _G.Settings["Bring Mob"],
    Callback = function(Value)
        _G.Settings["Bring Mob"] = Value
    end
})

Tabs.Player:AddSlider("SpeedSlider", {
    Title = "Tốc độ chạy (WalkSpeed)",
    Default = _G.Settings["WalkSpeed"],
    Min = 16,
    Max = 150,
    Rounding = 0,
    Callback = function(Value)
        _G.Settings["WalkSpeed"] = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

Tabs.Player:AddSlider("JumpSlider", {
    Title = "Sức bật nhảy (JumpPower)",
    Default = _G.Settings["JumpPower"],
    Min = 50,
    Max = 250,
    Rounding = 0,
    Callback = function(Value)
        _G.Settings["JumpPower"] = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function(Character)
    local humanoid = Character:WaitForChild("Humanoid")
    task.wait(0.5)
    humanoid.WalkSpeed = _G.Settings["WalkSpeed"]
    humanoid.JumpPower = _G.Settings["JumpPower"]
end)

Tabs.Combat:AddButton({
    Title = "Kích hoạt nhanh Local Script",
    Description = "Chạy file Local.lua từ GitHub cá nhân của bạn",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/malaihaythe93-sudo/Dexnow/refs/heads/main/Local.lua"))()
    end
})

Window:SelectTab(1)
