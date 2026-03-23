-- [[ YNS V52 - INFECTIOUS SMILE SINIRSIZ PARA/PUAN ]]
print("--- SON OPERASYON BAŞLADI: PARA BASILIYOR ---")

local replicatedStorage = game:GetService("ReplicatedStorage")
local remotePath = "Events" -- Genelde bu klasördedir

-- 1. ADIM: Gizli Ödül Kapılarını Bul ve Tetikle
local function farmSmiles()
    for _, v in pairs(replicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            local name = v.Name:lower()
            -- Puan veren muhtemel anahtar kelimeler
            if name:find("reward") or name:find("prizes") or name:find("addsmiles") or name:find("credit") then
                print("Para Kapısı Bulundu: " .. v.Name)
                v:FireServer(999, "Smiles") -- Miktar ve tip gönderimi
                v:FireServer(true)
            end
        end
    end
end

-- 2. ADIM: Sürekli Çalıştır (Farm Modu)
task.spawn(function()
    while task.wait(0.5) do -- Atılmamak için yarım saniyede bir
        pcall(function()
            farmSmiles()
            -- Oyunun özel 'Infection' ödülünü simüle et
            local infectEvent = replicatedStorage:FindFirstChild("InfectPlayer", true)
            if infectEvent then
                infectEvent:FireServer(game.Players.LocalPlayer) -- Kendini değil, hayali birini enfekte etmiş gibi yap
            end
        end)
    end
end)

-- 3. ADIM: Sunucudan Atılmayı Engelle (Anti-Kick)
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    if getnamecallmethod() == "Kick" then return nil end
    return old(self, ...)
end)

print("--- PARA BASMA AKTİF! MARKETİ KONTROL ET ---")
