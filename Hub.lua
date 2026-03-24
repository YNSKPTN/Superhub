-- [[ YNS V410 - GİZLİ HEDEF KİLİTLEYİCİ ]]
print("--- SİSTEM TEMİZLENİYOR VE PARA HEDEF ALINIYOR ---")

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- 1. ADIM: Ekranın Ortasında Bilgi Paneli (Hata var mı yok mu göreceksin)
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local textLabel = Instance.new("TextLabel", screenGui)
textLabel.Size = UDim2.new(0, 400, 0, 50)
textLabel.Position = UDim2.new(0.5, -200, 0, 100)
textLabel.Text = "Bot Aktif: Butonlar ve Para Aranıyor..."
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.BackgroundColor3 = Color3.new(0, 0, 0)

-- 2. ADIM: Agresif Buton Tetikleyici (Işınlanmadan Dokunma)
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            for _, v in pairs(workspace:GetDescendants()) do
                -- Tycoon'lardaki gizli toplama ve satın alma noktaları
                if v:IsA("TouchTransmitter") then
                    local p = v.Parent
                    if p.Name:lower():find("collect") or p.Name:lower():find("claim") or p.Name:lower():find("button") then
                        -- Karakterin ayağını oraya değdirmiş gibi yap (Sürekli)
                        firetouchinterest(char.HumanoidRootPart, p, 0)
                        task.wait(0.01)
                        firetouchinterest(char.HumanoidRootPart, p, 1)
                        textLabel.Text = "HEDEF BULUNDU: " .. p.Name
                    end
                end
            end
        end)
    end
end)

-- 3. ADIM: "Zorla Para İste" (RemoteEvent Darlayıcı)
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:lower():find("money") or v.Name:lower():find("cash")) then
                    v:FireServer(999999) -- Miktar zorlama
                    v:FireServer()
                end
            end
        end)
    end
end)

print("--- EKRANIN ÜSTÜNDEKİ YAZIYI TAKİP ET! ---")
