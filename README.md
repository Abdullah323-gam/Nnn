local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("AbdullahHub") then
    PlayerGui.AbdullahHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedInput = Instance.new("TextBox")
local JumpInput = Instance.new("TextBox")
local InfJumpBtn = Instance.new("TextButton")
local NoclipBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")
local MiniBall = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MiniCorner = Instance.new("UICorner")

ScreenGui.Name = "AbdullahHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 170, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "Abdullah Hub"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "-"
CloseBtn.BackgroundColor3 = Color3.new(1, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)

SpeedInput.Parent = MainFrame
SpeedInput.PlaceholderText = "السرعة"
SpeedInput.Size = UDim2.new(0.8, 0, 0, 30)
SpeedInput.Position = UDim2.new(0.1, 0, 0.2, 0)
SpeedInput.Text = "16"

JumpInput.Parent = MainFrame
JumpInput.PlaceholderText = "القفز"
JumpInput.Size = UDim2.new(0.8, 0, 0, 30)
JumpInput.Position = UDim2.new(0.1, 0, 0.35, 0)
JumpInput.Text = "50"

NoclipBtn.Parent = MainFrame
NoclipBtn.Size = UDim2.new(0.8, 0, 0, 30)
NoclipBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
NoclipBtn.Text = "اختراق: OFF"

ESPBtn.Parent = MainFrame
ESPBtn.Size = UDim2.new(0.8, 0, 0, 30)
ESPBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
ESPBtn.Text = "كاشف: OFF"

InfJumpBtn.Parent = MainFrame
InfJumpBtn.Size = UDim2.new(0.8, 0, 0, 30)
InfJumpBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
InfJumpBtn.Text = "قفز مستمر: OFF"

MiniBall.Parent = ScreenGui
MiniBall.Size = UDim2.new(0, 50, 0, 50)
MiniBall.Visible = false
MiniBall.Text = "A"
MiniBall.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
MiniBall.TextColor3 = Color3.new(1, 1, 1)
MiniBall.Draggable = true
MiniCorner.CornerRadius = Enum.CornerRadius.new(1, 0)
MiniCorner.Parent = MiniBall

local noclip = false
local esp = false
local infjump = false

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniBall.Visible = true
    MiniBall.Position = MainFrame.Position
end)

MiniBall.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniBall.Visible = false
end)

SpeedInput.FocusLost:Connect(function()
    Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16
end)

JumpInput.FocusLost:Connect(function()
    Player.Character.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50
end)

NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoclipBtn.Text = noclip and "اختراق: ON" or "اختراق: OFF"
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip and Player.Character then
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

ESPBtn.MouseButton1Click:Connect(function()
    esp = not esp
    ESPBtn.Text = esp and "كاشف: ON" or "كاشف: OFF"
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= Player and p.Character then
            if esp then
                local h = Instance.new("Highlight", p.Character)
                h.Name = "AbdullahESP"
            else
                if p.Character:FindFirstChild("AbdullahESP") then p.Character.AbdullahESP:Destroy() end
            end
        end
    end
end)

InfJumpBtn.MouseButton1Click:Connect(function()
    infjump = not infjump
    InfJumpBtn.Text = infjump and "قفز مستمر: ON" or "قفز مستمر: OFF"
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infjump and Player.Character then
        Player.Character.Humanoid:ChangeState("Jumping")
    end
end)
