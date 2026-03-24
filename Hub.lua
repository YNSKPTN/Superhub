-- [[ YNS V900 - OYUNCU İZLEME VE RÖNTGEN SCRIPT ]]
local players = game:GetService("Players")
local lp = players.LocalPlayer
local cam = workspace.CurrentCamera

-- 1. ADIM: Basit Bir Arayüz (GUI) Oluşturma
local screenGui = Instance.new("ScreenGui", lp.PlayerGui)
local mainFrame = Instance.new("ScrollingFrame", screenGui)
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Position = UDim2.new(0, 10, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.CanvasSize = UDim2.new(0, 0, 5, 0) -- Oyuncu çoksa aşağı kaydır

local title = Instance.new("TextLabel", screenGui)
title.Size = UDim2.new(0, 200, 0, 30)
title.Position = UDim2.new(0, 10, 0.5, -180)
title.Text = "HEDEFİ SEÇ VE İZLE"
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- 2. ADIM: Oyuncuları Listeleme Fonksiyonu
local function refreshList()
    for _, v in pairs(mainFrame:GetChildren()) do v:Destroy() end
    
    local offset = 0
    for _, p in pairs(players:GetPlayers()) do
        if p ~= lp then
            local btn = Instance.new("TextButton", mainFrame)
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, offset)
            btn.Text = p.DisplayName or p.Name
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            
            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("Humanoid") then
                    cam.CameraSubject = p.Character.Humanoid
                    print("Şu an izleniyor: " .. p.Name)
                end
            end)
            offset = offset + 35
        end
    end
end

-- 3. ADIM: Kendine Dönme Butonu
local resetBtn = Instance.new("TextButton", screenGui)
resetBtn.Size = UDim2.new(0, 200, 0, 30)
resetBtn.Position = UDim2.new(0, 10, 0.5, 160)
resetBtn.Text = "KENDİNE DÖN"
resetBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

resetBtn.MouseButton1Click:Connect(function()
    cam.CameraSubject = lp.Character.Humanoid
end)

refreshList()
players.PlayerAdded:Connect(refreshList)
players.PlayerRemoving:Connect(refreshList)

print("--- RÖNTGEN MODU AKTİF! SOLDAKİ LİSTEDEN SEÇ. ---")
