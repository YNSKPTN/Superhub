local p = game.Players.LocalPlayer
local c = workspace.CurrentCamera
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
sg.Name = "YNS_Glitcher_V23"
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
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() main.Visible = false mini.Visible = true end)
mini.MouseButton1Click:Connect(function() main.Visible = true mini.Visible = false end)

-- --- [ KORUMA DELİCİ: GLITCH KICK ] ---
local glitchOn = false
local gBtn = Instance.new("TextButton", main)
gBtn.Size = UDim2.new(0.9, 0, 0, 40)
gBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
gBtn.Text = "GLITCH KICK: KAPALI"
gBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
gBtn.TextColor3 = Color3.new(1,1,1)

gBtn.MouseButton1Click:Connect(function()
    glitchOn = not glitchOn
    gBtn.Text = "GLITCH KICK: " .. (glitchOn and "AKTİF" or "KAPALI")
    gBtn.BackgroundColor3 = glitchOn and Color3.fromRGB(150, 0, 200) or Color3.fromRGB(40, 40, 40)
end)

-- [SLIDERS]
local function makeSlider(text, pos, min, max, default, callback)
    local label = Instance.new("TextLabel", main)
    label.Size = UDim2.new(0.9, 0, 0, 15); label.Position = pos; label.Text = text .. ": " .. default; label.TextColor3 = Color3.new(1,1,1); label.BackgroundTransparency = 1; label.TextSize = 10
    local sld = Instance.new("TextButton", main); sld.Size = UDim2.new(0.9, 0, 0, 8); sld.Position = pos + UDim2.new(0, 0, 0, 18); sld.Text = ""; sld.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    local bar = Instance.new("Frame", sld); bar.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); bar.BackgroundColor3 = Color3.fromRGB(200, 0, 255); bar.BorderSizePixel = 0
    sld.MouseButton1Down:Connect(function()
        local move = uis.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local pVal = math.clamp((input.Position.X - sld.AbsolutePosition.X) / sld.AbsoluteSize.X, 0, 1)
                bar.Size = UDim2.new(pVal, 0, 1, 0); local val = math.floor(min + (pVal * (max - min))); label.Text = text .. ": " .. val; callback(val)
            end
        end)
        uis.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then move:Disconnect() end end)
    end)
end

local sV, jV, rV = 16, 50, 15
makeSlider("ETKİ ALANI (RADIUS)", UDim2.new(0.05, 0, 0.15, 0), 5, 100, 15, function(v) rV = v end)
makeSlider("SPEED", UDim2.new(0.05, 0, 0.22, 0), 16, 300, 16, function(v) sV = v end)
makeSlider("JUMP", UDim2.new(0.05, 0, 0.29, 0), 50, 500, 50, function(v) jV = v end)

-- --- [ ASIL GLITCH DÖNGÜSÜ ] ---
task.spawn(function()
    while task.wait(0.01) do -- Çok hızlı kontrol
        if glitchOn and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart
                    local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).magnitude
                    if dist <= rV then
                        pcall(function()
                            -- Karakterin fiziğini bozacak kadar yüksek hız ve sonsuz mesafe veriyoruz
                            hrp.Velocity = Vector3.new(0, 1000000, 0) -- Gökyüzüne fırlat
                            hrp.CFrame = hrp.CFrame * CFrame.new(math.random(-500,500), 9999, math.random(-500,500)) 
                            -- Parçalanmaya zorla
                            if v.Character:FindFirstChild("Humanoid") then
                                v.Character.Humanoid.PlatformStand = true
                            end
                        end)
                    end
                end
            end
        end
    end
end)

-- Hız ve Zıplama (Heartbeat ile daha stabil)
rs.Heartbeat:Connect(function()
    if p.Character and p.Character:FindFirstChild("Humanoid") then
        p.Character.Humanoid.WalkSpeed = sV
        p.Character.Humanoid.JumpPower = jV
        p.Character.Humanoid.UseJumpPower = true
    end
end)
