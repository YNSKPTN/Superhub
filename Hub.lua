-- [[ YNS V70 - CLASHERS ROYALE HER ŞEYİ AÇMA ]]
print("--- ÖDÜL SİSTEMİ MANİPÜLE EDİLİYOR... ---")

local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = replicatedStorage:WaitForChild("Events") -- Klasör adı farklıysa otomatik tarar

-- 1. ADIM: Sandık ve Ödül Kapılarını Bul
for _, v in pairs(replicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local n = v.Name:lower()
        -- Ödül, Sandık veya Galibiyet sinyallerini yakala
        if n:find("chest") or n:find("reward") or n:find("win") or n:find("claim") then
            print("Ödül Kapısı Yakalandı: " .. v.Name)
            
            -- Sürekli ödül talep et (Düşük hızda, atılmamak için)
            task.spawn(function()
                while task.wait(1) do
                    pcall(function()
                        v:FireServer(true) 
                        v:FireServer("Legendary") -- Efsanevi kart denemesi
                    end)
                end
            end)
        end
    end
end

-- 2. ADIM: Maç Hilesi (Saniyede Taç Alma)
-- Eğer bir maçtaysan bu kod maçı anında bitirmeyi dener
local matchEvent = replicatedStorage:FindFirstChild("EndMatch", true)
if matchEvent then
    matchEvent:FireServer(true, 3) -- 3 taçla kazandım sinyali
end

print("--- OPERASYON TAM GAZ DEVAM EDİYOR! ---")
