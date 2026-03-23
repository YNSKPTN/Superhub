local p = game.Players.LocalPlayer
local c = workspace.CurrentCamera
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
sg.Name = "YNS_Final_God"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 300, 0, 580)
main.Position = UDim2.new(0.5, -150, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.Active = true
main.Draggable = true

-- [KAPAT/AÇ]
local mini = Instance.new("TextButton", sg)
mini.Size = UDim2.new(0, 50, 0, 50)
mini.Position = UDim2.new(0, 10, 0.5, -25)
mini.Text = "YNS"
mini.Visible = false
mini.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
mini.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", mini).CornerRadius = UDim.new(0, 25)

local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "_"
close.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
close.MouseButton1Click:Connect(function() main.Visible = false mini.Visible = true end)
mini.MouseButton1Click:Connect(function() main.Visible = true mini.Visible = false end)

-- [NOCLIP & KILL TOGGLES]
local noclipOn, killOn = false, false

local function makeBtn(txt, pos, color, cb)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.42, 0, 0, 35)
    b.Position = pos
    b.Text = txt .. ": OFF"
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(function() cb(b) end)
    return b
end

makeBtn("NOCLIP", UDim2.new(0.05, 0, 0.08, 0), Color3.fromRGB(60, 30, 0), function(b)
    noclipOn = not noclipOn
    b.Text = "NOCLIP: " .. (noclipOn and "ON" or "OFF")
    b.BackgroundColor3 = noclipOn and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(60, 30, 0)
end)

makeBtn("ULTRA KILL", UDim2.new(0.53, 0, 0.08, 0), Color3.fromRGB(80, 0, 0), function(b)
    killOn = not killOn
    b.Text = "KILL: " .. (killOn and "ON" or "OFF")
    b.BackgroundColor3 = killOn and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(80, 0, 0)
end)

-- [SLIDERS]
local function makeSlider(text, pos, min, max, default, callback)
    local label = Instance.new("TextLabel", main)
    label.Size = UDim2.new(0.9, 0, 0, 15); label.Position = pos; label.Text = text .. ": " .. default; label.TextColor3 = Color3.new(1,1,1); label.BackgroundTransparency = 1; label.TextSize = 11
    local sld = Instance.new("TextButton", main); sld.Size = UDim2.new(0.9, 0, 0, 8); sld.Position = pos + UDim2.new(0, 0, 0, 18); sld.Text = ""; sld.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    local bar = Instance.new("Frame", sld); bar.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); bar.BackgroundColor3 = Color3.fromRGB(0, 180, 255); bar.BorderSizePixel = 0
    sld.MouseButton1Down:Connect(function()
        local move = uis.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local pVal = math.clamp((input.Position.X - sld.AbsolutePosition.X) / sld.AbsoluteSize.X, 0, 1)
                bar.Size = UDim2.new(pVal, 0, 1, 0)
                local val = math.floor(min + (pVal * (max - min)))
                label.Text = text .. ": " .. val; callback(val)
            end
        end)
        uis.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then move:Disconnect() end end)
    end)
end

local sV, jV, fV, dV, rV = 16, 50, 80, 15, 10
makeSlider("ÖLÜM ALANI (RADIUS)", UDim2.new(0.05, 0, 0.16, 0), 2, 50, 10, function(v) rV = v end)
makeSlider("SPEED", UDim2.new(0.05, 0, 0.23, 0), 16, 300, 16, function(v) sV = v end)
makeSlider("JUMP", UDim2.new(0.05, 0, 0.30, 0), 50, 500, 50, function(v) jV = v end)
makeSlider("FOV", UDim2.new(0.05, 0, 0.37, 0), 70, 120, 80, function(v) fV = v end)
makeSlider("ZOOM DIST", UDim2.new(0.05, 0, 0.44, 0), 5, 100, 15, function(v) dV = v end)

-- [DÖNGÜLER]
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if noclipOn and p.Character then
                for _, v in pairs(p.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
            end
            p.Character.Humanoid.WalkSpeed = sV
            p.Character.Humanoid.JumpPower = jV
            p.Character.Humanoid.UseJumpPower = true
            if killOn and p.Character then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if (p.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude <= rV then
                            v.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0) -- HARİTA ALTINA ATAR
                        end
                    end
                end
            end
        end)
    end
end)

-- [OYUNCU LİSTESİ]
local sc = Instance.new("ScrollingFrame", main)
sc.Size = UDim2.new(0.9, 0, 0.38, 0); sc.Position = UDim2.new(0.05, 0, 0.52, 0); sc.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 5)

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
                            c.FieldOfView = fV
                            c.CFrame = CFrame.new(r.Position + (r.CFrame.LookVector * -dV) + Vector3.new(0, dV/2.5, 0), r.Position + (r.CFrame.LookVector * 20))
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
