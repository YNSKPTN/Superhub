local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

-- --- ARAYÜZ ---
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "YNS_Final_Hub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0.5, -160, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "🛡️ YNS V5.5: EKSİKSİZ HUB 🕵️‍♂️"
title.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

-- --- DEĞİŞKENLER & DURUMLAR ---
local watchingPlayer = nil
local cameraConn = nil
local godActive = false

-- --- 1. SERT ÖLÜMSÜZLÜK (V3) ---
local godBtn = Instance.new("TextButton")
godBtn.Size = UDim2.new(0.9, 0, 0, 50)
godBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
godBtn.Text = "ULTIMATE GOD [KAPALI]"
godBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
godBtn.TextColor3 = Color3.new(1, 1, 1)
godBtn.Font = Enum.Font.SourceSansBold
godBtn.Parent = mainFrame

godBtn.MouseButton1Click:Connect(function()
    godActive = not godActive
    godBtn.Text = "ULTIMATE GOD " .. (godActive and "[AKTİF]" or "[KAPALI]")
    godBtn.BackgroundColor3 = godActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(150, 0, 0)
    
    task.spawn(function()
        while godActive do
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    hum.MaxHealth = 999999
                    hum.Health = 999999
                    hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    if hum:GetState() == Enum.HumanoidStateType.Dead then
                        hum:ChangeState(Enum.HumanoidStateType.Running)
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

-- --- 2. OYUNCU LİSTESİ (İZLE & TAM İÇİNE GİT) ---
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.9, 0, 0.6, 0)
scroll.Position = UDim2.new(0.05, 0, 0.32, 0)
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
scroll.Parent = mainFrame
Instance.new("UIListLayout", scroll)

local function updateList()
    for _, c in pairs(scroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local f = Instance.new("Frame")
            f.Size = UDim2.new(1, -10, 0, 45)
            f.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            f.Parent = scroll
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(0.4, 0, 1, 0)
            nameLabel.Text = v.DisplayName
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextScaled = true
            nameLabel.Parent = f
            
            -- İZLE BUTONU (Senkronize)
            local watchBtn = Instance.new("TextButton")
            watchBtn.Size = UDim2.new(0.28, 0, 0.8, 0)
            watchBtn.Position = UDim2.new(0.42, 0, 0.1, 0)
            watchBtn.Text = "İZLE"
            watchBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
            watchBtn.Parent = f
            
            watchBtn.MouseButton1Click:Connect(function()
                if watchingPlayer == v then
                    watchingPlayer = nil
                    if cameraConn then cameraConn:Disconnect() end
                    camera.CameraSubject = player.Character.Humanoid
                    watchBtn.Text = "İZLE"
                else
                    watchingPlayer = v
                    watchBtn.Text = "BIRAK"
                    if cameraConn then cameraConn:Disconnect() end
                    cameraConn = runService.RenderStepped:Connect(function()
                        if watchingPlayer == v and v.Character and v.Character:FindFirstChild("Head") then
                            camera.CameraSubject = v.Character.Humanoid
                            camera.CFrame = v.Character.Head.CFrame * CFrame.new(0, 0.5, 0)
                        else
                            cameraConn:Disconnect()
                        end
                    end)
                end
            end)

            -- TAM İÇİNE GİT BUTONU
            local tpBtn = Instance.new("TextButton")
            tpBtn.Size = UDim2.new(0.25, 0, 0.8, 0)
            tpBtn.Position = UDim2.new(0.72, 0, 0.1, 0)
            tpBtn.Text = "GİT"
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            tpBtn.Parent = f
            
            tpBtn.MouseButton1Click:Connect(function()
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
end

updateList()
game.Players.PlayerAdded:Connect(updateList)
game.Players.PlayerRemoving:Connect(updateList)
