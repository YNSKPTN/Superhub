-- [[ YNS V43 - COOK BURGERS EKONOMİ SIZINTISI ]]
print("--- PARA YAĞMURU BAŞLATILIYOR ---")

local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Alternatif para yollarını deniyoruz
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            -- 1. Yöntem: Gizli 'AddCash' veya 'GiveMoney' kapılarını zorla
            for _, v in pairs(replicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:lower():find("give") or v.Name:lower():find("add")) then
                    v:FireServer(1000) -- Çok büyük sayı deneme, 1000 ideal
                end
            end
            
            -- 2. Yöntem: Oyunun kendi bağış sistemini kendine yönlendir
            local donateEvent = replicatedStorage:FindFirstChild("Donate", true)
            if donateEvent then
                donateEvent:FireServer(player, 500)
            end
        end)
    end
end)

print("--- ETRAFI KONTROL ET, PARA GELMEZSE BAŞKA YOLA GEÇECEĞİZ ---")
