-- [[ YNS V410 - HEDEF ODAKLI BUTON PATLATICI ]]
print("--- HEDEF KİLİTLENDİ: BUTTONPART ---")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

task.spawn(function()
    while task.wait(0.1) do -- Hızlı ama güvenli tempo
        pcall(function()
            -- Haritadaki tüm 'ButtonPart' isimli objeleri bulur
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "ButtonPart" and v:IsA("BasePart") then
                    -- 1. YÖNTEM: Sanal Dokunuş (Sunucuya dokunduk diyoruz)
                    firetouchinterest(root, v, 0)
                    task.wait()
                    firetouchinterest(root, v, 1)
                    
                    -- 2. YÖNTEM: Teleport Dokunuşu (Hafifçe butona değip geri döner)
                    -- Eğer para artmıyorsa karakterini butonun üstüne götürür
                    -- root.CFrame = v.CFrame 
                end
            end
        end)
    end
end)

-- EKSTRA: Karakterini biraz hızlandıralım ki butonlar arası seri gez
character.Humanoid.WalkSpeed = 80 

print("--- BUTONLARA BASILIYOR, PARANI KONTROL ET! ---")
