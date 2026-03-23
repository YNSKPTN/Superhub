-- [[ YNS V40 - STEALTH SCANNER (GİZLİ VE YAVAŞ) ]]
local p = game.Players.LocalPlayer
print("--- GİZLİ TARAMA MODU: YAVAŞ VE DİKKATLİ ---")

-- Atılmamak için sadece belli başlı klasörlere bakalım
local storage = game:GetService("ReplicatedStorage")
local events = storage:FindFirstChild("Events") or storage

-- Hepsini birden değil, tek tek deneyeceğiz
local targets = {}
for _, v in pairs(events:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        table.insert(targets, v)
    end
end

task.spawn(function()
    for i, remote in ipairs(targets) do
        -- Her kapı arasında 2 saniye bekle (Atılmamak için)
        task.wait(2) 
        
        pcall(function()
            print("Denetimden kaçarak deniyorum: " .. remote.Name)
            -- Sadece 1 kez, çok basit bir istek gönder
            remote:FireServer(1) 
        end)
        
        -- Eğer hala oyundaysak devam et...
    end
    print("--- TARAMA BİTTİ, GÜVENDESİN ---")
end)
