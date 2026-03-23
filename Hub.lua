-- [[ YNS V300 - AGE EVOLUTION TYCOON ÖZEL HİLE ]]
print("--- ÇAĞ ATLAMA OPERASYONU BAŞLATILDI ---")

local replicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- 1. ADIM: Otomatik Para Toplama ve Üretim Hızlandırma
task.spawn(function()
    while task.wait(0.1) do 
        pcall(function()
            -- Oyundaki tüm 'Event'leri tara ve tetikle
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local n = v.Name:lower()
                    
                    -- Para toplama (Collect), Nakit (Cash), Para (Money)
                    if n:find("collect") or n:find("money") or n:find("cash") or n:find("claim") then
                        v:FireServer()
                    end
                    
                    -- Çağ atlama veya Birim üretme (Evolution/Spawn)
                    if n:find("evolve") or n:find("upgrade") or n:find("buy") or n:find("spawn") then
                        v:FireServer()
                    end
                end
            end
        end)
    end
end)

-- 2. ADIM: Süper Hız ve Görünmezlik (Etrafta kimseye çarpmadan gez)
if player.Character and player.Character:FindFirstChild("Humanoid") then
    player.Character.Humanoid.WalkSpeed = 150 -- Çok hızlı koşma
    player.Character.Humanoid.JumpPower = 100 -- Yüksek zıplama
end

print("--- BOT AKTİF: ÇAĞLAR SENİN İÇİN DEĞİŞİYOR! ---")
