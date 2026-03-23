local p = game.Players.LocalPlayer
local c = workspace.CurrentCamera
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
sg.Name = "YNS_Godfather_V17"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 300, 0, 520) -- Zıplama için biraz daha uzattık
main.Position = UDim2.new(0.5, -150, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.Active = true
main.Draggable = true

local mini = Instance.new("TextButton", sg)
mini.Size = UDim2.new(0, 50, 0, 50)
mini.Position = UDim2.new(0, 10, 0.5, -25)
mini.Text = "YNS"
mini.Visible = false
mini.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
mini.TextColor3 = Color3.new(1,1,1)

local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "_"
close.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() main.Visible = false mini.Visible = true end)
mini.MouseButton1Click:Connect(function() main.Visible = true mini.Visible = false end)

-- [NOCLIP]
local noclipOn = false
local noclipBtn = Instance.new("TextButton", main)
noclipBtn.Size = UDim2.new(0.9, 0, 0, 30)
noclipBtn.Position = UDim2.new(0.05, 0, 0.08, 0)
noclipBtn.Text = "NOCLIP: OFF"
noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 0)
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.MouseButton1Click:Connect(function()
    noclipOn = not noclipOn
    noclipBtn.Text = "NOCLIP: " .. (noclipOn and "ON" or "OFF")
    noclipBtn.BackgroundColor3 = noclipOn and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 30, 0)
    rs.Stepped:Connect(function()
        if noclipOn and p.Character then
            for _, v in pairs(p.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
        end
    end)
end)

-- [SLIDER FONKSİYONU]
local function makeSlider(text, pos, min, max, default, callback)
    local label = Instance.new("TextLabel", main)
    label.Size = UDim2.new(0.9, 0, 0, 15)
    label.Position = pos
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.new(1,1,1)
    label.BackgroundTransparency = 1
    label.TextSize = 12

    local sld = Instance.new("TextButton", main)
    sld.Size = UDim2.new(0.9, 0, 0, 8)
    sld.Position = pos + UDim2.new(0, 0, 0, 18)
    sld.Text = ""
    sld.BackgroundColor3 = Color3.fromRGB(40, 40, 50)

    local bar = Instance.new("Frame", sld)
    bar.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    bar.BorderSizePixel = 0

    sld.MouseButton1Down:Connect(function()
        local move = uis.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local pVal = math.clamp((input.Position.X - sld.AbsolutePosition.X) / sld.AbsoluteSize.X, 0, 1)
                bar.Size = UDim2.new(pVal, 0, 1, 0)
                local val = math.floor(min + (pVal * (max - min)))
                label.Text = text .. ": " .. val
                callback(val)
            end
        end)
        uis.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then move:Disconnect() end end)
    end)
end

-- AYARLAR (HIZ, ZIPLAMA, FOV, DIST)
local sV, jV = 16, 50
makeSlider("HIZ (SPEED)", UDim2.new(0.05, 0, 0.15, 0), 16, 300, 16, function(v) sV = v end)
makeSlider("ZIPLAMA (JUMP)", UDim2.new(0.05, 0, 0.22, 0), 50, 500, 50, function(v) jV = v end)
local getFOV = 80; makeSlider("FOV", UDim2.new(0.05, 0, 0.29, 0), 70, 120, 80, function(v) getFOV = v end)
local getDist = 15; makeSlider("MESAFE", UDim2.new(0.05, 0, 0.36, 0), 5, 100, 15, function(v) getDist = v end)

task.spawn(function()
    while task.wait() do
        pcall(function() 
            local h = p.Character.Humanoid
            h.WalkSpeed = sV
            h.JumpPower = jV
            h.UseJumpPower = true 
        end)
    end
end)

-- [OYUNCU LİSTESİ]
local sc = Instance.new("ScrollingFrame", main)
sc.Size = UDim2.new(0.9, 0, 0.4, 0)
sc.Position = UDim2.new(0.05, 0, 0.45, 0)
sc.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UIListLayout", sc)

local watching, camC = nil, nil
local function up()
    for _, child in pairs(sc:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= p then
            local f = Instance.new("Frame", sc); f.Size = UDim2.new(1, -5, 0, 35); f.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            local nl = Instance.new("TextLabel", f); nl.Size = UDim2.new(0.4, 0, 1, 0); nl.Text = v.DisplayName; nl.TextColor3 = Color3.new(1,1,1); nl.TextScaled = true; nl.BackgroundTransparency = 1
            local wB = Instance.new("TextButton", f); wB.Size = UDim2.new(0.25, 0, 0.8, 0); wB.Position = UDim2.new(0.45, 0, 0.1, 0); wB.Text = "İZLE"; wB.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
            wB.MouseButton1Click:Connect(function()
                if watching == v then watching = nil; if camC then camC:Disconnect() end; c.CameraSubject = p.Character.Humanoid; wB.Text = "İZLE"
                else watching = v; wB.Text = "BIRAK"; if camC then camC:Disconnect() end
                    camC = rs.RenderStepped:Connect(function()
                        if watching == v and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            local r = v.Character.HumanoidRootPart
                            c.FieldOfView = getFOV
                            c.CFrame = CFrame.new(r.Position + (r.CFrame.LookVector * -getDist) + Vector3.new(0, getDist/2.5, 0), r.Position + (r.CFrame.LookVector * 20))
                        else camC:Disconnect() end
                    end)
                end
            end)
            local tB = Instance.new("TextButton", f); tB.Size = UDim2.new(0.25, 0, 0.8, 0); tB.Position = UDim2.new(0.72, 0, 0.1, 0); tB.Text = "GİT"; tB.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            tB.MouseButton1Click:Connect(function() if v.Character then p.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame end end)
        end
    end
end
up(); game.Players.PlayerAdded:Connect(up); game.Players.PlayerRemoving:Connect(up)
