-- [[ YNS V80 - TÜM KARAKTERLERİ AÇMA DENEMESİ ]]
print("--- KARAKTER KİLİTLERİ KIRILIYOR... ---")

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- 1. ADIM: Menüdeki kilitli karakterleri bul ve 'Açık' yap
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            -- Oyundaki karakter/kart menüsünü tarar
            for _, v in pairs(pgui:GetDescendants()) do
                -- 'Locked', 'Buy', 'Price' gibi kısımları temizler
                if v:IsA("TextLabel") or v:IsA("TextButton") then
                    local t = v.Name:lower()
                    if t:find("lock") or t:find("price") or t:find("buy") then
                        v.Visible = false -- Fiyat etiketini gizle
                    end
                    
                    if t:find("select") or t:find("equip") then
                        v.Visible = true
                        v.Active = true
                    end
                end
                
                -- Karakterin 'Owned' (Sahip Olundu) değerini değiştir
                if v.Name == "Owned" or v.Name == "Unlocked" then
                    if v:IsA("BoolValue") then
                        v.Value = true
                    end
                end
            end
        end)
    end
end)

-- 2. ADIM: Karakter Seçme Kapısını (Remote) Zorla
-- Eğer bir karakterin ID'sini biliyorsan, sunucuya 'Bunu seçtim' de
local equipRemote = game:GetService("ReplicatedStorage"):FindFirstChild("EquipCharacter", true)
if equipRemote then
    -- Örnek: En güçlü karakterin ID'si 99 ise onu seçtirir
    -- equipRemote:FireServer(99) 
end

print("--- MENÜYÜ KONTROL ET! KİLİTLER AÇILMIŞ OLMALI ---")
