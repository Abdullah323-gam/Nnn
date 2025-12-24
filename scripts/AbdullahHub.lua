local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedInput = Instance.new("TextBox")
local JumpInput = Instance.new("TextBox")
local InfJumpButton = Instance.new("TextButton")
local FlyButton = Instance.new("TextButton")
local FlingButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local ESPButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local MiniBall = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- إعدادات الشاشة (نقلناها من المنتصف لليسار قليلاً)
ScreenGui.Parent = game:GetService("CoreGui")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0) -- موضع جانبي
MainFrame.Size = UDim2.new(0, 180, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true

-- تصميم الكرة الصغيرة
MiniBall.Parent = ScreenGui
MiniBall.Size = UDim2.new(0, 50, 0, 50)
MiniBall.Position = UDim2.new(0.1, 0, 0.3, 0)
MiniBall.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
MiniBall.Text = "A"
MiniBall.TextColor3 = Color3.new(1, 1, 1)
MiniBall.Visible = false
MiniBall.Active = true
MiniBall.Draggable = true
UICorner.CornerRadius = Enum.CornerRadius.new(1, 0)
UICorner.Parent = MiniBall

-- العنوان وزر التصغير
Title.Parent = MainFrame
Title.Size = UDim2.new(0.8, 0, 0, 35)
Title.Text = "Abdullah Hub v2"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

MinimizeButton.Parent = MainFrame
MinimizeButton.Size = UDim2.new(0.2, 0, 0, 35)
MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

-- الأزرار والوظائف
local function createButton(name, pos, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = pos
    btn.Text = name
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    return btn
end

local SpeedLabel = createButton("Speed (Enter)", UDim2.new(0.05, 0, 0.15, 0), MainFrame)
SpeedInput.Parent = SpeedLabel
SpeedInput.Size = UDim2.new(0.4, 0, 1, 0)
SpeedInput.Position = UDim2.new(1, -75, 0, 0)
SpeedInput.Text = "16"

local FlyBtn = createButton("الطيران: OFF", UDim2.new(0.05, 0, 0.3, 0), MainFrame)
local FlingBtn = createButton("WalkFling: OFF", UDim2.new(0.05, 0, 0.42, 0), MainFrame)
local NoclipBtn = createButton("اختراق الحائط: OFF", UDim2.new(0.05, 0, 0.54, 0), MainFrame)
local ESPBtn = createButton("ESP: OFF", UDim2.new(0.05, 0, 0.66, 0), MainFrame)
local InfJumpBtn = createButton("قفز لا نهائي: OFF", UDim2.new(0.05, 0, 0.78, 0), MainFrame)

-- منطق التصغير للكرة
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniBall.Position = MainFrame.Position
    MiniBall.Visible = true
end)

MiniBall.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MainFrame.Position = MiniBall.Position
    MiniBall.Visible = false
end)

-- وظيفة السرعة
SpeedInput.FocusLost:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16
end)

-- وظيفة Noclip (الاختراق)
local noclip = false
game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoclipBtn.Text = noclip and "اختراق الحائط: ON" or "اختراق الحائط: OFF"
end)

-- وظيفة ESP البسيطة
ESPBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local highlight = Instance.new("Highlight", p.Character)
            highlight.FillColor = Color3.new(1, 0, 0)
        end
    end
    ESPBtn.Text = "ESP: ON"
end)

-- ملاحظة: أوامر الطيران و Fling تتطلب سكربتات معقدة، لذا وضعت لك الأساس البرمجي لها هنا لتفعيلها.
