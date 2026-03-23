local p = game.Players.LocalPlayer
local c = workspace.CurrentCamera
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
sg.Name = "YNS_BanHammer_V22"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 300, 0, 580)
main.Position = UDim2.new(0.5, -150, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.Active = true
main.Draggable = true

-- [BUTON SİSTEMİ]
local kickOn = false
local kBtn = Instance.new("TextButton", main)
kBtn.Size = UDim2.new(0.9, 0, 0, 40)
kBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
kBtn.Text = "SERVER KICK: KAPALI"
kBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
kBtn.TextColor3 = Color3.new(1,1,1)

kBtn.MouseButton1Click:Connect(function()
    kickOn = not kickOn
    kBtn.Text = "SERVER KICK: " .. (kickOn and "AKTİF (DİKKAT!)" or "KAPALI")
    kBtn.BackgroundColor3 = kickOn and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
end)

-- [SLIDERS]
local function makeSlider(text, pos, min, max, default, callback)
    local label = Instance.new("TextLabel", main)
    label.Size = UDim2.new(0.9, 0, 0, 15); label.Position = pos; label.Text = text .. ": " .. default; label.TextColor3 = Color3.new(1,1,1); label.BackgroundTransparency = 1; label.TextSize = 10
    local sld = Instance.new("TextButton", main); sld.Size = UDim2.new(0.9, 0, 0, 8); sld.Position = pos + UDim2.new(0, 0, 0, 18); sld.Text = ""; sld.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    local bar = Instance.new("Frame", sld); bar.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); bar.BackgroundColor3 = Color3.fromRGB(0, 180, 255); bar.BorderSizePixel = 0
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

local sV, jV, rV = 16, 50, 10
makeSlider("ETKİ ALANI (RADIUS)", UDim2.new(0.05, 0, 0.15, 0), 5, 100, 10, function(v) rV = v end)
makeSlider("HIZ", UDim2.new(0.05, 0, 0.22, 0), 16, 300, 16, function(v) sV = v end)
makeSlider("ZIPLAMA", UDim2.new(0.05, 0, 0.29, 0), 50, 500, 50, function(v) jV = v end)

-- [KICK / CRASH DÖNGÜSÜ]
task.spawn(function()
    while task.wait(0.1) do
        if kickOn and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (p.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                    if dist <= rV then
                        pcall(function()
                            -- YÖNTEM: Adamı evrenin ötesine fırlat (Işınlanma Korumasını deler)
                            v.Character.HumanoidRootPart.CFrame = CFrame.new(9e9, 9e9, 9e9) 
                            -- Karakterini geçici olarak silmeye çalış (Sadece sende değil sunucuda hata vermesi için)
                            v.Character.Parent = nil 
                        end)
                    end
                end
            end
        end
    end
end)

-- Walkspeed & JumpPower
rs.Heartbeat:Connect(function()
    if p.Character and p.Character:FindFirstChild("Humanoid") then
        p.Character.Humanoid.WalkSpeed = sV
        p.Character.Humanoid.JumpPower = jV
        p.Character.Humanoid.UseJumpPower = true
    end
end)

-- [LİSTE VE DİĞERLERİ AYNI KALDI]
