-- [[ TITANUM HUB: PART 1 - BASE INTERFACE & CLEANER SETUP ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

for _, oldGui in pairs(game.CoreGui:GetChildren()) do
    if oldGui.Name == "TitanumHubBypass" then
        oldGui:Destroy()
    end
end

local Titanum = {
    isSpeed = false, isJump = false, isNoclip = false,
    espPlrName = false, espPlrDist = false, espPlrOutline = false,
    espFruitName = false, espFruitDist = false, espFruitSpawn = false, espFruitDespawn = false,
    speedFactor = 1.2, jumpMultiplier = 2.0, speedStep = 0.1, jumpStep = 0.2,
    hideKey = Enum.KeyCode.Insert, isBinding = false, guiVisible = true, isUnloaded = false,
    speedConn = nil, jumpConn = nil, noclipConn = nil, espConn = nil, fruitConn = nil
}
shared.TitanumConfig = Titanum

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TitanumHubBypass"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn, ScreenGui.IgnoreGuiInset = false, true
Titanum.ScreenGuiObj = ScreenGui

local IntroOverlay = Instance.new("Frame", ScreenGui)
IntroOverlay.Size = UDim2.new(1, 0, 1, 0)
IntroOverlay.BackgroundColor3 = Color3.fromRGB(85, 0, 255)
IntroOverlay.BackgroundTransparency, IntroOverlay.ZIndex = 1, 995

local IntroText3D = Instance.new("TextLabel", IntroOverlay)
IntroText3D.Size, IntroText3D.Position = UDim2.new(1, 0, 0, 80), UDim2.new(0, 4, 0.5, -36)
IntroText3D.BackgroundTransparency, IntroText3D.Font = 1, Enum.Font.SourceSansBold
IntroText3D.Text, IntroText3D.TextColor3, IntroText3D.TextSize = "titanum hub", Color3.fromRGB(25, 0, 75), 65
IntroText3D.TextTransparency, IntroText3D.ZIndex = 1, 996

local IntroTextFront = Instance.new("TextLabel", IntroOverlay)
IntroTextFront.Size, IntroTextFront.Position = UDim2.new(1, 0, 0, 80), UDim2.new(0, 0, 0.5, -40)
IntroTextFront.BackgroundTransparency, IntroTextFront.Font = 1, Enum.Font.SourceSansBold
IntroTextFront.Text, IntroTextFront.TextColor3, IntroTextFront.TextSize = "titanum hub", Color3.fromRGB(255, 255, 255), 65
IntroTextFront.TextTransparency, IntroTextFront.ZIndex = 1, 997

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.Position, MainFrame.Size = UDim2.new(0.5, -190, 0.5, -100), UDim2.new(0, 380, 0, 200)
MainFrame.Active, MainFrame.Draggable, MainFrame.Visible = true, true, false
MainFrame.BackgroundTransparency = 1
Titanum.MainFrameObj = MainFrame

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness, UIStroke.Color, UIStroke.Transparency = 2, Color3.fromRGB(140, 0, 255), 1

local Header = Instance.new("TextLabel", MainFrame)
Header.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
Header.Size, Header.Font = UDim2.new(1, 0, 0, 30), Enum.Font.SourceSansBold
Header.Text, Header.TextColor3, Header.TextSize = "   TITANUM HUB | BYPASS", Color3.fromRGB(140, 0, 255), 14
Header.TextXAlignment, Header.BackgroundTransparency, Header.TextTransparency = Enum.TextXAlignment.Left, 1, 1

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Sidebar.Position, Sidebar.Size, Sidebar.BackgroundTransparency = UDim2.new(0, 0, 0, 30), UDim2.new(0, 100, 1, -30), 1

local MainPage = Instance.new("ScrollingFrame", MainFrame)
MainPage.Name = "MainPage"
MainPage.BackgroundTransparency, MainPage.Position, MainPage.Size = 1, UDim2.new(0, 100, 0, 30), UDim2.new(1, -100, 1, -30)
MainPage.CanvasSize, MainPage.ScrollBarThickness, MainPage.Visible = UDim2.new(0, 0, 0, 250), 0, true

local EspPage = Instance.new("ScrollingFrame", MainFrame)
EspPage.Name = "EspPage"
EspPage.BackgroundTransparency, EspPage.Position, EspPage.Size = 1, UDim2.new(0, 100, 0, 30), UDim2.new(1, -100, 1, -30)
EspPage.CanvasSize, EspPage.ScrollBarThickness, EspPage.Visible = UDim2.new(0, 0, 0, 300), 0, false

local SettingsPage = Instance.new("Frame", MainFrame)
SettingsPage.Name = "SettingsPage"
SettingsPage.BackgroundTransparency, SettingsPage.Position, SettingsPage.Size = 1, UDim2.new(0, 100, 0, 30), UDim2.new(1, -100, 1, -30)
SettingsPage.Visible = false

local MainTabBtn = Instance.new("TextButton", Sidebar)
MainTabBtn.Size, MainTabBtn.Position = UDim2.new(1, -10, 0, 25), UDim2.new(0, 5, 0, 10)
MainTabBtn.BackgroundColor3, MainTabBtn.Font = Color3.fromRGB(140, 0, 255), Enum.Font.SourceSansBold
MainTabBtn.Text, MainTabBtn.TextColor3, MainTabBtn.TextSize = "Main", Color3.fromRGB(255, 255, 255), 12
MainTabBtn.BackgroundTransparency, MainTabBtn.TextTransparency = 1, 1

local EspTabBtn = Instance.new("TextButton", Sidebar)
EspTabBtn.Size, EspTabBtn.Position = UDim2.new(1, -10, 0, 25), UDim2.new(0, 5, 0, 40)
EspTabBtn.BackgroundColor3, EspTabBtn.Font = Color3.fromRGB(20, 20, 28), Enum.Font.SourceSansBold
EspTabBtn.Text, EspTabBtn.TextColor3, EspTabBtn.TextSize = "ESP", Color3.fromRGB(150, 150, 160), 12
EspTabBtn.BackgroundTransparency, EspTabBtn.TextTransparency = 1, 1

local SettingsTabBtn = Instance.new("TextButton", Sidebar)
SettingsTabBtn.Size, SettingsTabBtn.Position = UDim2.new(1, -10, 0, 25), UDim2.new(0, 5, 0, 70)
SettingsTabBtn.BackgroundColor3, SettingsTabBtn.Font = Color3.fromRGB(20, 20, 28), Enum.Font.SourceSansBold
SettingsTabBtn.Text, SettingsTabBtn.TextColor3, SettingsTabBtn.TextSize = "Settings", Color3.fromRGB(150, 150, 160), 12
SettingsTabBtn.BackgroundTransparency, SettingsTabBtn.TextTransparency = 1, 1

local function fadeGUI(targetTransparency, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(MainFrame, tweenInfo, {BackgroundTransparency = targetTransparency}):Play()
    TweenService:Create(UIStroke, tweenInfo, {Transparency = targetTransparency}):Play()
    TweenService:Create(Header, tweenInfo, {BackgroundTransparency = targetTransparency, TextTransparency = targetTransparency}):Play()
    TweenService:Create(Sidebar, tweenInfo, {BackgroundTransparency = targetTransparency}):Play()
    TweenService:Create(MainTabBtn, tweenInfo, {BackgroundTransparency = (targetTransparency == 1 and 1 or (MainPage.Visible and 0 or 1)), TextTransparency = targetTransparency}):Play()
    TweenService:Create(EspTabBtn, tweenInfo, {BackgroundTransparency = (targetTransparency == 1 and 1 or (EspPage.Visible and 0 or 1)), TextTransparency = targetTransparency}):Play()
    TweenService:Create(SettingsTabBtn, tweenInfo, {BackgroundTransparency = (targetTransparency == 1 and 1 or (SettingsPage.Visible and 0 or 1)), TextTransparency = targetTransparency}):Play()
    local pages = {MainPage, EspPage, SettingsPage}
    for _, p in pairs(pages) do
        for _, child in pairs(p:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("Frame") then
                local isBtn = child:IsA("TextButton")
                TweenService:Create(child, tweenInfo, {BackgroundTransparency = (isBtn and targetTransparency or child.BackgroundTransparency), TextTransparency = (isBtn and targetTransparency or nil)}):Play()
                local stroke = child:FindFirstChildOfClass("UIStroke")
                if stroke then TweenService:Create(stroke, tweenInfo, {Transparency = targetTransparency}):Play() end
            end
        end
    end
end
Titanum.fadeGUIFunc = fadeGUI

local function switchTab(activePage, activeBtn)
    if Titanum.isUnloaded then return end
    MainPage.Visible, EspPage.Visible, SettingsPage.Visible = false, false, false
    MainTabBtn.BackgroundColor3, EspTabBtn.BackgroundColor3, SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28), Color3.fromRGB(20, 20, 28), Color3.fromRGB(20, 20, 28)
    MainTabBtn.BackgroundTransparency, EspTabBtn.BackgroundTransparency, SettingsTabBtn.BackgroundTransparency = 1, 1, 1
    MainTabBtn.TextColor3, EspTabBtn.TextColor3, SettingsTabBtn.TextColor3 = Color3.fromRGB(150, 150, 160), Color3.fromRGB(150, 150, 160), Color3.fromRGB(150, 150, 160)
    activePage.Visible = true
    activeBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
    activeBtn.BackgroundTransparency = 0
    activeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end
MainTabBtn.MouseButton1Click:Connect(function() switchTab(MainPage, MainTabBtn) end)
EspTabBtn.MouseButton1Click:Connect(function() switchTab(EspPage, EspTabBtn) end)
SettingsTabBtn.MouseButton1Click:Connect(function() switchTab(SettingsPage, SettingsTabBtn) end)
-- [[ TITANUM HUB: PART 2 - MAIN TAB DROPDOWNS & SHORTS GUIDE ]] --
local Titanum = shared.TitanumConfig
local MainPage = Titanum.MainFrameObj.MainPage
local SettingsPage = Titanum.MainFrameObj.SettingsPage
local TweenService = game:GetService("TweenService")
local tInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- ==================== ВЫПАДАЮЩИЙ СПИСОК SPEEDHACK ====================
local isSpeedOpen = false
local SpeedDropdownFrame = Instance.new("Frame", MainPage)
SpeedDropdownFrame.Size, SpeedDropdownFrame.Position = UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 10)
SpeedDropdownFrame.BackgroundColor3, SpeedDropdownFrame.ClipsDescendants = Color3.fromRGB(20, 20, 26), true
local SDStroke = Instance.new("UIStroke", SpeedDropdownFrame) SDStroke.Color = Color3.fromRGB(45, 45, 55)
local UICornerS = Instance.new("UICorner", SpeedDropdownFrame) UICornerS.CornerRadius = UDim.new(0, 4)

local SpeedToggleBtn = Instance.new("TextButton", SpeedDropdownFrame)
SpeedToggleBtn.Size, SpeedToggleBtn.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0)
SpeedToggleBtn.BackgroundTransparency, SpeedToggleBtn.Font = 1, Enum.Font.SourceSansBold
SpeedToggleBtn.Text, SpeedToggleBtn.TextColor3, SpeedToggleBtn.TextSize = "  speedhack  ▼", Color3.fromRGB(255, 255, 255), 13

local SpeedActionBtn = Instance.new("TextButton", SpeedDropdownFrame)
SpeedActionBtn.Size, SpeedActionBtn.Position = UDim2.new(1, -16, 0, 24), UDim2.new(0, 8, 0, 38)
SpeedActionBtn.BackgroundColor3, SpeedActionBtn.Text = Color3.fromRGB(28, 28, 38), "Speedhack [G]: OFF (1.2)"
SpeedActionBtn.TextColor3, SpeedActionBtn.TextSize = Color3.fromRGB(240, 240, 240), 12
Titanum.SpeedBtnObj = SpeedActionBtn

local SpeedGuideLabel = Instance.new("TextLabel", SpeedDropdownFrame)
SpeedGuideLabel.Size, SpeedGuideLabel.Position = UDim2.new(1, -16, 0, 20), UDim2.new(0, 8, 0, 68)
SpeedGuideLabel.BackgroundTransparency, SpeedGuideLabel.Font = 1, Enum.Font.SourceSansSemibold
SpeedGuideLabel.Text, SpeedGuideLabel.TextColor3, SpeedGuideLabel.TextSize = "[H] - increase speed  /  [Y] - decrease speed", Color3.fromRGB(140, 140, 150), 11

-- ==================== ВЫПАДАЮЩИЙ СПИСОК SUPER JUMP ====================
local isJumpOpen = false
local JumpDropdownFrame = Instance.new("Frame", MainPage)
JumpDropdownFrame.Size, JumpDropdownFrame.Position = UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 50)
JumpDropdownFrame.BackgroundColor3, JumpDropdownFrame.ClipsDescendants = Color3.fromRGB(20, 20, 26), true
local JDStroke = Instance.new("UIStroke", JumpDropdownFrame) JDStroke.Color = Color3.fromRGB(45, 45, 55)
local UICornerJ = Instance.new("UICorner", JumpDropdownFrame) UICornerJ.CornerRadius = UDim.new(0, 4)

local JumpToggleBtn = Instance.new("TextButton", JumpDropdownFrame)
JumpToggleBtn.Size, JumpToggleBtn.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0)
JumpToggleBtn.BackgroundTransparency, JumpToggleBtn.Font = 1, Enum.Font.SourceSansBold
JumpToggleBtn.Text, JumpToggleBtn.TextColor3, JumpToggleBtn.TextSize = "  super jump  ▼", Color3.fromRGB(255, 255, 255), 13

local JumpActionBtn = Instance.new("TextButton", JumpDropdownFrame)
JumpActionBtn.Size, JumpActionBtn.Position = UDim2.new(1, -16, 0, 24), UDim2.new(0, 8, 0, 38)
JumpActionBtn.BackgroundColor3, JumpActionBtn.Text = Color3.fromRGB(28, 28, 38), "Super Jump [U]: OFF (2.0)"
JumpActionBtn.TextColor3, JumpActionBtn.TextSize = Color3.fromRGB(240, 240, 240), 12
Titanum.JumpBtnObj = JumpActionBtn

local JumpGuideLabel = Instance.new("TextLabel", JumpDropdownFrame)
JumpGuideLabel.Size, JumpGuideLabel.Position = UDim2.new(1, -16, 0, 20), UDim2.new(0, 8, 0, 68)
JumpGuideLabel.BackgroundTransparency, JumpGuideLabel.Font = 1, Enum.Font.SourceSansSemibold
JumpGuideLabel.Text, JumpGuideLabel.TextColor3, JumpGuideLabel.TextSize = "[L] - increase jump  /  [P] - decrease jump", Color3.fromRGB(140, 140, 150), 11

local NoclipBtn = Instance.new("TextButton", MainPage)
NoclipBtn.Size, NoclipBtn.Position = UDim2.new(1, -20, 0, 32), UDim2.new(0, 10, 0, 90)
NoclipBtn.BackgroundColor3, NoclipBtn.Font = Color3.fromRGB(20, 20, 30), Enum.Font.SourceSansSemibold
NoclipBtn.Text, NoclipBtn.TextColor3, NoclipBtn.TextSize = "Noclip [N]: OFF", Color3.fromRGB(255, 255, 255), 13
local NoclipStroke = Instance.new("UIStroke", NoclipBtn) NoclipStroke.Color = Color3.fromRGB(60, 60, 80)
Titanum.NoclipBtnObj = NoclipBtn

local function collapseMainLayout()
    if isSpeedOpen then
        TweenService:Create(SpeedDropdownFrame, tInfo, {Size = UDim2.new(1, -20, 0, 95)}):Play()
        TweenService:Create(JumpDropdownFrame, tInfo, {Position = UDim2.new(0, 10, 0, 115)}):Play()
    else
        TweenService:Create(SpeedDropdownFrame, tInfo, {Size = UDim2.new(1, -20, 0, 30)}):Play()
        TweenService:Create(JumpDropdownFrame, tInfo, {Position = UDim2.new(0, 10, 0, 50)}):Play()
    end
    if isJumpOpen then
        local targetY = isSpeedOpen and 115 or 50
        TweenService:Create(JumpDropdownFrame, tInfo, {Position = UDim2.new(0, 10, 0, targetY), Size = UDim2.new(1, -20, 0, 95)}):Play()
        local targetNoclipY = targetY + 105
        TweenService:Create(NoclipBtn, tInfo, {Position = UDim2.new(0, 10, 0, targetNoclipY)}):Play()
    else
        local targetY = isSpeedOpen and 115 or 50
        TweenService:Create(JumpDropdownFrame, tInfo, {Position = UDim2.new(0, 10, 0, targetY), Size = UDim2.new(1, -20, 0, 30)}):Play()
        local targetNoclipY = targetY + 40
        TweenService:Create(NoclipBtn, tInfo, {Position = UDim2.new(0, 10, 0, targetNoclipY)}):Play()
    end
end

SpeedToggleBtn.MouseButton1Click:Connect(function() isSpeedOpen = not isSpeedOpen collapseMainLayout() end)
JumpToggleBtn.MouseButton1Click:Connect(function() isJumpOpen = not isJumpOpen collapseMainLayout() end)

local BindBtn = Instance.new("TextButton", SettingsPage)
BindBtn.Size, BindBtn.Position = UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 15)
BindBtn.BackgroundColor3, BindBtn.Font = Color3.fromRGB(20, 20, 30), Enum.Font.SourceSansSemibold
BindBtn.Text, BindBtn.TextColor3, BindBtn.TextSize = "Hide GUI [Insert]", Color3.fromRGB(255, 255, 255), 13
local BindStroke = Instance.new("UIStroke", BindBtn) BindStroke.Color = Color3.fromRGB(140, 0, 255)
Titanum.BindBtnObj = BindBtn Titanum.BindStrokeObj = BindStroke

local UnloadBtn = Instance.new("TextButton", SettingsPage)
UnloadBtn.Size, UnloadBtn.Position = UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 65)
UnloadBtn.BackgroundColor3, UnloadBtn.Font = Color3.fromRGB(45, 15, 15), Enum.Font.SourceSansBold
UnloadBtn.Text, UnloadBtn.TextColor3, UnloadBtn.TextSize = "Unload Hub Script", Color3.fromRGB(255, 100, 100), 13
local UnloadStroke = Instance.new("UIStroke", UnloadBtn) UnloadStroke.Color = Color3.fromRGB(150, 0, 0)
Titanum.UnloadBtnObj = UnloadBtn
-- [[ TITANUM HUB: PART 3 - ESP PAGE WITH DROPDOWNS & LVL TOGGLE ]] --
local Titanum = shared.TitanumConfig
local EspPage = Titanum.MainFrameObj.EspPage
local TweenService = game:GetService("TweenService")
local tInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local isPlrOpen = false
local PlrDropdownFrame = Instance.new("Frame", EspPage)
PlrDropdownFrame.Size, PlrDropdownFrame.Position = UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 10)
PlrDropdownFrame.BackgroundColor3, PlrDropdownFrame.ClipsDescendants = Color3.fromRGB(20, 20, 26), true
local PDStroke = Instance.new("UIStroke", PlrDropdownFrame) PDStroke.Color = Color3.fromRGB(45, 45, 55)
local UICornerP = Instance.new("UICorner", PlrDropdownFrame) UICornerP.CornerRadius = UDim.new(0, 4)
Titanum.PlrDropdownFrameObj = PlrDropdownFrame

local PlrToggleBtn = Instance.new("TextButton", PlrDropdownFrame)
PlrToggleBtn.Size, PlrToggleBtn.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0)
PlrToggleBtn.BackgroundTransparency, PlrToggleBtn.Font = 1, Enum.Font.SourceSansBold
PlrToggleBtn.Text = "  esp player  ▼"
PlrToggleBtn.TextColor3, PlrToggleBtn.TextSize = Color3.fromRGB(255, 255, 255), 13

local PlrNameBtn = Instance.new("TextButton", PlrDropdownFrame)
PlrNameBtn.Size, PlrNameBtn.Position = UDim2.new(1, -16, 0, 22), UDim2.new(0, 8, 0, 35)
PlrNameBtn.BackgroundColor3, PlrNameBtn.Text = Color3.fromRGB(28, 28, 38), "esp name: OFF"
PlrNameBtn.TextColor3, PlrNameBtn.TextSize = Color3.fromRGB(240, 240, 240), 12

local PlrDistBtn = Instance.new("TextButton", PlrDropdownFrame)
PlrDistBtn.Size, PlrDistBtn.Position = UDim2.new(1, -16, 0, 22), UDim2.new(0, 8, 0, 62)
PlrDistBtn.BackgroundColor3, PlrDistBtn.Text = Color3.fromRGB(28, 28, 38), "esp distance: OFF"
PlrDistBtn.TextColor3, PlrDistBtn.TextSize = Color3.fromRGB(240, 240, 240), 12

local PlrOutlineBtn = Instance.new("TextButton", PlrDropdownFrame)
PlrOutlineBtn.Size, PlrOutlineBtn.Position = UDim2.new(1, -16, 0, 22), UDim2.new(0, 8, 0, 89)
PlrOutlineBtn.BackgroundColor3, PlrOutlineBtn.Text = Color3.fromRGB(28, 28, 38), "outline: OFF"
PlrOutlineBtn.TextColor3, PlrOutlineBtn.TextSize = Color3.fromRGB(240, 240, 240), 12

local PlrLvlBtn = Instance.new("TextButton", PlrDropdownFrame)
PlrLvlBtn.Size, PlrLvlBtn.Position = UDim2.new(1, -16, 0, 22), UDim2.new(0, 8, 0, 116)
PlrLvlBtn.BackgroundColor3, PlrLvlBtn.Text = Color3.fromRGB(28, 28, 38), "esp level: OFF"
PlrLvlBtn.TextColor3, PlrLvlBtn.TextSize = Color3.fromRGB(240, 240, 240), 12

local isFruitOpen = false
local FruitDropdownFrame = Instance.new("Frame", EspPage)
FruitDropdownFrame.Size, FruitDropdownFrame.Position = UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 50)
FruitDropdownFrame.BackgroundColor3, FruitDropdownFrame.ClipsDescendants = Color3.fromRGB(20, 20, 26), true
local FDStroke = Instance.new("UIStroke", FruitDropdownFrame) FDStroke.Color = Color3.fromRGB(45, 45, 55)
local UICornerF = Instance.new("UICorner", FruitDropdownFrame) UICornerF.CornerRadius = UDim.new(0, 4)

local FruitToggleBtn = Instance.new("TextButton", FruitDropdownFrame)
FruitToggleBtn.Size, FruitToggleBtn.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0)
FruitToggleBtn.BackgroundTransparency, FruitToggleBtn.Font = 1, Enum.Font.SourceSansBold
FruitToggleBtn.Text = "  esp fruit  ▼"
FruitToggleBtn.TextColor3, FruitToggleBtn.TextSize = Color3.fromRGB(255, 255, 255), 13

local FruitNameBtn = Instance.new("TextButton", FruitDropdownFrame)
FruitNameBtn.Size, FruitNameBtn.Position = UDim2.new(1, -16, 0, 24), UDim2.new(0, 8, 0, 38)
FruitNameBtn.BackgroundColor3, FruitNameBtn.Text = Color3.fromRGB(28, 28, 38), "esp name: OFF"
FruitNameBtn.TextColor3, FruitNameBtn.TextSize = Color3.fromRGB(240, 240, 240), 12

local FruitDistBtn = Instance.new("TextButton", FruitDropdownFrame)
FruitDistBtn.Size, FruitDistBtn.Position = UDim2.new(1, -16, 0, 24), UDim2.new(0, 8, 0, 68)
FruitDistBtn.BackgroundColor3, FruitDistBtn.Text = Color3.fromRGB(28, 28, 38), "esp distance: OFF"
FruitDistBtn.TextColor3, FruitDistBtn.TextSize = Color3.fromRGB(240, 240, 240), 12

local FruitNotifBtn = Instance.new("TextButton", FruitDropdownFrame)
FruitNotifBtn.Size, FruitNotifBtn.Position = UDim2.new(1, -16, 0, 24), UDim2.new(0, 8, 0, 98)
FruitNotifBtn.BackgroundColor3, FruitNotifBtn.Text = Color3.fromRGB(28, 28, 38), "spawn notification: OFF"
FruitNotifBtn.TextColor3, FruitNotifBtn.TextSize = Color3.fromRGB(240, 240, 240), 12

local FruitDespawnBtn = Instance.new("TextButton", FruitDropdownFrame)
FruitDespawnBtn.Size, FruitDespawnBtn.Position = UDim2.new(1, -16, 0, 24), UDim2.new(0, 8, 0, 128)
FruitDespawnBtn.BackgroundColor3, FruitDespawnBtn.Text = Color3.fromRGB(28, 28, 38), "despawn notification: OFF"
FruitDespawnBtn.TextColor3, FruitDespawnBtn.TextSize = Color3.fromRGB(240, 240, 240), 12

local isPlrOpenLocal = false
local function collapseEspLayout()
    local pFrame = Titanum.PlrDropdownFrameObj
    if isPlrOpenLocal then
        TweenService:Create(pFrame, tInfo, {Size = UDim2.new(1, -20, 0, 146)}):Play()
        TweenService:Create(FruitDropdownFrame, tInfo, {Position = UDim2.new(0, 10, 0, 166)}):Play()
    else
        TweenService:Create(pFrame, tInfo, {Size = UDim2.new(1, -20, 0, 30)}):Play()
        TweenService:Create(FruitDropdownFrame, tInfo, {Position = UDim2.new(0, 10, 0, 50)}):Play()
    end
    if isFruitOpen then
        local targetY = isPlrOpenLocal and 166 or 50
        TweenService:Create(FruitDropdownFrame, tInfo, {Position = UDim2.new(0, 10, 0, targetY), Size = UDim2.new(1, -20, 0, 162)}):Play()
    else
        local targetY = isPlrOpenLocal and 166 or 50
        TweenService:Create(FruitDropdownFrame, tInfo, {Position = UDim2.new(0, 10, 0, targetY), Size = UDim2.new(1, -20, 0, 30)}):Play()
    end
end

PlrToggleBtn.MouseButton1Click:Connect(function() isPlrOpenLocal = not isPlrOpenLocal collapseEspLayout() end)
FruitToggleBtn.MouseButton1Click:Connect(function() isFruitOpen = not isFruitOpen collapseEspLayout() end)

PlrNameBtn.MouseButton1Click:Connect(function() Titanum.espPlrName = not Titanum.espPlrName if Titanum.espPlrName then PlrNameBtn.Text = "esp name: ON" else PlrNameBtn.Text = "esp name: OFF" end end)
PlrDistBtn.MouseButton1Click:Connect(function() Titanum.espPlrDist = not Titanum.espPlrDist if Titanum.espPlrDist then PlrDistBtn.Text = "esp distance: ON" else PlrDistBtn.Text = "esp distance: OFF" end end)
PlrOutlineBtn.MouseButton1Click:Connect(function() Titanum.espPlrOutline = not Titanum.espPlrOutline if Titanum.espPlrOutline then PlrOutlineBtn.Text = "outline: ON" else PlrOutlineBtn.Text = "outline: OFF" end end)
PlrLvlBtn.MouseButton1Click:Connect(function() Titanum.espPlrLvl = not Titanum.espPlrLvl if Titanum.espPlrLvl then PlrLvlBtn.Text = "esp level: ON" else PlrLvlBtn.Text = "esp level: OFF" end end)

FruitNameBtn.MouseButton1Click:Connect(function() Titanum.espFruitName = not Titanum.espFruitName if Titanum.espFruitName then FruitNameBtn.Text = "esp name: ON" else FruitNameBtn.Text = "esp name: OFF" end end)
FruitDistBtn.MouseButton1Click:Connect(function() Titanum.espFruitDist = not Titanum.espFruitDist if Titanum.espFruitDist then FruitDistBtn.Text = "esp distance: ON" else FruitDistBtn.Text = "esp distance: OFF" end end)

FruitNotifBtn.MouseButton1Click:Connect(function() 
    Titanum.espFruitSpawn = not Titanum.espFruitSpawn 
    if Titanum.espFruitSpawn then FruitNotifBtn.Text = "spawn notification: ON" else FruitNotifBtn.Text = "spawn notification: OFF" end 
end)

FruitDespawnBtn.MouseButton1Click:Connect(function()
    Titanum.espFruitDespawn = not Titanum.espFruitDespawn
    if Titanum.espFruitDespawn then FruitDespawnBtn.Text = "despawn notification: ON" else FruitDespawnBtn.Text = "despawn notification: OFF" end
end)
Titanum.PlrToggleBtnObj = PlrToggleBtn
-- [[ TITANUM HUB: PART 4.1 - PHYSIC ENGINE & KEYBINDS CORES ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local Titanum = shared.TitanumConfig

local function sendNotification(title, text)
    pcall(function() StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = 1.5}) end)
end

local function updateSpeedUI()
    if Titanum.isUnloaded or not Titanum.SpeedBtnObj then return end
    local textSpeed = tostring(math.round(Titanum.speedFactor * 10) / 10)
    if Titanum.isSpeed then Titanum.SpeedBtnObj.Text = "Speedhack [G]: ON (" .. textSpeed .. ")" else Titanum.SpeedBtnObj.Text = "Speedhack [G]: OFF (" .. textSpeed .. ")" end
end

local function updateJumpUI()
    if Titanum.isUnloaded or not Titanum.JumpBtnObj then return end
    local textJump = tostring(math.round(Titanum.jumpMultiplier * 10) / 10)
    if Titanum.isJump then Titanum.JumpBtnObj.Text = "Super Jump [U]: ON (" .. textJump .. ")" else Titanum.JumpBtnObj.Text = "Super Jump [U]: OFF (" .. textJump .. ")" end
end

Titanum.disableSpeedFunc = function()
    Titanum.isSpeed = false
    if Titanum.speedConn then Titanum.speedConn:Disconnect() Titanum.speedConn = nil end
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid.WalkSpeed = 16 end
    updateSpeedUI()
end

Titanum.enableSpeedFunc = function()
    Titanum.disableSpeedFunc()
    Titanum.isSpeed = true
    Titanum.speedConn = RunService.RenderStepped:Connect(function()
        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid or not Titanum.isSpeed then return end
        local moveDirection = humanoid.MoveDirection
        if moveDirection.Magnitude > 0 then
            hrp.Velocity = Vector3.new(moveDirection.X * 35, hrp.Velocity.Y, moveDirection.Z * 35)
            hrp.CFrame = hrp.CFrame + (moveDirection * Titanum.speedFactor)
        else
            hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
        end
        hrp.RotVelocity = Vector3.new(0, hrp.RotVelocity.Y, 0)
    end)
    updateSpeedUI()
end

Titanum.disableJumpFunc = function()
    Titanum.isJump = false
    if Titanum.jumpConn then Titanum.jumpConn:Disconnect() Titanum.jumpConn = nil end
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid.UseJumpPower, humanoid.JumpPower = true, 50 end
    updateJumpUI()
end

Titanum.enableJumpFunc = function()
    Titanum.disableJumpFunc()
    Titanum.isJump = true
    Titanum.jumpConn = RunService.RenderStepped:Connect(function()
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid and Titanum.isJump then humanoid.UseJumpPower, humanoid.JumpPower = true, 50 * Titanum.jumpMultiplier end
    end)
    updateJumpUI()
end

Titanum.disableNoclipFunc = function()
    Titanum.isNoclip = false
    if Titanum.noclipConn then Titanum.noclipConn:Disconnect() Titanum.noclipConn = nil end
    if Titanum.NoclipBtnObj then Titanum.NoclipBtnObj.Text = "Noclip [N]: OFF" end
end

Titanum.enableNoclipFunc = function()
    Titanum.disableNoclipFunc()
    Titanum.isNoclip = true
    Titanum.noclipConn = RunService.Stepped:Connect(function()
        local character = player.Character
        if character and Titanum.isNoclip then
            for _, part in pairs(character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
        end
    end)
    if Titanum.NoclipBtnObj then Titanum.NoclipBtnObj.Text = "Noclip [N]: ON" end
end

local inputConnection
inputConnection = UIS.InputBegan:Connect(function(input, gameProcessed)
    if Titanum.isUnloaded then inputConnection:Disconnect() return end
    if Titanum.isBinding then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            Titanum.hideKey, Titanum.isBinding = input.KeyCode, false
            Titanum.BindBtnObj.Text, Titanum.BindStrokeObj.Color = "Hide GUI [" .. Titanum.hideKey.Name .. "]", Color3.fromRGB(140, 0, 255)
        end
        return
    end
    
    local pressedKey = input.KeyCode
    if pressedKey == Titanum.hideKey then
        Titanum.guiVisible = not Titanum.guiVisible
        if Titanum.guiVisible then 
            Titanum.MainFrameObj.Visible = true 
            Titanum.fadeGUIFunc(0, 0.3)
        else 
            Titanum.fadeGUIFunc(1, 0.3) 
            task.spawn(function() task.wait(0.3) if not Titanum.guiVisible then Titanum.MainFrameObj.Visible = false end end) 
        end
        return
    end

    if gameProcessed then return end
    
    if pressedKey == Enum.KeyCode.G then
        if Titanum.isSpeed then Titanum.disableSpeedFunc() sendNotification("titanum hub", "Speedhack: DISABLED") else Titanum.enableSpeedFunc() sendNotification("titanum hub", "Speedhack: ENABLED") end
        return
    end
    if pressedKey == Enum.KeyCode.H then
        Titanum.speedFactor = math.clamp(Titanum.speedFactor + Titanum.speedStep, 0.1, 5.0) updateSpeedUI()
        sendNotification("titanum hub", "Speed factor increased: " .. tostring(math.round(Titanum.speedFactor * 10) / 10))
        return
    end
    if pressedKey == Enum.KeyCode.Y then
        Titanum.speedFactor = math.clamp(Titanum.speedFactor - Titanum.speedStep, 0.1, 5.0) updateSpeedUI()
        sendNotification("titanum hub", "Speed factor decreased: " .. tostring(math.round(Titanum.speedFactor * 10) / 10))
        return
    end
    if pressedKey == Enum.KeyCode.U then
        if Titanum.isJump then Titanum.disableJumpFunc() sendNotification("titanum hub", "Super Jump: DISABLED") else Titanum.enableJumpFunc() sendNotification("titanum hub", "Super Jump: ENABLED") end
        return
    end
    if pressedKey == Enum.KeyCode.L then
        Titanum.jumpMultiplier = math.clamp(Titanum.jumpMultiplier + Titanum.jumpStep, 1.0, 10.0) updateJumpUI()
        sendNotification("titanum hub", "Jump height increased: " .. tostring(math.round(Titanum.jumpMultiplier * 10) / 10))
        return
    end
    if pressedKey == Enum.KeyCode.P then
        Titanum.jumpMultiplier = math.clamp(Titanum.jumpMultiplier - Titanum.jumpStep, 1.0, 10.0) updateJumpUI()
        sendNotification("titanum hub", "Jump height decreased: " .. tostring(math.round(Titanum.jumpMultiplier * 10) / 10))
        return
    end
    if pressedKey == Enum.KeyCode.N then
        if Titanum.isNoclip then Titanum.disableNoclipFunc() sendNotification("titanum hub", "Noclip: DISABLED") else Titanum.enableNoclipFunc() sendNotification("titanum hub", "Noclip: ENABLED") end
        return
    end
end)
-- [[ TITANUM HUB: PART 4.2 - ESP RENDERING & TOTAL CLEAN UNLOAD ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local Titanum = shared.TitanumConfig

Titanum.espConn = RunService.RenderStepped:Connect(function()
    if Titanum.isUnloaded then return end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local head = v.Character:FindFirstChild("Head")
            local highlight = v.Character:FindFirstChild("TitanumHighlight")
            if Titanum.espPlrOutline then
                if not highlight then
                    highlight = Instance.new("Highlight", v.Character)
                    highlight.Name, highlight.FillColor, highlight.FillTransparency = "TitanumHighlight", Color3.fromRGB(140, 0, 255), 0.6
                    highlight.OutlineColor, highlight.OutlineTransparency = Color3.fromRGB(255, 255, 255), 0
                end
            else
                if highlight then highlight:Destroy() end
            end
            local billboard = head and head:FindFirstChild("TitanumESP")
            if head and (Titanum.espPlrName or Titanum.espPlrDist or Titanum.espPlrLvl) then
                if not billboard then
                    billboard = Instance.new("BillboardGui", head)
                    billboard.Name, billboard.AlwaysOnTop, billboard.Size = "TitanumESP", true, UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                    local textLabel = Instance.new("TextLabel", billboard)
                    textLabel.Size, textLabel.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
                    textLabel.TextColor3, textLabel.Font, textLabel.TextSize = Color3.fromRGB(255, 255, 255), Enum.Font.SourceSansBold, 14
                end
                
                local lvlVal = v:FindFirstChild("DataFolder") and v.DataFolder:FindFirstChild("Level") and v.DataFolder.Level.Value or v:FindFirstChild("leaderstats") and v.leaderstats:FindFirstChild("Level") and v.leaderstats.Level.Value or "???"
                local dist = math.round((v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                local textStr = ""
                if Titanum.espPlrName then textStr = textStr .. v.Name .. " " end
                if Titanum.espPlrLvl then textStr = textStr .. "[Lvl " .. tostring(lvlVal) ..] " end
                if Titanum.espPlrDist then textStr = textStr .. "[" .. tostring(dist) .. "m]" end
                billboard.TextLabel.Text = textStr
            else
                if billboard then billboard:Destroy() end
            end
        end
    end

    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Tool") and (obj.Name:find("Fruit") or obj.Name:find("Fruit ")) and obj:FindFirstChild("Handle") then
            local handle = obj.Handle
            local billboard = handle:FindFirstChild("FruitESP")
            if Titanum.espFruitName or Titanum.espFruitDist then
                if not billboard then
                    billboard = Instance.new("BillboardGui", handle)
                    billboard.Name, billboard.AlwaysOnTop, billboard.Size = "FruitESP", true, UDim2.new(0, 180, 0, 40)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    local textLabel = Instance.new("TextLabel", billboard)
                    textLabel.Size, textLabel.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
                    textLabel.TextColor3, textLabel.Font, textLabel.TextSize = Color3.fromRGB(0, 255, 255), Enum.Font.SourceSansBold, 13
                end
                local dist = math.round((handle.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                local textStr = ""
                if Titanum.espFruitName then textStr = textStr .. obj.Name .. " " end
                if Titanum.espFruitDist then textStr = textStr .. "[" .. tostring(dist) .. "m]" end
                billboard.TextLabel.Text = textStr
            else
                if billboard then billboard:Destroy() end
            end
        end
    end
end)

Titanum.fruitConn = workspace.ChildAdded:Connect(function(child)
    if child:IsA("Tool") and (child.Name:find("Fruit") or child.Name:find("Fruit ")) then
        task.wait(0.1)
        if Titanum.espFruitSpawn then
            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "🍇 TITANUM SPAWNER",
                    Text = "A new Devil Fruit has spawned: " .. child.Name .. "!",
                    Duration = 4.0
                })
            end)
        end
        local disappearConn
        disappearConn = child.AncestryChanged:Connect(function(_, parent)
            if not parent or parent:IsA("Player") or parent.Name == "Backpack" or parent:IsA("Model") then
                disappearConn:Disconnect()
                if Titanum.espFruitDespawn then
                    pcall(function()
                        StarterGui:SetCore("SendNotification", {
                            Title = "❌ TITANUM DESPAWN",
                            Text = "The Fruit " .. child.Name .. " has been picked up or despawned!",
                            Duration = 3.0
                        })
                    end)
                end
            end
        end)
    end
end)

local function masterUnload()
    Titanum.isUnloaded = true
    Titanum.disableSpeedFunc() Titanum.disableJumpFunc() Titanum.disableNoclipFunc()
    if Titanum.espConn then Titanum.espConn:Disconnect() end
    if Titanum.fruitConn then Titanum.fruitConn:Disconnect() end
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character then
            local hl = v.Character:FindFirstChild("TitanumHighlight") if hl then hl:Destroy() end
            if v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("TitanumESP") then v.Character.Head.TitanumESP:Destroy() end
        end
    end
    Titanum.fadeGUIFunc(1, 0.3) task.wait(0.3)
    Titanum.ScreenGuiObj:Destroy()
    shared.TitanumConfig = nil
end
Titanum.UnloadBtnObj.MouseButton1Click:Connect(masterUnload)
Titanum.SpeedBtnObj.MouseButton1Click:Connect(function() if Titanum.isUnloaded then return end if Titanum.isSpeed then Titanum.disableSpeedFunc() pcall(function() StarterGui:SetCore("SendNotification", {Title = "titanum hub", Text = "Speedhack: DISABLED", Duration = 1.5}) end) else Titanum.enableSpeedFunc() pcall(function() StarterGui:SetCore("SendNotification", {Title = "titanum hub", Text = "Speedhack: ENABLED", Duration = 1.5}) end) end end)
Titanum.JumpBtnObj.MouseButton1Click:Connect(function() if Titanum.isUnloaded then return end if Titanum.isJump then Titanum.disableJumpFunc() pcall(function() StarterGui:SetCore("SendNotification", {Title = "titanum hub", Text = "Super Jump: DISABLED", Duration = 1.5}) end) else Titanum.enableJumpFunc() pcall(function() StarterGui:SetCore("SendNotification", {Title = "titanum hub", Text = "Super Jump: ENABLED", Duration = 1.5}) end) end end)
Titanum.NoclipBtnObj.MouseButton1Click:Connect(function() if Titanum.isUnloaded then return end if Titanum.isNoclip then Titanum.disableNoclipFunc() pcall(function() StarterGui:SetCore("SendNotification", {Title = "titanum hub", Text = "Noclip: DISABLED", Duration = 1.5}) end) else Titanum.enableNoclipFunc() pcall(function() StarterGui:SetCore("SendNotification", {Title = "titanum hub", Text = "Noclip: ENABLED", Duration = 1.5}) end) end end)
Titanum.BindBtnObj.MouseButton1Click:Connect(function() if Titanum.isUnloaded then return end Titanum.isBinding = true Titanum.BindBtnObj.Text, Titanum.BindStrokeObj.Color = "Press any key...", Color3.fromRGB(255, 255, 0) end)
player.CharacterAdding:Connect(function() Titanum.disableSpeedFunc() Titanum.disableJumpFunc() Titanum.disableNoclipFunc() end)
