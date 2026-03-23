-- [[ YNS V60 - URN OTOMATİK HAYATTA KALMA BOTU ]]
print("--- URN BOTU BAŞLATILDI: SABAHA KADAR BURADAYIZ ---")

local replicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- 1. ADIM: Otomatik Savunma Fonksiyonu
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            -- Oyundaki savunma kapılarını (Remotes) bulmaya çalışır
            for _, v in pairs(replicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local name = v.Name:lower()
                    
                    -- Kapıları kapat, Maskeyi tak, Işıkları aç
                    if name:find("door") or name:find("light") or name:find("mask") or name:find("vent") then
                        -- Sunucuya 'aktif' sinyali gönderir
                        v:FireServer(true) 
                    end
                end
            end
        end)
    end
end)

-- 2. ADIM: "Sabah 6" Hızlandırıcı (Eğer sunucu izin verirse)
task.spawn(function()
    local clockRemote = replicatedStorage:FindFirstChild("TimeEvent", true) or replicatedStorage:FindFirstChild("Clock", true)
    if clockRemote then
        print("Zaman kapısı bulundu, sabah yapmaya çalışıyorum...")
        clockRemote:FireServer(6) -- Saati direkt 6 yapmayı dener
    end
end)

-- 3. ADIM: Anti-AFK (Oyundan düşmemen için karakteri titretir)
local virtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
end)

print("--- BOT ÇALIŞIYOR: ARKANIZA YASLANIN ---")
