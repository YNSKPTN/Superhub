-- [[ YNS V340 - AGE EVOLUTION NOKTA ATIŞI ]]
print("--- HEDEF KİLİTLENDİ: PARALAR ÇEKİLİYOR ---")

local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Oyunun senin tycoon'unu bulması için:
local myTycoon = workspace:FindFirstChild(player.Name .. "'s Tycoon") or workspace:FindFirstChild(player.Name .. "Tycoon")

task.spawn(function()
    while task.wait(1) do -- Güvenli hız
        pcall(function()
            -- 1. Konsolda gördüğümüz o kapıları 'Argüman' ile besliyoruz
            local events = {
                "UpdateAutoCollect",
                "CollectDrop",
                "Added",
                "MoneyCollectSound"
            }
            
            for _, eventName in pairs(events) do
                local remote = replicatedStorage:FindFirstChild(eventName, true)
                if remote and remote:IsA("RemoteEvent") then
                    -- Sunucuya 'Benim Tycoon'umun parasını topla' diyoruz
                    remote:FireServer(myTycoon) 
                    remote:FireServer(true)
                    remote:FireServer(999999) -- Bazı oyunlar miktar ister
                end
            end
        end)
    end
end)

print("--- KAPILAR ÇALINIYOR, 10 SANİYE İÇİNDE PARAYI KONTROL ET! ---")
