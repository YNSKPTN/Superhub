-- [[ YNS V65 - COOK BURGERS OTOMATİK İŞÇİ ]]
print("--- AUTO-FARM BAŞLATILDI: PARALAR TOPLANIYOR ---")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            -- 1. ADIM: Yakındaki malzemeleri otomatik pişir
            for _, item in pairs(workspace:GetDescendants()) do
                if item:FindFirstChild("Cookable") and (item.Position - character.HumanoidRootPart.Position).Magnitude < 15 then
                    local cookEvent = item:FindFirstChild("Cook") or item:FindFirstChild("RemoteEvent")
                    if cookEvent then
                        cookEvent:FireServer()
                    end
                end
            end
            
            -- 2. ADIM: Bitmiş burgerleri kasaya 'dokunmuş' gibi yap
            -- (Bazı sürümlerde bu otomatik satış sağlar)
            local register = workspace:FindFirstChild("CashRegister", true)
            if register then
                firetouchinterest(character.HumanoidRootPart, register, 0)
                task.wait(0.1)
                firetouchinterest(character.HumanoidRootPart, register, 1)
            end
        end)
    end
end)

print("--- BOT AKTİF: MUTFAKTA DURMAN YETERLİ ---")
