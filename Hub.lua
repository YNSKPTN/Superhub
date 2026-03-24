-- [[ YNS V500 - ULTRA MIKNATIS VE IŞINLANMA MODU ]]
print("--- SON OPERASYON: BUTONLAR SÖMÜRÜLÜYOR... ---")

local player = game.Players.LocalPlayer
local root = player.Character:WaitForChild("HumanoidRootPart")
local oldPos = root.CFrame -- Eski yerini kaydet

task.spawn(function()
    while task.wait(0.5) do -- Sunucu fark etmesin diye yarım saniyede bir
        pcall(function()
            for _, v in pairs(workspace:GetDescendants()) do
                -- Ekrandaki o 'ButtonPart' isimli yeşil butonları bul
                if v.Name == "ButtonPart" and v:IsA("BasePart") then
                    
                    -- 1. Işınlan: Butonun tam merkezine git
                    root.CFrame = v.CFrame 
                    task.wait(0.05)
                    
                    -- 2. Dokun: Fiziksel teması zorla
                    firetouchinterest(root, v, 0)
                    firetouchinterest(root, v, 1)
                    
                    -- 3. Geri Dön: Karakterini eski yerine çek (Çakılmamak için)
                    root.CFrame = oldPos
                end
            end
        end)
    end
end)

-- EKSTRA: Eğer para bir yerde birikiyorsa onu 'Mıknatıs' gibi çek
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            for _, drop in pairs(workspace:GetDescendants()) do
                -- Yerdeki paralar genelde 'Part' veya 'MeshPart'tır
                if drop.Name:lower():find("money") or drop.Name:lower():find("cash") or drop.Name:lower():find("gold") then
                    drop.CFrame = root.CFrame -- Parayı direkt cebine getir!
                end
            end
        end)
    end
end)

print("--- KARAKTERİN TİTREMEYE BAŞLARSA ÇALIŞIYOR DEMEKTİR! ---")
