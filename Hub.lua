-- [[ YNS V320 - AGE EVOLUTION SINIRSIZ PARA BASICI ]]
print("--- PARA MUSLUKLARI SONUNA KADAR AÇILIYOR... ---")

local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

task.spawn(function()
    while task.wait(0.1) do -- Işık hızında para isteği
        pcall(function()
            -- 1. ADIM: Tüm Remote kapılarını 'Para Ver' diye darlıyoruz
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local n = v.Name:lower()
                    
                    -- Para toplama, Satma veya Nakit alma kapıları
                    if n:find("collect") or n:find("cash") or n:find("money") or n:find("sell") or n:find("earn") then
                        v:FireServer() -- Sunucuya 'Paramı ver' sinyali
                        v:FireServer(999999999) -- Bazı oyunlarda miktar girilebilir
                    end
                end
            end
            
            -- 2. ADIM: Otomatik Damlatıcı (Dropper) Hızlandırma
            -- Eğer oyunda paralar bir yere düşüyorsa, orayı sürekli 'temizle/topla'
            local tycoon = workspace:FindFirstChild(player.Name .. "Tycoon") or workspace:FindFirstChild("Tycoons"):FindFirstChild(player.Name)
            if tycoon then
                local collector = tycoon:FindFirstChild("Collector", true)
                if collector then
                    -- Karakterini sürekli kolektöre değdiriyormuş gibi yap
                    firetouchinterest(player.Character.HumanoidRootPart, collector, 0)
                    task.wait(0.01)
                    firetouchinterest(player.Character.HumanoidRootPart, collector, 1)
                end
            end
        end)
    end
end)

print("--- BOT AKTİF: PARANI KONTROL ET! ---")
