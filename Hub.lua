-- [[ YNS V330 - AGE EVOLUTION SAKİN PARA SIZDIRICI ]]
print("--- SESSİZ OPERASYON BAŞLATILDI: HATA ALMADAN KASILIYORUZ ---")

local replicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- 1. ADIM: Hızı düşürerek (HTTP 429 almamak için) parayı sızdır
task.spawn(function()
    while task.wait(1.5) do -- Hızı 0.1'den 1.5 saniyeye çıkardık (Güvenli bölge)
        pcall(function()
            -- Sadece en etkili kapıları hedef alıyoruz
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local n = v.Name:lower()
                    
                    -- Sadece ana para toplama ve geliştirme kapıları
                    if n:find("collect") or n:find("cash") or n:find("add") then
                        v:FireServer()
                        print("Sessizce Para Talep Edildi: " .. v.Name)
                    end
                end
            end
        end)
    end
end)

-- 2. ADIM: Otomatik 'Rebirth' veya 'Auto' Butonlarını Zorla
-- Ekranındaki o 'Auto' yazan yeri tetiklemeye çalışır
task.spawn(function()
    while task.wait(3) do
        pcall(function()
            local events = replicatedStorage:FindFirstChild("Events") or replicatedStorage
            local autoEvent = events:FindFirstChild("AutoClick", true) or events:FindFirstChild("Auto", true)
            if autoEvent then
                autoEvent:FireServer(true)
            end
        end)
    end
end)

print("--- BOT ŞU AN SESSİZ ÇALIŞIYOR, 10-15 SANİYE BEKLE ---")
