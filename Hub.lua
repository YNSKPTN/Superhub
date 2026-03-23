local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

-- --- ARAYÜZ ---
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "YNS_V7_Ghost"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "👻 YNSKPTN V7.0 - GHOST MODE"
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

-- --- DEĞİŞKENLER ---
local noclip = false
local flying = false
local flySpeed = 50

-- --- NO CLIP DÖNGÜSÜ ---
runService.Stepped:Connect(function()
    if noclip then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- --- BUTON OLUŞTURUCU ---
local function createBtn(text, pos, color, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = pos
    btn.Text = text .. " [KAPALI]"
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = mainFrame
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and " [AÇIK]" or " [KAPALI]")
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 180, 0) or color
        func(active)
    end)
end

-- 1. NO CLIP (DUVARLARDAN GEÇME)
createBtn("🧱 NO CLIP", UDim2.new(0.05, 0, 0.12, 0), Color3.fromRGB(80, 80, 0), function(state)
    noclip = state
end)

-- 2. GÖRÜNMEZLİK
createBtn("👻 GÖRÜNMEZLİK", UDim2.new(0.05, 0, 0.22, 0), Color3.fromRGB(50, 50, 50), function(state)
    for _, part in pairs(player.Character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.Transparency = state and 1 or 0
        end
    end
    player.Character.HumanoidRootPart.Transparency = 1
end)

-- 3. UÇUŞ
createBtn("🕊️ UÇUŞ", UDim2.new(0.05, 0, 0.32, 0), Color3.fromRGB(0, 80, 150), function(state)
    flying = state
    local root = player.Character.HumanoidRootPart
    if flying then
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while flying do
                bv.Velocity = camera.CFrame.LookVector * (player.Character.Humanoid.MoveDirection.Magnitude > 0 and flySpeed or 0)
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

-- 4. İZLEME LİSTESİ (Alt Bölüm)
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.9, 0, 0.45, 0)
scroll.Position = UDim2.new(0.05, 0, 0.45, 0)
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scroll.Parent = mainFrame
Instance.new("UIListLayout", scroll)

local function updateList()
    for _, c in pairs(scroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local f = Instance.new("Frame")
            f.Size = UDim2.new(1, -10, 0, 35)
            f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            f.Parent = scroll
            
            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(0.6, 0, 1, 0)
            l.Text = v.DisplayName
            l.TextColor3 = Color3.new(1, 1, 1)
            l.BackgroundTransparency = 1
            l.TextScaled = true
            l.Parent = f
            
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(0.35, 0, 0.8, 0)
            b.Position = UDim2.new(0.62, 0, 0.1, 0)
            b.Text = "İZLE"
            b.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            b.Parent = f
            
            b.MouseButton1Click:Connect(function()
                if camera.CameraSubject == v.Character.Humanoid then
                    camera.CameraSubject = player.Character.Humanoid
                    b.Text = "İZLE"
                    b.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
                else
                    camera.CameraSubject = v.Character.Humanoid
                    b.Text = "BIRAK"
                    b.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
                end
            end)
        end
    end
end
game.Players.PlayerAdded:Connect(updateList)
game.Players.PlayerRemoving:Connect(updateList)
updateList()
