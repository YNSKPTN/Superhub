local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

-- --- ARAYÜZ (GUI) ---
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local TPButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Ana Kutu
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0, 10, 0.6, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true -- Ekranda taşıyabilirsin

-- İsim Yazma Kutusu
TextBox.Parent = MainFrame
TextBox.Size = UDim2.new(0, 180, 0, 35)
TextBox.Position = UDim2.new(0, 10, 0, 10)
TextBox.PlaceholderText = "Oyuncu Adı Yaz..."
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.new(1, 1, 1)

-- Işınlanma Butonu
TPButton.Parent = MainFrame
TPButton.Size = UDim2.new(0, 180, 0, 35)
TPButton.Position = UDim2.new(0, 10, 0, 55)
TPButton.Text = "IŞINLAN"
TPButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TPButton.TextColor3 = Color3.new(1, 1, 1)

-- Fonksiyon: Oyuncuyu Bul ve Işınlan
local function TeleportToPlayer()
    local targetName = TextBox.Text:lower()
    local foundPlayer = nil
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName or v.DisplayName:lower():sub(1, #targetName) == targetName then
            foundPlayer = v
            break
        end
    end
    
    if foundPlayer and foundPlayer.Character and foundPlayer.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = foundPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0) -- 3 birim tepesine ışınlar
        print(foundPlayer.Name .. " yanına ışınlanıldı!")
    else
        warn("Oyuncu bulunamadı!")
    end
end

TPButton.MouseButton1Click:Connect(TeleportToPlayer)
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local players = game.Players:GetPlayers()
local index = 1

-- --- ARAYÜZ (GUI) ---
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local NextBtn = Instance.new("TextButton")
local PrevBtn = Instance.new("TextButton")
local StopBtn = Instance.new("TextButton")
local TargetName = Instance.new("TextLabel")

ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.8, 0, 0.4, 0) -- Ekranın sağ tarafı
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "CASUS MODU"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

TargetName.Parent = MainFrame
TargetName.Size = UDim2.new(1, 0, 0, 30)
TargetName.Position = UDim2.new(0, 0, 0.25, 0)
TargetName.Text = "Kendi Karakterin"
TargetName.TextColor3 = Color3.fromRGB(0, 255, 0)

-- --- FONKSİYONLAR ---

local function UpdateCamera(target)
    if target and target.Character and target.Character:FindFirstChild("Humanoid") then
        camera.CameraSubject = target.Character.Humanoid
        TargetName.Text = "İzlenen: " .. target.DisplayName
    end
end

NextBtn.Parent = MainFrame
NextBtn.Size = UDim2.new(0, 90, 0, 30)
NextBtn.Position = UDim2.new(0.52, 0, 0.5, 0)
NextBtn.Text = "İleri >"
NextBtn.MouseButton1Click:Connect(function()
    players = game.Players:GetPlayers()
    index = index + 1
    if index > #players then index = 1 end
    UpdateCamera(players[index])
end)

PrevBtn.Parent = MainFrame
PrevBtn.Size = UDim2.new(0, 90, 0, 30)
PrevBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
PrevBtn.Text = "< Geri"
PrevBtn.MouseButton1Click:Connect(function()
    players = game.Players:GetPlayers()
    index = index - 1
    if index < 1 then index = #players end
    UpdateCamera(players[index])
end)

StopBtn.Parent = MainFrame
StopBtn.Size = UDim2.new(0, 180, 0, 30)
StopBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
StopBtn.Text = "İzlemeyi Bırak"
StopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
StopBtn.MouseButton1Click:Connect(function()
    camera.CameraSubject = player.Character.Humanoid
    TargetName.Text = "Kendi Karakterin"
end)
