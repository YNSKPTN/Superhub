-- [[ YNS V400 - GİZLİ OPERASYON: EVRENSEL TYCOON CRACKER ]]
print("--- HEDEF BELİRLENMEDİ AMA OPERASYON BAŞLADI ---")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 1. ADIM: "Görünmez El" (Tüm butonlara aynı anda basar)
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            for _, v in pairs(workspace:GetDescendants()) do
                -- Eğer bir buton varsa ve dokunulabiliyorsa (Touch)
                if v:IsA("TouchTransmitter") and (v.Parent.Name:lower():find("button") or v.Parent.Name:lower():find("buy")) then
                    firetouchinterest(character.HumanoidRootPart, v.Parent, 0)
                    task.wait(0.01)
                    firetouchinterest(character.HumanoidRootPart, v.Parent, 1)
                end
            end
        end)
    end
end)

-- 2. ADIM: "Para Sızdırıcı" (Gizli RemoteEvent'leri bulur)
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local n = v.Name:lower()
                    -- En yaygın Tycoon kapı isimleri:
                    if n:find("collect") or n:find("money") or n:find("cash") or n:find("claim") or n:find("give") or n:find("add") then
                        v:FireServer()
                        v:FireServer(true)
                    end
                end
            end
        end)
    end
end)

-- 3. ADIM: "Işık Hızı" (Her şeyi toplaman için)
if character:FindFirstChild("Humanoid") then
    character.Humanoid.WalkSpeed = 100
end

print("--- BOT ŞU AN OYUNU TARAYIP BOŞLUK ARIYOR... ---")
